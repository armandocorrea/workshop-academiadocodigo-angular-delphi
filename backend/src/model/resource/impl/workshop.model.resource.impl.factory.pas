unit workshop.model.resource.impl.factory;

interface

uses
  workshop.model.resource.interfaces;

type
  TResource = class(TInterfacedObject, IResource)
    private
      FConnection: IConnection;
      FConfiguration: IConfiguration;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IResource;

      function Connection: IConnection;
      function Configuration: IConfiguration;
  end;

implementation

uses
  workshop.model.resource.impl.conectionfiredac,
  workshop.model.resource.impl.configuration;

{ TResource }

function TResource.Configuration: IConfiguration;
begin
  Result := FConfiguration;
end;

function TResource.Connection: IConnection;
begin
  Result := FConnection;
end;

constructor TResource.Create;
begin
  FConfiguration := TConfiguration.New;
  FConnection := TConnection.New(FConfiguration);
end;

destructor TResource.Destroy;
begin

  inherited;
end;

class function TResource.New: IResource;
begin
  Result := Self.Create;
end;

end.
