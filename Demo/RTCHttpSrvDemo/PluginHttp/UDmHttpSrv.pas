UNIT UDmHttpSrv;

INTERFACE

USES
  SysUtils,
  Intf,
  Windows,
  Variants,
  WisdomFramework,
  WisdomCoreInterfaceForD,
  Classes,
  psAPI,
  md5,
  dialogs,
  TypInfo,
  UFrmHttpSrvSet,
  //rtc
  rtcdb,
  rtclog,
  rtcDataSrv,
  rtcInfo,
  rtcConn,
  rtcHttpSrv,
  pluginConst,
  pluginFun,
  //3TD
  Pooling,
  //UNIDAC
  uni,
  SQLiteUniProvider,
  SQLServerUniProvider,
  OracleUniProvider,
  MySQLUniProvider,
  UniProvider,
  ODBCUniProvider,
  AccessUniProvider;

TYPE
  TDmHttpSrv = CLASS(TDataModule)
    RtcHs: TRtcHttpServer;
    RtcDp: TRtcDataProvider;
    PROCEDURE RtcDpCheckRequest(Sender: TRtcConnection);
    PROCEDURE RtcDpDataReceived(Sender: TRtcConnection);
    PROCEDURE DataModuleCreate(Sender: TObject);
    PROCEDURE DataModuleDestroy(Sender: TObject);
    PROCEDURE RtcHsDataIn(Sender: TRtcConnection);
    PROCEDURE RtcHsDataOut(Sender: TRtcConnection);
  private
    { Private declarations }
    Fpool: TObjectPool;
    FTotalRequest, FTotalDataIn, FTotalDataOut, FTime: int64;

    PROCEDURE CreateQuery(Sender: TObject; VAR AObject: TObject);
    PROCEDURE DestroyQuery(Sender: TObject; VAR AObject: TObject);
    FUNCTION getSysInfo: RtcString;
    PROCEDURE ReqFile(Sender: TRtcConnection);
    PROCEDURE ReqPing(Sender: TRtcConnection);
    PROCEDURE ReqQry(Sender: TRtcConnection);
    PROCEDURE ReqSql(Sender: TRtcConnection);
    PROCEDURE ReqTables(Sender: TRtcConnection);
    PROCEDURE ReqUpdate(Sender: TRtcConnection);
  public
    { Public declarations }

    PROCEDURE StartSrv;
    PROCEDURE StopSrv;
  END;
  IPluginHttpSrv = INTERFACE(ISysPlugInExt)
    [IID_PluginHttpSrv]
  END;

  THttpSrv = CLASS(TPluginInterfacedObject, ISysPlugInExt, IPluginHttpSrv)
  private
    FDmHttpSrv: TDmHttpSrv;
    FFrmHttpSrvSet: TFrmHttpSrvSet;
  public
    CONSTRUCTOR Create; override;
    DESTRUCTOR Destroy; override;
    FUNCTION GetMenuCaption(): STRING;
    PROCEDURE ShowConfig();
    PROCEDURE StartSrv();
    PROCEDURE StopSrv();
  END;

VAR
  DmHttpSrv: TDmHttpSrv;

IMPLEMENTATION

{$R *.dfm}

{ THttpSrv }

VAR
  FFileList: TStrings;

CONSTRUCTOR THttpSrv.Create;
BEGIN
  INHERITED;
  xlog('建立HTTP服务');
  FDmHttpSrv := TDmHttpSrv.Create(NIL);
END;

DESTRUCTOR THttpSrv.Destroy;
BEGIN
  xlog('释放HTTP服务');
  FreeAndNil(FDmHttpSrv);
  INHERITED;
END;

FUNCTION THttpSrv.GetMenuCaption: STRING;
BEGIN
  Result := pluginMenu;
END;

PROCEDURE THttpSrv.ShowConfig;
BEGIN
  FFrmHttpSrvSet := TFrmHttpSrvSet.create(NIL);
  FFrmHttpSrvSet.ShowModal;
  FreeAndNil(FFrmHttpSrvSet);
END;

PROCEDURE THttpSrv.StartSrv;
BEGIN
  xlog('服务启动……');
  FDmHttpSrv.StartSrv;
END;

PROCEDURE THttpSrv.StopSrv;
BEGIN
  FDmHttpSrv.StopSrv;
  xlog('服务关闭');
END;

{ TDmHttpSrv }

PROCEDURE TDmHttpSrv.CreateQuery(Sender: TObject; VAR AObject: TObject);
VAR
  qry: TUniQuery;
  conn: TUniConnection;
BEGIN
  TRY
    conn := TUniConnection.Create(NIL);
    conn.ConnectString :=Format(GSysCfg.as_String['CONN'],[Stringreplace(GAppPath,'\','/',[rfReplaceAll])]);
    conn.Connect;
    qry := TUniQuery.Create(NIL);
    qry.Connection := conn;
    AObject := qry;
  EXCEPT
    ON e: exception DO
      xlog(e.message);
  END;
END;

PROCEDURE TDmHttpSrv.DestroyQuery(Sender: TObject; VAR AObject: TObject);
VAR
  qry: TUniQuery;
  conn: TUniConnection;
BEGIN
  qry := TUniQuery(AObject);
  conn := qry.Connection;
  FreeAndNil(qry);
  FreeAndNil(conn);
  AObject := NIL;
END;

PROCEDURE TDmHttpSrv.RtcDpCheckRequest(Sender: TRtcConnection);
BEGIN
  WITH TRtcHttpServer(sender) DO
    accept;
END;

PROCEDURE TDmHttpSrv.RtcDpDataReceived(Sender: TRtcConnection);
VAR
  rtc: TRtcRecord;
BEGIN
  WITH TRtcHttpServer(Sender), Request, Response DO
    BEGIN
      query.AddText(read());
      IF complete THEN
        BEGIN
          response.ContentType := 'application/x-javascript;charset=utf-8;';
          IF request.Value['Connection'] = 'keep-alive' THEN
            response.Value['Connection'] := 'keep-alive';
          IF query.Text = '' THEN
            query.Text := '{}';
          TRY
            rtc := TRtcRecord.FromJSON(url_decode(query.Text));
          EXCEPT
            write(JsonError('NOTJSON'));
            exit;
          END;
          request.Info.asRecord['REQ'] := rtc;
          IF (filename = '/REST') AND (method = 'GET') THEN
            reqQry(sender)
          ELSE
            IF (filename = '/REST') AND (method = 'POST') THEN
            reqsql(sender)
          ELSE
            IF filename = '/PING' THEN
            reqPing(sender)
          ELSE
            IF filename = '/SYS' THEN
            write(getSysInfo)
          ELSE
            IF filename = '/LISTTABLE' THEN
            ReqTables(sender)
          ELSE
            IF filename = '/UPDATE' THEN
            reqUpdate(sender)
          ELSE
            reqFile(sender);
          rtc.Kill;
        END;
    END;
END;

PROCEDURE TDmHttpSrv.DataModuleCreate(Sender: TObject);
BEGIN
  TRY
    LoadSysCfg;
    Fpool := TObjectPool.create();
    Fpool.OnCreateObject := CreateQuery;
    Fpool.OnDestroyObject := DestroyQuery;
    Fpool.AutoGrow := True;
    Fpool.PoolSize := 10;
    Fpool.GrowToSize := 100;

    FFileList := tstringlist.Create;
  EXCEPT
    ON e: Exception DO
      XLog('建立HTTP服务失败，异常：' + e.Message);
  END;
END;

PROCEDURE TDmHttpSrv.DataModuleDestroy(Sender: TObject);
BEGIN
  TRY
    FreeAndNil(FFileList);
    FreeAndNil(FPool);
  EXCEPT
    ON e: Exception DO
      XLog(e.Message);
  END;
END;

FUNCTION TDmHttpSrv.getSysInfo: RtcString;
VAR
  pmc: PPROCESS_MEMORY_COUNTERS;
  cb: Integer;
  SysInfo: TRtcRecord;
BEGIN
  SysInfo := TRtcRecord.Create;
  WITH SysInfo DO
    TRY
      asLargeInt['UsageCount'] := Fpool.UsageCount;
      asInteger['PoolSize'] := Fpool.PoolSize;
      asInteger['ConnectionCount'] := rtchs.TotalServerConnectionCount;
      asLargeInt['TotalDataIn'] := FtotalDataIn;
      asLargeInt['ServerTime'] := (gettickcount - FTime) DIV 1000;
      asLargeInt['TotalDataOut'] := FTotalDataOut;
      asLargeInt['TotalRequest'] := FTotalRequest;
      cb := SizeOf(_PROCESS_MEMORY_COUNTERS);
      GetMem(pmc, cb);
      pmc^.cb := cb;
      IF GetProcessMemoryInfo(GetCurrentProcess(), pmc, cb) THEN
        asLargeInt['MemoryUsed'] := pmc^.WorkingSetSize;
      FreeMem(pmc);
      result := SysInfo.toJSON;
    FINALLY
      SysInfo.Kill;
    END;
END;

PROCEDURE TDmHttpSrv.ReqFile(Sender: TRtcConnection);
VAR
  requri, ext: RtcString;
BEGIN
  WITH TRtcHttpServer(Sender) DO
    BEGIN
      IF GSysCfg.asBoolean['LogFile'] THEN
        XLog(request.FileName);
      requri := GetFileName(request.FileName);
      ext := uppercase(extractfileext(requri));
      IF NOT File_Exists(requri) THEN
        BEGIN
          Response.Status(404, 'File not found');
          Write('Status 404: File not found');
        END
      ELSE
        BEGIN
          Response.ContentType := GetContentType(requri);
          Write(Read_File(requri));
        END;
    END;
END;

PROCEDURE TDmHttpSrv.ReqPing(Sender: TRtcConnection);
BEGIN
  WITH TRtcHttpServer(Sender), request DO
    IF findSession(info.asrecord['REQ'].as_String['SID']) THEN
      write('1')
    ELSE
      write('0');
END;

PROCEDURE TDmHttpSrv.ReqQry(Sender: TRtcConnection);
VAR
  qry: TUniQuery;
  i: integer;
  rtc: TRtcValue;
BEGIN
  WITH TRtcHttpServer(Sender), request, query DO
    BEGIN
      qry := TUniQuery(Fpool.Acquire);

      WITH qry DO
        TRY
          TRY
            IF GSysCfg.asBoolean['LogRest'] THEN
              XLog(info.asrecord['REQ'].toJSON);
            SQL.Text := info.asrecord['REQ'].asString['SQL'];
            Prepared := true;
            FOR i := 0 TO Params.Count - 1 DO
              Params.FindParam(Params.Items[i].Name).Value := info.asrecord['REQ'].Value[Params.Items[i].Name];
            open;

            rtc := TRtcValue.Create;
            IF info.asrecord['REQ'].asString['RT'] = 'DS' THEN
              BEGIN
                DelphiDataSetToRtc(qry, rtc.NewDataSet);
                write(rtc.toJSON);
              END
            ELSE
              BEGIN
                DelphiDataSetToRtcArray(qry, rtc.NewArray);
                write(format('{"total":%d,"rows":%s}', [qry.RecordCount, rtc.toJSON]));
              END;
            close;
          EXCEPT
            ON e: exception DO
              BEGIN
                write(jsonerror(e.message));
                close;
              END;
          END;
        FINALLY
          Fpool.Release(qry);
        END;
    END;
END;

PROCEDURE TDmHttpSrv.ReqSql(Sender: TRtcConnection);
VAR
  qry: TUniQuery;
  i: integer;
BEGIN
  WITH TRtcHttpServer(Sender), request DO
    BEGIN
      qry := TUniQuery(FPool.Acquire);
      WITH qry, TRtcHttpServer(Sender), request DO
        TRY
          TRY
            IF GSysCfg.asBoolean['LogRest'] THEN
              XLog(info.asrecord['REQ'].toJSON);
            Transaction.StartTransaction;
            SQL.Text := Request.info.asrecord['REQ'].asString['SQL'];
            Prepared := true;
            FOR i := 0 TO qry.ParamCount - 1 DO
              BEGIN
                IF Request.info.asrecord['REQ'].Asstring[qry.Params.Items[i].Name] <> 'null' THEN
                  qry.Params.FindParam(qry.Params.Items[i].Name).asstring := Request.info.asrecord['REQ'].Asstring[qry.Params.Items[i].Name]
                ELSE
                  qry.Params.FindParam(qry.Params.Items[i].Name).Value := null;
              END;
            execsql;
            Transaction.Commit;

            write(format('%d', [RowsAffected]));
          EXCEPT
            ON e: exception DO
              BEGIN
                write(jsonerror(e.Message));
                Transaction.Rollback;
              END;
          END;
        FINALLY
          FPool.Release(qry);
        END;
    END;
END;

PROCEDURE TDmHttpSrv.StartSrv;
BEGIN
  IF RtcHs.isListening THEN
    StopSrv;
  WITH rtchs DO
    TRY
      ServerAddr := GSysCfg.as_string['ADDR'];
      ServerPort := GSysCfg.as_string['PORT'];
      IF NOT GSysCfg.asBoolean['LogIO'] THEN
        BEGIN
          OnDataOut := NIL;
          OnDataIn := NIL;
        END
      ELSE
        BEGIN
          OnDataOut := RtcHsDataOut;
          OnDataIn := RtcHsDataIn;
        END;
      FTime := GetTickCount;
      FTotalRequest := 0;
      FTotalDataIn := 0;
      FTotalDataOut := 0;
      FPool.Start();
      RtcHs.Listen;
    EXCEPT
      ON e: exception DO
        xlog('StartSrv:' + e.Message);
    END;
END;

PROCEDURE TDmHttpSrv.StopSrv;
BEGIN
  IF RtcHs.isListening THEN
    TRY
      RtcHs.StopListenNow;
      FPool.Stop();
    EXCEPT
      ON e: exception DO
        xlog('StartSrv:' + e.Message);
    END;
END;

PROCEDURE TDmHttpSrv.RtcHsDataIn(Sender: TRtcConnection);
BEGIN
  IF NOT Sender.inMainThread THEN
    Sender.Sync(RtcHsDataIn)
  ELSE
    FTotalDataIn := FTotalDataIn + Sender.DataIn;
END;

PROCEDURE TDmHttpSrv.RtcHsDataOut(Sender: TRtcConnection);
BEGIN
  IF NOT Sender.inMainThread THEN
    Sender.Sync(RtcHsDataOut)
  ELSE
    FTotalDataOut := FTotalDataOut + Sender.DataOut;
END;

PROCEDURE findplugin(CONST filename: STRING; CONST info: tsearchrec; VAR quit, bsub: boolean);
BEGIN
  FFileList.add(Format('%s=%s', [filename, FileToMD5(filename)]));
END;

PROCEDURE TDmHttpSrv.ReqUpdate(Sender: TRtcConnection);
VAR
  q: boolean;
BEGIN
  WITH TRtcHttpServer(Sender), request DO
    BEGIN
      FFileList.Clear;
      FindFile(q, GDocRoot + '\update\', '*.*', findplugin);
      Write(stringreplace(FFileList.Text, GDocRoot + '\update\', '', [rfReplaceAll]));
    END;
END;

PROCEDURE TDmHttpSrv.ReqTables(Sender: TRtcConnection);
VAR
  qry: TUniQuery;
  ts: tstrings;
BEGIN
  WITH TRtcHttpServer(Sender), request DO
    BEGIN
      qry := TUniQuery(FPool.Acquire);
      TRY
        ts := tstringlist.Create;
        qry.Connection.GetTableNames(ts);
        write(stringreplace(ts.Text, #13#10, ';', [rfReplaceAll]));
      FINALLY
        freeandnil(ts);
        FPool.Release(qry);
      END;
    END;
END;

INITIALIZATION
  startlog;
FINALIZATION
  stoplog;
END.

