UNIT Intf;
{$INCLUDE Def.inc}

INTERFACE

USES
  Windows,
  Classes,
  Forms,
  controls,
  db,
  rtcdb,
  rtcInfo,
  DBClient,
  MidasLib,
  SynCrtSock,
  SynWinSock,
  Graphics;

CONST
  IID_AppInfo       = '{AFBF4CC7-59FB-414E-1000-A4824C80C96A}';
  IID_ClientInfo    = '{AFBF4CC7-59FB-414E-2000-A4824C80C96A}';
  IID_SysPlugIn     = '{AFBF4CC7-59FB-414E-2001-A4824C80C96A}';
  IID_BusPlugIn     = '{AFBF4CC7-59FB-414E-2002-A4824C80C96A}';
  {$INCLUDE MyString.inc}

TYPE
  //客户端操作主程序接口
  IAppInfo = INTERFACE(IInterface)
    [IID_AppInfo]
    FUNCTION GetApplication: TApplication;
    FUNCTION GetMainForm: TForm;
    FUNCTION GetMainFormHandle: THandle;
    PROCEDURE CloseCurTab;              //调用此功能会关闭主窗口上当前的RzPageControl
  END;

  //客户端访问服务器插件数据接口
  IClientInfo = INTERFACE(IInterface)
    [IID_ClientInfo]
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
  //服务插件扩展点
  ISysPlugInExt = INTERFACE(IInterface)
    [IID_SysPlugIn]
    FUNCTION GetMenuCaption(): STRING;
    PROCEDURE ShowConfig();
    PROCEDURE StartSrv();
    PROCEDURE StopSrv();
  END;
  //业务功能插件扩展点
  IBusPlugInExt = INTERFACE(IInterface)
    [IID_BusPlugIn]
    FUNCTION GetMenuCaption(): STRING;
    FUNCTION GetMenuImageIndex(): integer;
    FUNCTION GetCaption(): STRING;
    PROCEDURE OnMessageEvent(VAR Msg: TMsg; VAR Handled: Boolean);
    FUNCTION ShowUI(CONST parentHWND: HWND): HWND;
  END;

IMPLEMENTATION

END.

