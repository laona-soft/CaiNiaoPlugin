unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WisdomCoreInterfaceForD, StdCtrls, XPMan;

const
  IID_MyForm = '{9FC482C4-4A97-4070-918D-56FB15AE2AFC}';

type
  TMainForm = class(TForm)
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    xpmnfst1: TXPManifest;
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  IMyForm = interface
  [IID_MyForm]
    function GetForm: TForm;
  end;

  TMyForm = class(TPluginInterfacedObject, IMyForm)
  private
    FForm: TMainForm;
  public
    constructor Create; override;
    destructor Destroy; override;
    function GetForm: TForm;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

constructor TMyForm.Create;
begin
  inherited;
  FForm := TMainForm.Create(MainForm);
end;

destructor TMyForm.Destroy;
begin
  FForm.Free;
  inherited;
end;

function TMyForm.GetForm: TForm;
begin
  Result := FForm;
end;

procedure TMainForm.btn1Click(Sender: TObject);
begin
  GServiceManager.AddServiceQuick(IID_MyForm, '', TMyForm);
end;

procedure TMainForm.btn3Click(Sender: TObject);
begin
  if GServiceManager.ServiceIsActive(IID_MyForm) then
    with (GServiceManager.GetService(IID_MyForm) as IMyForm).GetForm do begin
      Position := poDefault;
      ShowModal;
    end;
end;

procedure TMainForm.btn2Click(Sender: TObject);
var
  sv: IServiceInfo;
begin
  sv := GServiceManager.GetService(SERVICE_INFO_ID) as IServiceInfo;
  sv.SetServiceID(IID_MyForm);
  sv.SetAuthor('Hello');
  sv.SetServiceClass(TMyForm);
  //sv.SetXXX¡£¡£¡£
  sv.SetActive(True);
  GServiceManager.RegService(sv);
end;

end.
