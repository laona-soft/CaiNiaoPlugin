unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan, WisdomCoreInterfaceForD;

const
  IID_Cpp_sort_demo = '{4208E4A4-F017-495a-81AA-D650DA613F02}';
  IID_ILOG = '{0E048007-252A-44D7-9536-DDFF813B7408}';

type
  ISortService = interface(IInterface)
  [IID_Cpp_sort_demo]
    procedure Sort(p: PInteger; len: Integer); stdcall;
    function GetVer(len: Integer): PMyChar; stdcall;
  end;

  ILog = interface(IInterface)
  [IID_ILOG]
    procedure Log(msg: PMyChar); stdcall;
  end;

  TMainForm = class(TForm, ILog)
    mmo1: TMemo;
    btn1: TButton;
    xpmnfst1: TXPManifest;
    mmo2: TMemo;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Log(msg: PMyChar); stdcall;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

function CreateILogFunc(const serviceM: IServiceManager; sv: IServiceInfo): IInterface;
begin
  Result := MainForm as ILog;
end;

procedure TMainForm.btn1Click(Sender: TObject);
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
  mmo1.Lines.Append(IntToStr(mmo1.Tag) + '、Host生成随机数，调用VC++插件的ISortService服务进行排序：');
  mmo1.Lines.Append(s);
  mmo1.Lines.Append('');

  iSort := GServiceManager.GetService(IID_Cpp_sort_demo) as ISortService;
  if Assigned(iSort) then
  iSort.Sort(@v[0], Length(v));
end;

procedure TMainForm.Log(msg: PMyChar);
begin
  mmo1.Lines.Append(msg);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  GServiceManager.AddServiceQuick(IID_ILOG, '', CreateILogFunc);
end;

end.
