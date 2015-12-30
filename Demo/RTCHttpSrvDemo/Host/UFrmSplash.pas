UNIT UFrmSplash;

INTERFACE

USES
  Windows,
  Intf,
  WisdomFramework,
  WisdomCoreInterfaceForD,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Menus,
  Dialogs,
  jpeg,
  ExtCtrls,
  StdCtrls;

TYPE
  TFrmSplash = CLASS(TForm)
    img: TImage;
    lbl2: TLabel;
    lbl_ver: TLabel;
    lbl_msg: TLabel;
    lbl_count: TLabel;
    PROCEDURE FormActivate(Sender: TObject);
    PROCEDURE FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  END;

VAR
  FrmSplash         : TFrmSplash;

IMPLEMENTATION

{$R *.dfm}
USES
  UGlobeSrv,
  UFrmMain;

PROCEDURE findplugin(CONST filename: STRING; CONST info: tsearchrec; VAR quit, bsub: boolean);
VAR
  i                 : Integer;
  pInfo             : IPluginInfo;
  sInfo             : IServiceInfo;
BEGIN
  GpluginManager.LoadPluginDirect(filename);
  pInfo := GpluginManager.GetPluginInfoByIndex(GpluginManager.GetPluginsCount - 1);
  IF pinfo <> NIL THEN
    BEGIN
      FOR i := 0 TO pInfo.GetServiceCount - 1 DO
        BEGIN
          sInfo := pInfo.GetServiceInfo(i);
          GServiceManager.AddServiceQuick(sInfo.GetServiceID, sInfo.GetImplementServiceID, sInfo.GetServiceClass, True, true);
        END;
    END;
END;

PROCEDURE TFrmSplash.FormActivate(Sender: TObject);
VAR
  q                 : boolean;
  i                 : Integer;
  sInfo             : IServiceInfo;
  SysPlugIn         : ISysPlugInExt;
  BusPlugIn         : IBusPlugInExt;
BEGIN
  GPlugInPath := GAppPath + 'plugin';
  IF GPlugInPath[Length(GPlugInPath)] <> '\' THEN
    GPlugInPath := GPlugInPath + '\';
  lbl_msg.Caption := '插件扫描开始';
  findfile(q, GPlugInPath, '*.*', findplugin, true, true);
  sleep(400);

  FOR i := 0 TO GServiceManager.GetExtServiceCount(IID_SysPlugIn) - 1 DO
    BEGIN
      Application.ProcessMessages();
      sleep(400);
      SysPlugIn := GServiceManager.GetExtService(IID_SysPlugIn, i) AS ISysPlugInExt;
      IF assigned(SysPlugIn) THEN
        BEGIN
          sInfo := GServiceManager.GetExtServiceInfo(IID_SysPlugIn, i);
          lbl_msg.Caption := '安装服务插件:' + sInfo.GetServiceName();
          installSysMenu(SysPlugIn.GetMenuCaption(), sInfo.GetImplementServiceID(), i);
        END;
    END;

  FOR i := 0 TO GServiceManager.GetExtServiceCount(IID_BusPlugIn) - 1 DO
    BEGIN
      Application.ProcessMessages;
      sleep(400);
      BusPlugIn := GServiceManager.GetExtService(IID_BusPlugIn, i) AS IBusPlugInExt;
      IF assigned(SysPlugIn) THEN
        BEGIN
          sInfo := GServiceManager.GetExtServiceInfo(IID_BusPlugIn, i);
          lbl_msg.Caption := '安装业务插件:' + sInfo.GetServiceName;
          InstallBusMenu(BusPlugIn.GetMenuCaption, sInfo.GetImplementServiceID, i, BusPlugIn.GetMenuImageIndex);
        END;
    END;

  sleep(400);
  lbl_count.Caption := format('扫描安装插件%d个', [GpluginManager.GetPluginsCount]);
  lbl_msg.caption := '插件扫描完成，系统准备就绪';
END;

PROCEDURE TFrmSplash.FormDestroy(Sender: TObject);
BEGIN
  Application.ShowMainForm := true;
END;

END.

