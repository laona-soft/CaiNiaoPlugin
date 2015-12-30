UNIT ExportFunc;

INTERFACE

USES
  WisdomCoreInterfaceForD,
  intf,
  Dialogs,
  Forms;

FUNCTION DLLGetObject(CONST serviceID: PAnsiChar): IInterface; stdcall;
PROCEDURE DLLGetPluginInfo(CONST im: IPluginInfo); stdcall;
PROCEDURE DLLInitializePlugin(CONST IServiceMgr: IServiceManager); stdcall;
PROCEDURE DLLUninitializePlugin(CONST IServiceMgr: IServiceManager); stdcall;
PROCEDURE DLLServiceStart(CONST serviceID: PAnsiChar); stdcall;
PROCEDURE DLLServiceStop(CONST serviceID: PAnsiChar); stdcall;

EXPORTS
  DLLGetObject,
  DLLGetPluginInfo,
  DLLInitializePlugin,
  DLLUninitializePlugin,
  DLLServiceStart,
  DLLServiceStop;

VAR
  OldApplication    : TApplication;
  Gapp              : IAppInfo;
  GClient           : IClientInfo;

IMPLEMENTATION

USES
  UFrmClientTest,
  UGlobeClient,
  pluginConst;

FUNCTION DLLGetObject(CONST serviceID: PAnsiChar): IInterface; stdcall;
BEGIN
  Result := NIL;
END;

PROCEDURE DLLGetPluginInfo(CONST im: IPluginInfo); stdcall;
BEGIN
  im.SetAuthor(PluginAuthor);
  im.SetComment(PluginComment);
  im.SetPluginID(PluginID);
  im.SetPluginName(PlugInName);
  im.SetUpdateHistory('');
  im.SetVersion(PluginVer);
  WITH im.AppendServiceInfo(IID_HttpClientTest) DO
    BEGIN
      SetAuthor(PluginAuthor);
      SetComment(PluginComment);
      SetSingleton(True);
      SetServiceClass(THttpClientTest);
      SetServiceName('Http_Client服务测试');
      SetImplementServiceID(IID_BusPlugIn);
    END;

END;

PROCEDURE DLLInitializePlugin(CONST IServiceMgr: IServiceManager); stdcall;
BEGIN
  OldApplication := Application;
  IF IServiceMgr.ServiceIsActive(IID_AppInfo) THEN
    BEGIN
      Gapp := IServiceMgr.GetService(IID_AppInfo) AS IAppInfo;
      //注册HTTP服务器访问功能，如果不需要使用访问HTTP服务器的数据，可以不用注册此服务
      Gclient := GServiceManager.GetService(IID_ClientInfo) AS IClientInfo;
      IF NOT Assigned(Gclient) THEN
        BEGIN
          GServiceManager.AddServiceQuick(IID_ClientInfo, '', TClientInfo, True, True);
          GServiceManager.StartService(IID_ClientInfo);
          Gclient := GServiceManager.GetService(IID_ClientInfo) AS IClientInfo;
        END;
      Application := Gapp.GetApplication;
    END;
END;

PROCEDURE DLLUninitializePlugin(CONST IServiceMgr: IServiceManager); stdcall;
BEGIN
  Application := OldApplication;
END;

PROCEDURE DLLServiceStart(CONST serviceID: PAnsiChar); stdcall;
BEGIN
END;

PROCEDURE DLLServiceStop(CONST serviceID: PAnsiChar); stdcall;
BEGIN
END;

END.

