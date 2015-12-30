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
  pnl1.TabStop := True; //用于焦点能够从主From跳转到Dll中的From去，需响应OnEnter事件

  //动态增加服务方法一：此方法可以设置详细的服务描述信息
  sv := GServiceManager.GetService(SERVICE_INFO_ID) as IServiceInfo;
  sv.SetServiceID(IID_ExtPoint);
  sv.SetIsExtendPoint(True);
  sv.SetSingleton(False);  //在ExtendPoint模式下，设单例为真则扩展点只总是只保存一个实现者
  sv.SetActive(True);
  GServiceManager.RegService(sv);   

  //动态增加服务方法二：一条语句快速增加匿名服务，最少时只需填一个参数
  GServiceManager.AddServiceQuick(IID_AppInfo,'', TAppInfo, True, True);

  //DLL中的平面按钮浮起和平复是响应的OnMouseLeave和OnMouseEnter事件，DLL中没有
  //消息循环，因此，必需把事件送进去，带包编译的话，这些工作就不用做了，此处是
  //针对不带包编译的情况
  Application.OnMessage := OnMessageEvent;
end;

procedure TMainForm.OnMessageEvent(var Msg: TMsg; var Handled: Boolean);
var
  i, count: Integer;
  e: IExtendPointTest;
begin
  count := GServiceManager.GetExtServiceCount(IID_ExtPoint);
  //此处仅为演示需要这样写，实际上实现IExtendPointTest的已标明为单例，也就是只能
  //有一个实现者，但此处的写法演示如果有多个实现者下怎么进行多播。
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
  //获取扩展点接口，此扩展点用于显示一个DLL中的界面
  if not Assigned(GExt) then
    GExt := GServiceManager.GetExtService(IID_ExtPoint, 0) as IExtendPointTest;
  if Assigned(GExt) then
    pnl1.Tag := GExt.ShowUI(pnl1.Handle);  //pnl1.Tag中保存dll的Form的Handle
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
