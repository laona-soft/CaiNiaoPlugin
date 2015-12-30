unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, XPMan, WisdomCoreInterfaceForD, StdCtrls;

type
  TMainForm = class(TForm)
    xpmnfst1: TXPManifest;
    lbl1: TLabel;
    lbl2: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Application.ShowMainForm := False;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  Visible := True;
  with GServiceManager.GetService(PLUGIN_MANAGER_ID) as IPluginManager do begin
    UnLoadPluginByPluginID('{86321E0F-9A55-426C-843F-A55036086617}');
  end;  
end;

end.
