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
  //ע��IAppInfo�ӿ�  �ͻ��˲����������ɴ˽ӿڵ���
  GServiceManager.AddServiceQuick(IID_AppInfo, '', TAppInfo, True, True);
  //ע��ISysPlugInExt�ӿ� �󶨷�����������չ�ӿ�
  GServiceManager.AddServiceQuick(IID_SysPlugIn, '', NIL, True, False, true);
  //ע��IBusPlugInExt�ӿ� ��ҵ����������չ�ӿ�
  GServiceManager.AddServiceQuick(IID_BusPlugIn, '', NIL, True, False, true);
  
  //����������
  Application.ShowMainForm := False;
  Application.CreateForm(TFrmMain, FrmMain);
  //��ʾ���ش���
  GAppPath := extractfilepath(paramstr(0));
  FrmSplash := TFrmSplash.Create(NIL);
  FrmSplash.Show;
  FrmSplash.free;
  Application.Run;
END.

