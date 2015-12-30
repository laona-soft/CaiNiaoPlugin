unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, WisdomCoreInterfaceForD, IntfCommon;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Edit1: TEdit;
    Edit2: TEdit;
    btn1: TButton;
    btn2: TButton;
    Bevel1: TBevel;
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  IMyExtendPoint = interface(IExtendPointTest)
  [IID_MyExtendPoint]
  end;

  TMyExtendPoint = class(TPluginInterfacedObject, IExtendPointTest, IMyExtendPoint)
  private
    Form2: TForm2;
    FMouseControl: TControl;
    function DoMouseIdle: TControl;
  public
    //必需要有Create和Destroy函数，这样对象创建时才能创建到TMyExtendPoint这一层
    constructor Create; override;
    destructor Destroy; override;
    procedure OnMessageEvent(var Msg: TMsg; var Handled: Boolean);
    function ShowUI(const parentHWND: HWND): HWND;
    function ShowUI2(const parent: TWinControl): HWND;
    function GetUIHandle: HWND;
  end;

var
  GForm2: TForm2 = nil;

implementation

{$R *.dfm}
procedure TForm2.Button1Click(Sender: TObject);
begin
  ShowMessage(Button1.Caption + '按钮被按下！');
  //Button1.SetFocus;
  GForm2.SetFocus;
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
  MessageBox(Handle, '平面按钮按下！', '成功了！', MB_OK OR MB_ICONINFORMATION);
  GForm2.SetFocus;
end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Perform(WM_NEXTDLGCTL, 0, 0);

  if (ssShift in Shift) AND (Key = VK_TAB) then
    Perform(WM_NEXTDLGCTL,1,0)
  else if Key = VK_Tab then
    Perform(WM_NEXTDLGCTL,0,0);
  SetFocus;

//  if (Key = VK_Tab) or (Key = VK_RETURN) then
//    SelectNext(ActiveControl,True,True);
//  Key := 0;
  //SendMessage(Handle, WM_NEXTDLGCTL, 0, 0);
end;

{ TExtendPointTest }

procedure TMyExtendPoint.OnMessageEvent(var Msg: TMsg;
  var Handled: Boolean);
var
  keyState: TKeyboardState;
  key: Word;
  cp: HWND;
begin
  //平台按钮浮起、扁平主要是对CN_MOSEENTER和CN_MOUSELEAVE的处理，这两个自定义
  //消息在Application.OnMessage中处理的，OnMessage在Idle时触发。
  if Msg.message = WM_KEYDOWN then begin
    if Assigned(Form2) then begin
      {if Msg.hwnd = Form2.ParentWindow then begin
        PostMessage(Form2.Handle, WM_KEYDOWN, VK_TAB, 0);
        Handled := True;
      end;}
      cp := Msg.hwnd;
      while cp <> 0 do begin
        if cp = Form2.Handle then begin
          key := Msg.wParam;
          GetKeyboardState(keyState);
          Form2.KeyDown(key, KeyboardStateToShiftState(keyState));
          if ((key=VK_Tab) or (key=VK_RETURN)) AND (not Form2.btn2.Focused) then
            Handled := True;
          Break;
        end else
          cp := GetParent(cp);
      end;
    end
  end;

  if Msg.Message <> WM_QUIT then
    DoMouseIdle;
end;

//这个函数就是平面按钮在鼠标移出时能恢复扁平的关键
function TMyExtendPoint.DoMouseIdle: TControl;
var
  CaptureControl: TControl;
  P: TPoint;
begin
  GetCursorPos(P);
  Result := FindDragTarget(P, True);
  CaptureControl := GetCaptureControl;

  if (FMouseControl <> Result) then
  begin
    if ((FMouseControl <> nil) and (CaptureControl = nil)) or
      ((CaptureControl <> nil) and (FMouseControl = CaptureControl)) then
        FMouseControl.Perform(CM_MOUSELEAVE, 0, 0);
    FMouseControl := Result;
    if ((FMouseControl <> nil) and (CaptureControl = nil)) or
      ((CaptureControl <> nil) and (FMouseControl = CaptureControl)) then
        FMouseControl.Perform(CM_MOUSEENTER, 0, 0);
  end;
end;

constructor TMyExtendPoint.Create;
begin
  inherited;
  Form2 := nil;
end;

destructor TMyExtendPoint.Destroy;
begin
  FreeAndNil(Form2);
  inherited;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  btn2.Left := -100;
end;

function TMyExtendPoint.ShowUI(const parentHWND: HWND): HWND;
begin
  FreeAndNil(Form2);

  Form2 := TForm2.CreateParented(parentHWND);
  Form2.ParentWindow := parentHWND;
  Form2.Left := 10;
  Form2.Top  := 10;
  Form2.Visible := true;
  Result := Form2.Handle;

  GForm2 := Form2;
end;

function TMyExtendPoint.ShowUI2(const parent: TWinControl): HWND;
begin
  FreeAndNil(Form2);

  Form2 := TForm2.Create(Application);
  Form2.Left := 10;
  Form2.Top  := 50;
  Form2.Visible := true;
  SetParent(Form2.Handle, parent.Handle);
  Result := Form2.Handle;
end;

function TMyExtendPoint.GetUIHandle: HWND;
begin
  Result := 0;
  if Assigned(Form2) then
    Result := Form2.Handle;
end;

procedure TForm2.btn1Click(Sender: TObject);
begin
  SelectNext(ActiveControl,True,True);
end;

end.
