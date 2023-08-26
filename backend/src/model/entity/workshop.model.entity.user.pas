unit workshop.model.entity.user;

interface

uses
  SimpleAttributes;

type
  [Tabela('usuario')]
  TUser = class
    private
      FId: Integer;
      FNome: String;
      FEmail: String;
      FSenha: String;

      function GetEmail: String;
      function GetId: Integer;
      function GetNome: String;
      function GetSenha: String;

      procedure SetEmail(const Value: String);
      procedure SetId(const Value: Integer);
      procedure SetNome(const Value: String);
      procedure SetSenha(const Value: String);
    public
      constructor Create;
      destructor Destroy; override;
      procedure Clear;

      [Campo('Id'), Pk, AutoInc]
      property Id: Integer    read GetId    write SetId;
      property Nome: String   read GetNome  write SetNome;
      property Email: String  read GetEmail write SetEmail;
      property Senha: String  read GetSenha write SetSenha;
  end;

implementation

{ TUser }

procedure TUser.Clear;
begin
  Id := 0;
  Nome := '';
  Email := '';
  Senha := '';
end;

constructor TUser.Create;
begin
  Self.Clear;
end;

destructor TUser.Destroy;
begin

  inherited;
end;

function TUser.GetEmail: String;
begin
  Result := FEmail;
end;

function TUser.GetId: Integer;
begin
  Result := FId;
end;

function TUser.GetNome: String;
begin
  Result := FNome;
end;

function TUser.GetSenha: String;
begin
  Result := FSenha;
end;

procedure TUser.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TUser.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TUser.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TUser.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

end.
