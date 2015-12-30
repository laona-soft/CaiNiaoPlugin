unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WisdomFramework, WisdomCoreInterfaceForD, ServicesInterface, XPMan;

type
  TAppInfo = class(TPluginInterfacedObject, IAppInfo)
  public
    function GetApplication: TApplication;
    function GetMainForm: TForm;
    function GetMainFormHandle: THandle;
  end;


  TMainForm = class(TForm)
    xpmnfst1: TXPManifest;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

{ TAppInfo }

function TAppInfo.GetApplication: TApplication;
begin
  Result := Application;
end;

function TAppInfo.GetMainForm: TForm;
begin
  Result := MainForm;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  //��̬���ӷ��񷽷�����һ������������������������ʱֻ����һ������
  GServiceManager.AddServiceQuick(IID_AppInfo, '', TAppInfo, True, True);
  TWisdomFramework.Run;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //���������������ϼ��н�����صĶ�������һ��Ҫ������������ǰ������
  TWisdomFramework.Stop;
end;

function TAppInfo.GetMainFormHandle: THandle;
begin
  Result := MainForm.Handle;
end;

end.
