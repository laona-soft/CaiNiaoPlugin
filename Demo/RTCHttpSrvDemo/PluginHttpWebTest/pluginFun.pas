UNIT pluginFun;

INTERFACE
USES
  SysUtils,
  IniFiles;

FUNCTION getServer: STRING;

IMPLEMENTATION

FUNCTION getServer: STRING;
BEGIN
  WITH TIniFile.Create(extractfilepath(ParamStr(0)) + '\client.ini') DO
    TRY
      result := 'http://' + ReadString('SYS', 'SERVER', '127.0.0.1') + ':' + ReadString('SYS', 'PORT', '80');
    FINALLY
      free;
    END;
END;

INITIALIZATION

FINALIZATION
END.

