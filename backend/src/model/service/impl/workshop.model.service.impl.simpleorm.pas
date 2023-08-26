unit workshop.model.service.impl.simpleorm;

interface

uses
  SimpleInterface,
  Data.DB,
  System.Generics.Collections,

  workshop.model.service.interfaces,
  workshop.model.resource.interfaces;

type
  TSimpleORM<T: Class, constructor> = class(TInterfacedObject, IService<T>)
    private
      FParent: T;
      FConnection: IConnection;
      FConn: ISimpleQuery;
      FDAO: ISimpleDAO<T>;
      FDataSource: TDataSource;
    public
      constructor Create(aParent: T);
      destructor Destroy; override;
      class function New(aParent: T): IService<T>;

      function ListAll: IService<T>; overload;
      function ListAll(var aList: TObjectList<T>): IService<T>; overload;
      function ListAll(aField: String; aValue: Variant; var aList: TObjectList<T>): IService<T>; overload;

      function ListById(aId: Integer): IService<T>; overload;
      function ListById(aId: Integer; var aEntity: T): IService<T>; overload;

      function ListBy(aField: String; aValue: Variant): IService<T>;

      function Insert: IService<T>;
      function Update: IService<T>;
      function Delete: IService<T>; overload;
      function Delete(aField, aValue: String): IService<T>; overload;

      function DataSource(var aDataSource: TDataSource): IService<T>;
      function This: T;
  end;

implementation

uses
  SimpleDAO,
  SimpleQueryFiredac,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  workshop.model.resource.impl.factory, System.SysUtils;

{ TSimpleORM<T> }

constructor TSimpleORM<T>.Create(aParent: T);
begin
  FParent := aParent;

  FConnection := TResource.New.Connection;
  FConn := TSimpleQueryFiredac.New(TFDConnection(FConnection.Connect));

  FDataSource := TDataSource.Create(nil);
  FDAO := TSimpleDAO<T>.New(FConn).DataSource(FDataSource);
end;

function TSimpleORM<T>.DataSource(var aDataSource: TDataSource): IService<T>;
begin
  Result := Self;
  aDataSource := FDataSource;
end;

function TSimpleORM<T>.Delete: IService<T>;
begin
  Result := Self;
  FDAO.Delete(FParent);
end;

function TSimpleORM<T>.Delete(aField, aValue: String): IService<T>;
begin
  Result := Self;
  FDAO.Delete(aField, aValue);
end;

destructor TSimpleORM<T>.Destroy;
begin
  FreeAndNil(FDataSource);
  inherited;
end;

function TSimpleORM<T>.Insert: IService<T>;
begin
  Result := Self;
  FDAO.Insert(FParent);
end;

function TSimpleORM<T>.ListAll: IService<T>;
begin
  Result := Self;
  FDAO.SQL.OrderBy('ID');
  FDAO.Find(False);
end;

function TSimpleORM<T>.ListAll(var aList: TObjectList<T>): IService<T>;
begin
  Result := Self;
  FDAO.SQL.OrderBy('ID');
  FDAO.Find(aList);
end;

function TSimpleORM<T>.ListAll(aField: String; aValue: Variant;
  var aList: TObjectList<T>): IService<T>;
var
  xFiltro: String;
begin
  Result := Self;

  xFiltro := Format('%s = %s', [aField, aValue]);

  FDAO.SQL.Where(xFiltro);
  FDAO.SQL.OrderBy('ID');
  FDAO.Find(aList);
end;

function TSimpleORM<T>.ListBy(aField: String; aValue: Variant): IService<T>;
begin
  Result := Self;
  FDAO.Find(aField, aValue);
end;

function TSimpleORM<T>.ListById(aId: Integer; var aEntity: T): IService<T>;
begin
  Result := Self;
  aEntity := FDAO.Find(aId);
end;

function TSimpleORM<T>.ListById(aId: Integer): IService<T>;
begin
  Result := Self;
  FDAO.Find(aId);
end;

class function TSimpleORM<T>.New(aParent: T): IService<T>;
begin
  Result := Self.Create(aParent);
end;

function TSimpleORM<T>.This: T;
begin
  Result := FParent;
end;

function TSimpleORM<T>.Update: IService<T>;
begin
  Result := Self;
  FDAO.Update(FParent);
end;

end.
