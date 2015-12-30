UNIT pluginFun;

INTERFACE
USES
  classes,
  windows,
  sysutils,
  strutils,
  Forms,
  rtclog,
  ShlObj,
  ActiveX,
  dialogs,
  rtcinfo;
TYPE
  TFindCallBack = PROCEDURE(CONST filename: STRING; CONST info: TSearchRec; VAR bQuit, bSub: boolean);

VAR
  GSysCfg, GDbCfg   : TRtcRecord;
  GAppPath, GDocRoot: RtcString;

FUNCTION JsonError(CONST msg: RtcString): RtcString;
PROCEDURE LoadSysCfg;
FUNCTION BytesToStr(CONST i64Size: int64): STRING;

FUNCTION GetFileName(CONST fn: STRING): STRING;
FUNCTION GetContentType(CONST fn: STRING): STRING;
FUNCTION ConvertTimeToTimestr(SS: int64): STRING;

PROCEDURE FindFile(VAR quit: boolean; CONST path: STRING; CONST filename: STRING = '*.*';
  proc: TFindCallBack = NIL; bSub: boolean = true; CONST bMsg: boolean = true);

IMPLEMENTATION

FUNCTION ConvertTimeToTimestr(SS: int64): STRING;
VAR
  D, H, M, S        : int64;
BEGIN
  d := SS DIV 86400;
  SS := SS MOD 86400;
  H := SS DIV 3600;
  SS := SS MOD 3600;
  m := SS DIV 60;
  SS := SS MOD 60;
  s := SS;

  IF d > 0 THEN
    result := Format('%dD %.2d:%.2d:%.2d', [d, h, m, s])
  ELSE
    result := Format('%.2d:%.2d:%.2d', [h, m, s]);
END;

FUNCTION BytesToStr(CONST i64Size: int64): STRING;
CONST
  i64GB             = 1073741824;
  i64MB             = 1048576;
  i64KB             = 1024;
BEGIN
  IF i64Size DIV i64GB > 0 THEN
    Result := Format('%.2fG', [i64Size / i64GB])
  ELSE
    IF i64Size DIV i64MB > 0 THEN
    Result := Format('%.2fM', [i64Size / i64MB])
  ELSE
    IF i64Size DIV i64KB > 0 THEN
    Result := Format('%.2fK', [i64Size / i64KB])
  ELSE
    Result := IntToStr(i64Size);
END;

PROCEDURE LoadSysCfg;
VAR
  ts                : TStrings;
BEGIN
  ts := TStringList.Create;
  TRY
    TRY
      ts.LoadFromFile(GAppPath + 'Server.Cfg');
      GSysCfg := TRtcRecord.FromJSON(stringreplace(ts.Text, #13#10, '', [rfReplaceAll]));
      // XLog(GSysCfg.toJSON);
    EXCEPT
      ON e: exception DO
        BEGIN
          Xlog(e.Message);
          halt;
        END;
    END;
  FINALLY
    freeandnil(ts);
  END;
END;

FUNCTION GetContentType(CONST fn: STRING): STRING;
VAR
  ext               : STRING;
BEGIN
  ext := UpperCase(ExtractFileExt(fn));
  Result := GSysCfg.as_string[ext];
END;

FUNCTION GetFileName(CONST fn: STRING): STRING;
BEGIN
  IF fn = '/' THEN
    result := Format('%s/index.html', [GDocRoot])
  ELSE
    result := Format('%s%s', [GDocRoot, fn]);
  IF Pos('?', result) > 0 THEN
    result := LeftStr(result,Pos('?', result));
  result := StringReplace(result, '../', '\', [rfReplaceAll]);
  result := StringReplace(result, '/', '\', [rfReplaceAll]);
  result := StringReplace(result, '\\', '\', [rfReplaceAll]);
END;

FUNCTION JsonError(CONST msg: RtcString): RtcString;
BEGIN
  result := format('{"ERR":"%s"}', [msg]);
END;

PROCEDURE FindFile(VAR quit: boolean; CONST path: STRING; CONST filename: STRING = '*.*';
  proc: TFindCallBack = NIL; bSub: boolean = true; CONST bMsg: boolean = true);
VAR
  fpath             : STRING;
  info              : TsearchRec;

  PROCEDURE ProcessAFile;
  BEGIN
    IF (info.Name <> '.') AND (info.Name <> '..') AND ((info.Attr AND faDirectory) <> faDirectory) THEN
      BEGIN
        IF assigned(proc) THEN
          proc(fpath + info.FindData.cFileName, info, quit, bsub);
      END;
  END;

  PROCEDURE ProcessADirectory;
  BEGIN
    IF (info.Name <> '.') AND (info.Name <> '..') AND ((info.attr AND fadirectory) = fadirectory) THEN
      findfile(quit, fpath + info.Name, filename, proc, bsub, bmsg);
  END;

BEGIN
  IF path[length(path)] <> '\' THEN
    fpath := path + '\'
  ELSE
    fpath := path;
  TRY
    IF 0 = findfirst(fpath + filename, faanyfile AND (NOT fadirectory), info) THEN
      BEGIN
        ProcessAFile;
        WHILE 0 = findnext(info) DO
          BEGIN
            ProcessAFile;
            IF bmsg THEN
              application.ProcessMessages;
            IF quit THEN
              BEGIN
                findclose(info);
                exit;
              END;
          END;
      END;
  FINALLY
    findclose(info);
  END;
  TRY
    IF bsub AND (0 = findfirst(fpath + '*', faanyfile, info)) THEN
      BEGIN
        ProcessADirectory;
        WHILE findnext(info) = 0 DO
          ProcessADirectory;
      END;
  FINALLY
    findclose(info);
  END;
END;

INITIALIZATION
  GAppPath := extractfilepath(ParamStr(0));
  GDocRoot := extractfilepath(ParamStr(0)) + 'WebRoot';
  StartLog;
FINALIZATION
  IF GSysCfg <> NIL THEN
    GSysCfg.Kill;
  IF GDbCfg <> NIL THEN
    GDbCfg.Kill;
  StopLog;
END.

