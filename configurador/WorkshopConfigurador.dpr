program WorkshopConfigurador;

uses
  Vcl.Forms,
  UfrmPrincipal in 'UfrmPrincipal.pas' {Form2},
  workshop.controller.configuration in 'workshop.controller.configuration.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
