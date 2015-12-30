unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WisdomCoreInterfaceForD, StdCtrls, ExtCtrls, IntfCommon, XPMan;

type
  TForm1 = class(TForm)
    pnl1: TPanel;
    btn1: TButton;
    btn2: TButton;
    xpmnfst1: TXPManifest;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
    ITest: IBPLTest;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses WisdomFrame;

{$R *.dfm}

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin                
  btn2Click(btn2);
  TWisdomFramework.Stop;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  ITest := nil;
  ITest := GServiceManager.GetService(IID_BPLTest) as IBPLTest;
  pnl1.Tag := ITest.ShowUI(pnl1.Handle);
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  if Assigned(ITest) then
    ITest.CloseUI(pnl1.Tag);
  ITest := nil;
end;

end.
