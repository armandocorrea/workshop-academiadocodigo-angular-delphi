unit workshop.controller.dto.interfaces;

interface

uses
  workshop.model.service.interfaces,
  workshop.model.entity.user;

type
  IUser = interface
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

end.
