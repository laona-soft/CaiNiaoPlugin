program Host;

uses
  WisdomFramework,
  Forms,
  Unit1 in 'Unit1.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  TWisdomFramework.Run;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
