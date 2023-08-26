unit workshop.controller.impl.controller;

interface

uses
  workshop.controller.interfaces,
  workshop.controller.dto.interfaces;

type
  TController = class(TInterfacedObject, IController)
    private
      FUser: IUser;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IController;

      function User: IUser;
  end;

implementation

uses
  workshop.controller.dto.impl.user;

{ TController }

constructor TController.Create;
begin

end;

destructor TController.Destroy;
begin

  inherited;
end;

class function TController.New: IController;
begin
  Result := Self.Create;
end;

function TController.User: IUser;
begin
  if not Assigned(FUser) then
    FUser := TUserDTO.New;

  Result := FUser;
end;

end.
