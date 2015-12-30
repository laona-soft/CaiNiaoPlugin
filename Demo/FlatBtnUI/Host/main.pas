unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, WisdomCoreInterfaceForD, IntfCommon,
  AppEvnts, XPMan;

type
  TAppInfo = class(TPluginInterfacedObject, IAppInfo)
  public
    function GetApplication: TApplication;
    function GetMainForm: TForm;
  end;

  TMainForm = class(TForm)
    LoadPluginBtn: TButton;
    pnl1: TPanel;
    UnLoadPluginBtn: TButton;
    lbl1: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    xpmnfst1: TXPManifest;
    procedure FormCreate(Sender: TObject);
    procedure LoadPluginBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pnl1Enter(Sender: TObject);
    procedure UnLoadPluginBtnClick(Sender: TObject);
  private
    { Private declarations }
    procedure OnMessageEvent(var Msg: TMsg; var Handled: Boolean);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  GExt: IExtendPointTest = nil;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var
  sv: IServiceInfo;
begin
  pnl1.TabStop := True; //���ڽ����ܹ�����From��ת��Dll�е�Fromȥ������ӦOnEnter�¼�

  //��̬���ӷ��񷽷�һ���˷�������������ϸ�ķ���������Ϣ
  sv := GServiceManager.GetService(SERVICE_INFO_ID) as IServiceInfo;
  sv.SetServiceID(IID_ExtPoint);
  sv.SetIsExtendPoint(True);
  sv.SetSingleton(False);  //��ExtendPointģʽ�£��赥��Ϊ������չ��ֻ����ֻ����һ��ʵ����
  sv.SetActive(True);
  GServiceManager.RegService(sv);   

  //��̬���ӷ��񷽷�����һ������������������������ʱֻ����һ������
  GServiceManager.AddServiceQuick(IID_AppInfo,'', TAppInfo, True, True);

  //DLL�е�ƽ�水ť�����ƽ������Ӧ��OnMouseLeave��OnMouseEnter�¼���DLL��û��
  //��Ϣѭ������ˣ�������¼��ͽ�ȥ����������Ļ�����Щ�����Ͳ������ˣ��˴���
  //��Բ�������������
  Application.OnMessage := OnMessageEvent;
end;

procedure TMainForm.OnMessageEvent(var Msg: TMsg; var Handled: Boolean);
var
  i, count: Integer;
  e: IExtendPointTest;
begin
  count := GServiceManager.GetExtServiceCount(IID_ExtPoint);
  //�˴���Ϊ��ʾ��Ҫ����д��ʵ����ʵ��IExtendPointTest���ѱ���Ϊ������Ҳ����ֻ��
  //��һ��ʵ���ߣ����˴���д����ʾ����ж��ʵ��������ô���жಥ��
  if count>0 then begin
    for i:=0 to count-1 do begin
       e := GServiceManager.GetExtService(IID_ExtPoint, i) as IExtendPointTest;
       if Assigned(e) then
         e.OnMessageEvent(Msg, Handled);
    end;
  end;
end;

{ TAppInfo }

function TAppInfo.GetApplication: TApplication;
begin
  Result := Application;
end;

function TAppInfo.GetMainForm: TForm;
begin
  Result := MainForm;
end;

procedure TMainForm.LoadPluginBtnClick(Sender: TObject);
begin
  //��ȡ��չ��ӿڣ�����չ��������ʾһ��DLL�еĽ���
  if not Assigned(GExt) then
    GExt := GServiceManager.GetExtService(IID_ExtPoint, 0) as IExtendPointTest;
  if Assigned(GExt) then
    pnl1.Tag := GExt.ShowUI(pnl1.Handle);  //pnl1.Tag�б���dll��Form��Handle
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  GExt := nil;
end;

procedure TMainForm.pnl1Enter(Sender: TObject);
begin
  if MainForm.pnl1.Tag>0 then begin
    PostMessage(pnl1.Tag, WM_KEYDOWN, VK_TAB, 0);
  end;
end;

procedure TMainForm.UnLoadPluginBtnClick(Sender: TObject);
var
  i: Integer;
begin
  GExt := nil;
  pnl1.Tag := 0;
  if GServiceManager.ServiceIsActive(PLUGIN_MANAGER_ID) then
    with GServiceManager.GetService(PLUGIN_MANAGER_ID) as IPluginManager do begin
      for i:=GetPluginsCount-1 downto 0 do
        UnLoadPluginByIndex(i);
    end;
end;

end.
