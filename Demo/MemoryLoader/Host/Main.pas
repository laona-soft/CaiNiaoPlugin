unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WisdomFramework, WisdomCoreInterfaceForD, XPMan;

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
    btn1: TButton;
    mmo1: TMemo;
    xpmnfst1: TXPManifest;
    btn2: TButton;
    btn3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
    FPluginID: String;
    FM: TMemoryStream;
  public
    { Public declarations }
    procedure Log(msg: PMyChar); stdcall;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

{ TForm1 }
function CreateILogFunc(const serviceM: IServiceManager; sv: IServiceInfo): IInterface;
begin
  Result := MainForm as ILog;
end;

procedure TMainForm.Log(msg: PMyChar);
begin
  mmo1.Lines.Append(msg);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FM := TMemoryStream.Create;
  GServiceManager.AddServiceQuick(IID_ILOG, '', CreateILogFunc);
  TWisdomFramework.Run;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  TWisdomFramework.Stop;
  FM.Free;
end;

procedure TMainForm.btn3Click(Sender: TObject);
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

procedure TMainForm.btn1Click(Sender: TObject);
begin
  FM.LoadFromFile(ExtractFilePath(ParamStr(0)) + '..\CPlus\CppPlugin.dll');
  with GServiceManager.GetService(PLUGIN_MANAGER_ID) as IPluginManager do begin
    LoadPluginDirect(MEMORY_FILE+IntToStr(Integer(FM.Memory)), '{B069A976-D69E-4935-813A-EB25528A1D25}');
    //新增加的插件总在列表中倒数第一个，此处获取CppPlugin.dll的插件ID，用于后面卸载使用
    FPluginID := GetPluginInfoByIndex(GetPluginsCount-1).GetPluginID; //{1B617B6F-E718-4dbf-8893-C3AB61ECD5B0}
  end;
  btn1.Enabled := False;
  btn2.Enabled := True;
  btn3.Enabled := True;
end;

procedure TMainForm.btn2Click(Sender: TObject);
begin
  with GServiceManager.GetService(PLUGIN_MANAGER_ID) as IPluginManager do begin
    UnLoadPluginByPluginID(FPluginID);
  end;
  FM.Clear;
  btn1.Enabled := True;
  btn2.Enabled := False;
  btn3.Enabled := False;
end;

end.
