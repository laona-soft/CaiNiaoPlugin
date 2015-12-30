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
  //�ͻ��˲���������ӿ�
  IAppInfo = INTERFACE(IInterface)
    [IID_AppInfo]
    FUNCTION GetApplication: TApplication;
    FUNCTION GetMainForm: TForm;
    FUNCTION GetMainFormHandle: THandle;
    PROCEDURE CloseCurTab;              //���ô˹��ܻ�ر��������ϵ�ǰ��RzPageControl
  END;

  //�ͻ��˷��ʷ�����������ݽӿ�
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
  //��������չ��
  ISysPlugInExt = INTERFACE(IInterface)
    [IID_SysPlugIn]
    FUNCTION GetMenuCaption(): STRING;
    PROCEDURE ShowConfig();
    PROCEDURE StartSrv();
    PROCEDURE StopSrv();
  END;
  //ҵ���ܲ����չ��
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

