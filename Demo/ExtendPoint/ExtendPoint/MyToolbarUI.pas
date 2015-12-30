unit MyToolbarUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin, StdCtrls;

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    btn1: TToolButton;
    ToolButton1: TToolButton;
    mmo1: TMemo;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1 = nil;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
  ShowMessage('仅为扩展点演示，系统设置按钮被点击。');
end;

end.
