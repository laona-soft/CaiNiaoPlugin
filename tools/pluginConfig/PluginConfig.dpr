program PluginConfig;

uses
  {$IFDEF VER150}
  FastMM4,
  {$ENDIF}
  WisdomFramework,
  Forms,
  Main in 'Main.pas' {frmMain},
  CreatePlugin in 'CreatePlugin.pas' {frmCreatePlugin};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��������� (WisdomPluginFramework)';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
