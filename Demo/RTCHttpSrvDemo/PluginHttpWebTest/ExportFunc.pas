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
  OldApplication: TApplication;
  Gapp: IAppInfo;
  
IMPLEMENTATION

USES
  UFrmWebTest,
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
  WITH im.AppendServiceInfo(IID_HttpWebTest) DO
    BEGIN
      SetAuthor(PluginAuthor);
      SetComment(PluginComment);
      SetSingleton(True);
      SetServiceClass(THttpWebTest);
      SetServiceName('HttpWeb·þÎñ²âÊÔ');
      SetImplementServiceID(IID_BusPlugIn);
    END;
END;

PROCEDURE DLLInitializePlugin(CONST IServiceMgr: IServiceManager); stdcall;
VAR
  app: IAppInfo;
BEGIN
  OldApplication := Application;
  IF IServiceMgr.ServiceIsActive(IID_AppInfo) THEN
    BEGIN
      app := IServiceMgr.GetService(IID_AppInfo) AS IAppInfo;
      Gapp:=app;
      Application := app.GetApplication;
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

