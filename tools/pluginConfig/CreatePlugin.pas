unit CreatePlugin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, SHELLAPI;

type
  TfrmCreatePlugin = class(TForm)
    edtPath: TEdit;
    btnBrowse: TBitBtn;
    lbl1: TLabel;
    btn1: TBitBtn;
    lbl3: TLabel;
    edt2: TEdit;
    SaveDialog1: TSaveDialog;
    mmo1: TMemo;
    procedure btnBrowseClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCreatePlugin: TfrmCreatePlugin;

implementation

{$R *.dfm}

function GetGUID: string;
var
  Guid: TGUID;
begin
  CreateGUID(Guid);
  Result := GUIDToString(Guid);
end;

procedure TfrmCreatePlugin.btnBrowseClick(Sender: TObject);
begin
  if SaveDialog1.Execute then begin
    edtPath.Text := SaveDialog1.FileName;
  end;
end;

procedure TfrmCreatePlugin.btn1Click(Sender: TObject);
var
  pos1, pos2: Integer;
  sl: TStringList;
  sTem1, sTem2: String;
begin
  if Trim(edt2.Text)='' then begin
    MessageBox(Handle, '������ӿ����ƣ���Test������Ҫ��I����ITest����', '��ʾ', MB_OK OR MB_ICONWARNING);
    Exit;
  end;

  sl := TStringList.Create;
  try
    //����dpr�ļ�
    pos1 := Pos('library %s;', mmo1.Text);
    pos2 := Pos('unit ServicesInterface;', mmo1.Text);
    sTem1 := ExtractFileName(edtPath.Text);
    sTem2 := Copy(sTem1, 1, Pos('.', sTem1)-1);
    sl.Text := Format(Copy(mmo1.Text, pos1, pos2-pos1), [sTem2]);
    sl.SaveToFile(edtPath.Text);

    //����ServicesInterface.pas
    pos1 := Pos('unit ServicesImplement;', mmo1.Text);
    sTem1 := 'IID_'+edt2.Text;
    sl.Text := Format(Copy(mmo1.Text, pos2, pos1-pos2), [sTem1, GetGUID, 'I'+edt2.Text, sTem1]);
    sl.SaveToFile(ExtractFilePath(edtPath.Text) + 'ServicesInterface.pas');

    //����ServicesImplement.pas
    pos2 := Pos('unit ExportFunc;', mmo1.Text);
    sl.Text := Format(Copy(mmo1.Text, pos1, pos2-pos1), ['T'+edt2.Text, 'I'+edt2.Text, 'T'+edt2.Text, 'T'+edt2.Text]);
    sl.SaveToFile(ExtractFilePath(edtPath.Text) + 'ServicesImplement.pas');

    //����ExportFunc.pas
    pos1 := Length(mmo1.Text)+1;
    sl.Text := Format(Copy(mmo1.Text, pos2, pos1-pos2), [GetGUID, sTem2, sTem1, 'T'+edt2.Text, 'I'+edt2.Text]);
    sl.SaveToFile(ExtractFilePath(edtPath.Text) + 'ExportFunc.pas');

    if MessageBox(Handle, '�����Ŀ�ѳɹ����ɣ��Ƿ�ת����Ŀ�����ļ��У�','��ʾ', MB_YESNO OR MB_ICONQUESTION)=IDYES then
      ShellExecute(Handle, 'explore', PChar(ExtractFilePath(edtPath.Text)), nil, nil, SW_SHOW);
    Close;  
  finally
    sl.Free;
  end;
end;

end.
