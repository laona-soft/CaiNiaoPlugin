unit SplashForm;
{$include Def.inc}

interface

uses
  {$IFDEF IDE_XE4up}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;
  {$ELSE}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, XPMan, WisdomCoreInterfaceForD, StdCtrls,
  pngimage;
  {$ENDIF}

type
  TfrmSplash = class(TForm)
    pnl1: TPanel;
    img1: TImage;
    lbl1: TLabel;
    bvl1: TBevel;
    mmo1: TMemo;
    lbl2: TLabel;
    lbl3: TLabel;
    mmo2: TMemo;
    tmr1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
  private
    { Private declarations }
    FDllInfo: array[0..9, 0..2] of String;
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  //模拟加载
  FDllInfo[0, 0] := 'Login';
  FDllInfo[0, 1] := 'Ver1.2';
  FDllInfo[0, 2] := 'E:\Work\2014\WisdomPluginFramework\Login.dll';
  FDllInfo[1, 0] := 'UserManager';
  FDllInfo[1, 1] := 'Ver1.5';
  FDllInfo[1, 2] := 'E:\Work\2014\WisdomPluginFramework\UserManager.dll';
  FDllInfo[2, 0] := 'ReportServer';
  FDllInfo[2, 1] := 'Ver2.3';
  FDllInfo[2, 2] := 'E:\Work\2014\WisdomPluginFramework\ReportServer.dll';
  FDllInfo[3, 0] := 'Skin';
  FDllInfo[3, 1] := 'Ver5.3';
  FDllInfo[3, 2] := 'E:\Work\2014\WisdomPluginFramework\Skin\Skin.dll';
  FDllInfo[4, 0] := 'HTTP Server';
  FDllInfo[4, 1] := 'Ver4.6';
  FDllInfo[4, 2] := 'E:\Work\2014\WisdomPluginFramework\HTTP\Http.dll';
  FDllInfo[5, 0] := 'DataModule';
  FDllInfo[5, 1] := 'Ver3.1';
  FDllInfo[5, 2] := 'E:\Work\2014\WisdomPluginFramework\DataModule.dll';
end;

procedure TfrmSplash.tmr1Timer(Sender: TObject);
begin
  //模拟加载
  if tmr1.Tag=0 then
    tmr1.Interval := 1000;
  mmo1.Lines.Add('正在加载插件：'
    + FDllInfo[tmr1.Tag, 0] + '  版本：'
     + FDllInfo[tmr1.Tag, 1] + '  文件：'
       + FDllInfo[tmr1.Tag,2]);
  tmr1.Tag := tmr1.Tag + 1;

  if tmr1.Tag=5 then begin
    tmr1.Enabled := False;
    mmo1.Lines.Add('共加载5个插件，全部插件加载完成！！！');
  end;

end;

end.
