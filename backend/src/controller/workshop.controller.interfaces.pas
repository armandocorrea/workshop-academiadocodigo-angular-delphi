unit workshop.controller.interfaces;

interface

uses
  workshop.controller.dto.interfaces;

type
  IController = interface
    function User: IUser;
  end;

implementation

end.
