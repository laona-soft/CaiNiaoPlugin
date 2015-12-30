PROGRAM Host;

USES
  FastMM4,
  Forms,
  SysUtils,
  UGlobeSrv,
  WisdomFramework,
  Intf,
  WisdomCoreInterfaceForD,
  UFrmMain IN 'UFrmMain.pas' {FrmMain},
  UFrmSplash IN 'UFrmSplash.pas' {FrmSplash},
  UFrmAbout IN 'UFrmAbout.pas' {FrmAbout};

{$R *.res}
{$R vistaAdm.RES}

BEGIN
  Application.Initialize;
  TWisdomFramework.run;
  //注册IAppInfo接口  客户端操作主程序由此接口调用
  GServiceManager.AddServiceQuick(IID_AppInfo, '', TAppInfo, True, True);
  //注册ISysPlugInExt接口 绑定服务插件到此扩展接口
  GServiceManager.AddServiceQuick(IID_SysPlugIn, '', NIL, True, False, true);
  //注册IBusPlugInExt接口 绑定业务插件到此扩展接口
  GServiceManager.AddServiceQuick(IID_BusPlugIn, '', NIL, True, False, true);
  
  //隐藏主界面
  Application.ShowMainForm := False;
  Application.CreateForm(TFrmMain, FrmMain);
  //显示加载窗口
  GAppPath := extractfilepath(paramstr(0));
  FrmSplash := TFrmSplash.Create(NIL);
  FrmSplash.Show;
  FrmSplash.free;
  Application.Run;
END.

