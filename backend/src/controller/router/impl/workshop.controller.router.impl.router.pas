unit workshop.controller.router.impl.router;

interface

uses
  workshop.controller.router.interfaces;

type
  TRouter = class(TInterfacedObject, IRouter)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IRouter;

      function User: IRouter;
      function Login: IRouter;
  end;

implementation

uses
  workshop.controller.router.impl.login,
  workshop.controller.router.impl.user;

{ TRouter }

constructor TRouter.Create;
begin

end;

destructor TRouter.Destroy;
begin

  inherited;
end;

function TRouter.Login: IRouter;
begin
  Result := Self;
  LoginRegistry;
end;

class function TRouter.New: IRouter;
begin
  Result := Self.Create;
end;

function TRouter.User: IRouter;
begin
  Result := Self;
  UserRegistry;
end;

end.
