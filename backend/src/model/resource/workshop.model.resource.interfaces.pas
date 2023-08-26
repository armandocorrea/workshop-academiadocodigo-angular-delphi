unit workshop.model.resource.interfaces;

interface

uses
  Data.DB;

type
  IConnection = interface
    function Connect: TCustomConnection;
  end;

  IConfiguration = interface
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

  IResource = interface
    function Connection: IConnection;
    function Configuration: IConfiguration;
  end;

implementation

end.
