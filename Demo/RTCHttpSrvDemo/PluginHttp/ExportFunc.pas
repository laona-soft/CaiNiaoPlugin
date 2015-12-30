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

IMPLEMENTATION

USES
  UDmHttpSrv,
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
  WITH im.AppendServiceInfo(IID_PluginHttpSrv) DO
    BEGIN
      SetAuthor(PluginAuthor);
      SetComment(PluginComment);
      SetSingleton(True);
      SetServiceClass(THttpSrv);
      SetServiceName('Http·þÎñ');
      SetImplementServiceID(IID_SysPlugIn);
    END;
END;

PROCEDURE DLLInitializePlugin(CONST IServiceMgr: IServiceManager); stdcall;
BEGIN
  OldApplication := Application;
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

