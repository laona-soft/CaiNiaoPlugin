program ToolbarExtPoint;

uses
  {$IFDEF VER150}
  FastMM4,
  {$ENDIF}
  Forms,
  Main in 'Main.pas' {MainForm},
  ServicesInterface in '..\ExtendPoint\ServicesInterface.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
