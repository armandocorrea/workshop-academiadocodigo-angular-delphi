unit workshop.model.service.interfaces;

interface

uses
  Data.DB,
  System.Generics.Collections;

type
  IService<T: Class> = interface
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

end.
