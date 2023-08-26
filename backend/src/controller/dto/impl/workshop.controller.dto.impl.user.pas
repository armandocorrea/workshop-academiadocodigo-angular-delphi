unit workshop.controller.dto.impl.user;

interface

uses
  workshop.controller.dto.interfaces,
  workshop.model.entity.user,
  workshop.model.service.interfaces;

type
  TUserDTO = class(TInterfacedObject, IUser)
    private
      FEntity: TUser;
      FService: IService<TUser>;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IUser;

      function Id(const aValue: Integer): IUser; overload;
      function Id: Integer; overload;

      function Nome(const aValue: String): IUser; overload;
      function Nome: String; overload;

      function Email(const aValue: String): IUser; overload;
      function Email: String; overload;

      function Senha(const aValue: String): IUser; overload;
      function Senha: String; overload;

      function Build: IService<TUser>;
  end;

implementation

uses
  workshop.model.service.impl.simpleorm,
  System.SysUtils;

{ TUserDTO }

function TUserDTO.Build: IService<TUser>;
begin
  Result := FService;
end;

constructor TUserDTO.Create;
begin
  FEntity  := TUser.Create;
  FService := TSimpleORM<TUser>.New(FEntity);
end;

destructor TUserDTO.Destroy;
begin
  FreeAndNil(FEntity);
  inherited;
end;

function TUserDTO.Email(const aValue: String): IUser;
begin
  Result := Self;
  FEntity.Email := aValue;
end;

function TUserDTO.Email: String;
begin
  Result := FEntity.Email;
end;

function TUserDTO.Id(const aValue: Integer): IUser;
begin
  Result := Self;
  FEntity.Id := aValue;
end;

function TUserDTO.Id: Integer;
begin
  Result := FEntity.Id;
end;

class function TUserDTO.New: IUser;
begin
  Result := Self.Create;
end;

function TUserDTO.Nome(const aValue: String): IUser;
begin
  Result := Self;
  FEntity.Nome := aValue;
end;

function TUserDTO.Nome: String;
begin
  Result := FEntity.Nome;
end;

function TUserDTO.Senha: String;
begin
  Result := FEntity.Senha;
end;

function TUserDTO.Senha(const aValue: String): IUser;
begin
  Result := Self;
  FEntity.Senha := aValue;
end;

end.
