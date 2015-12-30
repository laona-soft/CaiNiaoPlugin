UNIT UGlobeClient;

INTERFACE
USES
  windows,
  classes,
  sysutils,
  forms,
  Menus,
  dialogs,
  ShlObj,
  ResultCode,
  WisdomFramework,
  WisdomCoreInterfaceForD,
  Intf,
  db,
  rtcdb,
  rtcInfo,
  DBClient,
  MidasLib,
  SynCrtSock,
  SynWinSock,
  ActiveX;

TYPE
  TFindCallBack = PROCEDURE(CONST filename: STRING; CONST info: TSearchRec; VAR bQuit, bSub: boolean);

  TClientInfo = CLASS(TPluginInterfacedObject, IClientInfo)
  public
    FUNCTION OpenServer(CONST server, port: STRING): boolean;
    FUNCTION ServerRun(): boolean;
    PROCEDURE ServerPing();
    PROCEDURE getUpdateFiles(VAR filelist: tstrings);
    PROCEDURE getSystemInfo(VAR info: tstrings);
    PROCEDURE getTables(VAR tables: tstrings);
    PROCEDURE getFields(CONST table: STRING; VAR Fields: tstrings);
    FUNCTION ExecQry(CONST sql: STRING; VAR cds: Tclientdataset): Boolean; overload;
    FUNCTION ExecQry(CONST sql: STRING; VAR ds: TDataset): Boolean; overload;
    FUNCTION ExecSql(CONST sql: STRING): integer;
  END;

VAR
  GHc               : THttpClientSocket;
  GRun              : Boolean;

IMPLEMENTATION

FUNCTION TClientInfo.ExecQry(CONST sql: STRING; VAR ds: TDataset): Boolean;
VAR
  rtc               : TrtcValue;
BEGIN
  IF GHc.Get('/REST?{"SQL":"' + URL_Encode(sql) + '","RT":"DS"}', 5000) = 200 THEN
    BEGIN
      rtc := TrtcValue.FromJSON(GHc.Content);
      TRY
        IF rtc.isType = rtc_Exception THEN
          ShowMessage('服务器返回错误:' + rtc.asException)
        ELSE
          IF (rtc.isType = rtc_DataSet) AND Assigned(ds) THEN
          BEGIN
            RtcDataSetFieldsToDelphi(rtc.asDataSet, ds);
            RtcDataSetRowsToDelphi(rtc.asDataSet, ds);
          END;
        result := true;
      FINALLY
        rtc.Kill;
      END;
    END
  ELSE
    result := false;
END;

FUNCTION TClientInfo.ExecQry(CONST sql: STRING;
  VAR cds: Tclientdataset): Boolean;
VAR
  rtc               : TrtcValue;
BEGIN
  IF GHc.Get('/REST?{"SQL":"' + URL_Encode(sql) + '","RT":"DS"}', 5000) = 200 THEN
    BEGIN
      rtc := TrtcValue.FromJSON(GHc.Content);
      TRY
        TRY
          IF rtc.isType = rtc_Exception THEN
            ShowMessage('服务器返回错误:' + rtc.asException)
          ELSE
            IF (rtc.isType = rtc_DataSet) AND Assigned(cds) THEN
            BEGIN
              cds.Close;
              RtcDataSetFieldsToDelphi(rtc.asDataSet, cds);
              cds.CreateDataSet;
              RtcDataSetRowsToDelphi(rtc.asDataSet, cds);
            END;
          result := true;
        EXCEPT
          ON e: Exception DO
            ShowMessage(e.Message);
        END;
      FINALLY
        rtc.kill;
      END;
    END
  ELSE
    result := false;
END;

FUNCTION TClientInfo.ExecSql(CONST sql: STRING): integer;
VAR
  rtc               : TRtcValue;
BEGIN
  IF GHc.POST('/REST', '{"SQL":"' + URL_Encode(sql) + '"}', 'json', 5000) = 200 THEN
    BEGIN
      rtc := TrtcValue.FromJSON(GHc.Content);
      TRY
        IF rtc.isType = rtc_Exception THEN
          BEGIN
            ShowMessage('服务器返回错误:' + rtc.asException);
            result := 0;
          END
        ELSE
          result := rtc.asInteger;
      FINALLY
        rtc.kill;
      END;
    END
  ELSE
    result := 0;
END;

PROCEDURE timerfun(handle: Thandle; msg, identer: word;
  dwtime: longword);
BEGIN
  IF GHc.Get('/PING') = 200 THEN
    GRun := GHc.Content = '1';
END;

FUNCTION TClientInfo.OpenServer(CONST server, port: STRING): boolean;
BEGIN
  IF Assigned(GHc) THEN
    BEGIN
      result := True;
      exit;
    END;
  TRY
    GHc := OpenHttp(server, port);
    GRun := true;
    Result := true;
  EXCEPT
    Result := false;
  END;
END;

FUNCTION TClientInfo.ServerRun: boolean;
BEGIN
  result := GRun;
END;

PROCEDURE TClientInfo.ServerPing;
BEGIN
  IF GHc.Get('/PING') = 200 THEN
    GRun := GHc.Content = '1';
END;

PROCEDURE TClientInfo.getUpdateFiles(VAR filelist: tstrings);
VAR
  ts                : Tstrings;
  i                 : Integer;
BEGIN
  IF GHc.Get('/UPDATE') = 200 THEN
    BEGIN
      ts := tstringList.create();
      TRY
        ts.Delimiter := ';';
        ts.DelimitedText := GHc.Content;
        FOR i := 0 TO ts.count - 1 DO
          filelist.add(ts.strings[i]);
      FINALLY
        freeandnil(ts);
      END;
    END;
END;

PROCEDURE TClientInfo.getSystemInfo(VAR info: tstrings);
VAR
  rtc               : Trtcvalue;
  i                 : Integer;
BEGIN
  IF GHc.Get('/SYS') = 200 THEN
    BEGIN
      rtc := Trtcvalue.FromJSON(GHc.Content);
      TRY
        WITH rtc.asRecord DO
          FOR i := 0 TO FieldCount - 1 DO
            info.Values[FieldName[i]] := Value[FieldName[i]];
      FINALLY
        rtc.kill;
      END;
    END;
END;

PROCEDURE TClientInfo.getTables(VAR tables: tstrings);
VAR
  ts                : Tstrings;
  i                 : Integer;
BEGIN
  IF GHc.Get('/LISTTABLE') = 200 THEN
    BEGIN
      ts := tstringList.create();
      TRY
        ts.Delimiter := ';';
        ts.DelimitedText := GHc.Content;
        FOR i := 0 TO ts.count - 1 DO
          tables.add(ts.strings[i]);
      FINALLY
        freeandnil(ts);
      END;
    END;
END;

PROCEDURE TClientInfo.getFields(CONST table: STRING; VAR Fields: tstrings);
VAR
  ts                : Tstrings;
  i                 : Integer;
BEGIN
  IF GHc.Get('/LISTFIELDS?{"tab":"' + table + '"}') = 200 THEN
    BEGIN
      ts := tstringList.create();
      TRY
        ts.Delimiter := ';';
        ts.DelimitedText := GHc.Content;
        FOR i := 0 TO ts.count - 1 DO
          Fields.add(ts.strings[i]);
      FINALLY
        freeandnil(ts);
      END;
    END;
END;

INITIALIZATION

FINALIZATION

END.

