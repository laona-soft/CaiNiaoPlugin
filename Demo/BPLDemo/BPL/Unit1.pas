unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls, Buttons, WisdomCoreInterfaceForD, IntfCommon;

const
  IID_Cpp_sort_demo = '{4208E4A4-F017-495a-81AA-D650DA613F02}';
  IID_ILOG = '{0E048007-252A-44D7-9536-DDFF813B7408}';

type
  ISortService = interface(IInterface)
  [IID_Cpp_sort_demo]
    procedure Sort(p: PInteger; len: Integer); stdcall;
    function GetVer(len: Integer): PChar; stdcall;
  end;

  ILog = interface(IInterface)
  [IID_ILOG]
    procedure Log(msg: PChar); stdcall;
  end;

  TForm1 = class(TForm, ILog)
    btn1: TSpeedButton;
    btn2: TButton;
    chk1: TCheckBox;
    rb1: TRadioButton;
    mmo1: TMemo;
    btn3: TButton;
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Log(msg: PChar); stdcall;
  public
    { Public declarations }
  end;

  TBPLTest = class(TPluginInterfacedObject, IBPLTest)
    function ShowUI(const parentHWND: HWND): HWND;
    procedure CloseUI(const uiHWND: HWND);  
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TBPLTest }

procedure TBPLTest.CloseUI(const uiHWND: HWND);
begin
  if Assigned(Form1) and (Form1.Handle = uiHWND) then
    FreeAndNil(Form1);
end;

function TBPLTest.ShowUI(const parentHWND: HWND): HWND;
begin
  FreeAndNil(Form1);
  //以下句可用于异构编译器的结果，如VC的EXE + XE5的DLL
  Form1 := TForm1.CreateParented(parentHWND);
  Form1.ParentWindow := parentHWND;
  Form1.Left := 20;
  Form1.Top  := 20;
  Form1.Visible := true;
  Form1.Show;
  Result := Form1.Handle;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  MessageBox(Handle, '格式化D盘完成！！！', '完成提示', MB_OK OR MB_ICONINFORMATION);
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  MessageBox(Handle, '权钱名利和身体终究消散为一抔黄土，人生为此而累实是无意义。', '人生话题', MB_OK OR MB_ICONINFORMATION);
end;

procedure TForm1.btn3Click(Sender: TObject);
var
  i: Integer;
  s: String;
  v: array[0..9] of Integer;
  iSort: ISortService;
begin
  Randomize;
  for i:=0 to 9 do
    v[i] := Random(100);

  for i:=0 to 9 do
    s := s + IntToStr(v[i]) + '   ';

  mmo1.Tag := mmo1.Tag + 1;
  mmo1.Lines.Append(IntToStr(mmo1.Tag) + '、BPL窗口生成随机数，调用VC++插件的ISortService服务进行排序：');
  mmo1.Lines.Append(s);
  mmo1.Lines.Append('');

  iSort := GServiceManager.GetService(IID_Cpp_sort_demo) as ISortService;
  if Assigned(iSort) then
  iSort.Sort(@v[0], Length(v));
end;

procedure TForm1.Log(msg: PChar);
begin
  mmo1.Lines.Append(msg);
end;

function CreateILogFunc(const serviceM: IServiceManager; sv: IServiceInfo): IInterface;
begin
  Result := Form1 as ILog;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  GServiceManager.AddServiceQuick(IID_ILOG, '', CreateILogFunc);
end;

initialization

finalization


end.
