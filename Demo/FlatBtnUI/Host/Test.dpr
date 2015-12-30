program Test;

uses
  {$IFDEF VER150}
  FastMM4,
  {$ENDIF}
  WisdomFramework,
  Forms,
  main in 'main.pas' {MainForm},
  IntfCommon in '..\Dll\IntfCommon.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
