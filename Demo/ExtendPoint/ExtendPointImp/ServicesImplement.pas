unit ServicesImplement;
{$include Def.inc}

interface

uses
  {$IFDEF IDE_XE4up}
  winapi.Windows, System.Classes, Vcl.Dialogs, Vcl.Graphics,
  {$ELSE}
  Windows, Classes, Dialogs, Graphics,
  {$ENDIF}
  WisdomCoreInterfaceForD, ServicesInterface;

{$include MyString.inc}

type
  TExtToolButton = class(TPluginInterfacedObject, IExtToolButton)
  private
    procedure OnClick(Sender: TObject);
  public
    function GetCaption: MyString;
    procedure GetBitmap(bmp: HDC);
    function GetClickEvent: TNotifyEvent;
  end;

implementation

{$R bird.RES}

{ TExtToolButton }

procedure TExtToolButton.GetBitmap(bmp: HDC);
var
  bmp1: TBitmap;
begin
  bmp1 := TBitmap.Create;
  bmp1.LoadFromResourceName(HInstance, 'MyBird');
  BitBlt(bmp, 0, 0, 48, 48, bmp1.Canvas.Handle, 0, 0, SRCCOPY);
  bmp1.Free;
end;

function TExtToolButton.GetCaption: MyString;
begin
  Result := '扩展实现'
end;

function TExtToolButton.GetClickEvent: TNotifyEvent;
begin
  Result := OnClick;
end;

procedure TExtToolButton.OnClick(Sender: TObject);
begin
  ShowMessage('正确点击，点击事件的处理由第三方插件extPointImp.dll实现！');
end;

end.

