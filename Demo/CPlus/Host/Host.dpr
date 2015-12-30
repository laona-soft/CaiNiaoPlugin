program Host;

uses
  {$IFDEF VER150}
  FastMM4,
  {$ENDIF}
  WisdomFramework,
  Forms,
  Main in 'Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  TWisdomFramework.Run;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
