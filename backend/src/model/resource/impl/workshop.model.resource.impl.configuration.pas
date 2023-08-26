unit workshop.model.resource.impl.configuration;

interface

uses
  workshop.model.resource.interfaces;

type
  TConfiguration = class(TInterfacedObject, IConfiguration)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IConfiguration;

      function DriverID(const aValue: String): IConfiguration; overload;
      function DriverID: String; overload;

      function Database(const aValue: String): IConfiguration; overload;
      function Database: String; overload;

      function Username(const aValue: String): IConfiguration; overload;
      function Username: String; overload;

      function Password(const aValue: String): IConfiguration; overload;
      function Password: String; overload;

      function Port(const aValue: String): IConfiguration; overload;
      function Port: String; overload;

      function Server(const aValue: String): IConfiguration; overload;
      function Server: String; overload;

      function Schema(const aValue: String): IConfiguration; overload;
      function Schema: String; overload;
  end;

implementation

uses
  LocalCache4D;

{ TConfiguration }

constructor TConfiguration.Create;
begin
  LocalCache.LoadDataBase('WorkshopAngularDelphi.lc4');
end;

function TConfiguration.Database(const aValue: String): IConfiguration;
begin
  Result := Self;
  LocalCache.SetItem('Database', aValue);
end;

function TConfiguration.Database: String;
begin
  Result := LocalCache.GetItem('Database');
end;

destructor TConfiguration.Destroy;
begin
  LocalCache.SaveToStorage('WorkshopAngularDelphi.lc4');
  inherited;
end;

function TConfiguration.DriverID: String;
begin
  Result := LocalCache.GetItem('DriverID');
end;

function TConfiguration.DriverID(const aValue: String): IConfiguration;
begin
  Result := Self;
  LocalCache.SetItem('DriverID', aValue);
end;

class function TConfiguration.New: IConfiguration;
begin
  Result := Self.Create;
end;

function TConfiguration.Password(const aValue: String): IConfiguration;
begin
  Result := Self;
  LocalCache.SetItem('Password', aValue);
end;

function TConfiguration.Password: String;
begin
  Result := LocalCache.GetItem('Password');
end;

function TConfiguration.Port(const aValue: String): IConfiguration;
begin
  Result := Self;
  LocalCache.SetItem('Port', aValue);
end;

function TConfiguration.Port: String;
begin
  Result := LocalCache.GetItem('Port');
end;

function TConfiguration.Schema: String;
begin
  Result := LocalCache.GetItem('Schema');
end;

function TConfiguration.Schema(const aValue: String): IConfiguration;
begin
  Result := Self;
  LocalCache.SetItem('Schema', aValue);
end;

function TConfiguration.Server(const aValue: String): IConfiguration;
begin
  Result := Self;
  LocalCache.SetItem('Server', aValue);
end;

function TConfiguration.Server: String;
begin
  Result := LocalCache.GetItem('Server');
end;

function TConfiguration.Username: String;
begin
  Result := LocalCache.GetItem('Username');
end;

function TConfiguration.Username(const aValue: String): IConfiguration;
begin
  Result := Self;
  LocalCache.SetItem('Username', aValue);
end;

end.
