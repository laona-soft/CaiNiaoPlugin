program Host;

uses
  CaiNiaoFrame,
  Forms,
  Main in 'Main.pas' {Form1},
  IntfCommon in '..\BPL\IntfCommon.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := Boolean(DebugHook);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
