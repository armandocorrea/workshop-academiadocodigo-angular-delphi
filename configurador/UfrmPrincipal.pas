unit UfrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.PGDef,
  FireDAC.Phys.PG;

type
  TForm2 = class(TForm)
    edtDriverID: TEdit;
    edtDatabase: TEdit;
    edtUsername: TEdit;
    edtPassword: TEdit;
    edtPort: TEdit;
    edtServer: TEdit;
    edtSchema: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    btnGravar: TButton;
    btnTestar: TButton;
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    procedure btnGravarClick(Sender: TObject);
    procedure btnTestarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses workshop.controller.configuration;

procedure TForm2.btnGravarClick(Sender: TObject);
var
  xConfiguration: TConfiguration;
begin
  xConfiguration := TConfiguration.Create;
  try
    xConfiguration.DriverID := edtDriverID.Text;
    xConfiguration.Database := edtDatabase.Text;
    xConfiguration.Username := edtUsername.Text;
    xConfiguration.Password := edtPassword.Text;
    xConfiguration.Port     := edtPort.Text;
    xConfiguration.Server   := edtServer.Text;
    xConfiguration.Schema   := edtSchema.Text;

    xConfiguration.SaveConfiguration;

    ShowMessage('Configurações gravadas com sucesso!');
  finally
    FreeAndNil(xConfiguration);
  end;
end;

procedure TForm2.btnTestarClick(Sender: TObject);
begin
  try
    FDConnection1.Params.Clear;
    FDConnection1.Params.DriverID := edtDriverID.Text;
    FDConnection1.Params.Database := edtDatabase.Text;
    FDConnection1.Params.UserName := edtUsername.Text;
    FDConnection1.Params.Password := edtPassword.Text;
    FDConnection1.Params.Add('Port=' + edtPort.Text);
    FDConnection1.Params.Add('Server=' + edtServer.Text);

    if edtSchema.Text <> EmptyStr then
    begin
      FDConnection1.Params.Add('MetaCurSchema=' + edtSchema.Text);
      FDConnection1.Params.Add('MetaDefSchema=' + edtSchema.Text);
    end;

    FDConnection1.Connected := True;
    if FDConnection1.Connected then
    begin
      ShowMessage('Conectado com sucesso!');
      FDConnection1.Connected := False;
    end
    else
      raise Exception.Create('Revise as configurações.');
  except
    on e: Exception do
      raise Exception.Create('Não foi possível realizar a conexão: ' + E.Message);
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  xConfiguration: TConfiguration;
begin
  xConfiguration := TConfiguration.Create;
  try
    xConfiguration.LoadConfiguration;

    edtDriverID.Text := xConfiguration.DriverID;
    edtDatabase.Text := xConfiguration.Database;
    edtUsername.Text := xConfiguration.Username;
    edtPassword.Text := xConfiguration.Password;
    edtPort.Text     := xConfiguration.Port;
    edtServer.Text   := xConfiguration.Server;
    edtSchema.Text   := xConfiguration.Schema;
  finally
    FreeAndNil(xConfiguration);
  end;
end;

end.
