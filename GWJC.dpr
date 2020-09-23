program GWJC;

uses
  Vcl.Forms,
  UI in 'Source\UI.pas' {Form_UI},
  UI_LineSetting in 'Source\UI_LineSetting.pas' {Form_LineSetting},
  sfContnrs in 'Source\sfContnrs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_UI, Form_UI);
  Application.CreateForm(TForm_LineSetting, Form_LineSetting);
  Application.Run;
end.
