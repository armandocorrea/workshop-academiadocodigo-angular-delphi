unit workshop.controller.router.impl.login;

interface

uses
  Horse,
  JOSE.Core.JWT,
  JOSE.Core.Builder,

  System.SysUtils,
  System.JSON,
  Data.DB,

  workshop.controller.interfaces,
  workshop.controller.impl.controller;

procedure LoginRegistry;

implementation

procedure Autenticar(aReq: THorseRequest; aRes: THorseResponse; Next: TProc);
var
  xToken: TJWT;
  xCompactToken: String;
  xJSONLogin, xJSONAuth: TJSONObject;
  xUser, xPassword: String;
  xController: IController;
  xDataSource: TDataSource;
begin
  xToken := TJWT.Create;
  xController := TController.New;
  xDataSource := TDataSource.Create(nil);

  try
    //Token Claims
    xToken.Claims.Issuer     := 'WorkShop';
    xToken.Claims.Subject    := 'WorkShop Angular Delphi';
    xToken.Claims.Expiration := Now + 1;

    xJSONLogin := aReq.Body<TJSONObject>;

    if not Assigned(xJSONLogin) then
    begin
      aRes.Status(THTTPStatus.BadRequest);
      Exit;
    end;

    if not xJSONLogin.TryGetValue<String>('email', xUser) then
    begin
      aRes.Status(THTTPStatus.BadRequest);
      Exit;
    end;

    if not xJSONLogin.TryGetValue<String>('senha', xPassword) then
    begin
      aRes.Status(THTTPStatus.BadRequest);
      Exit;
    end;

    xController
      .User
      .Build
      .DataSource(xDataSource)
      .ListBy('email', xUser);

    if xDataSource.DataSet.RecordCount = 0 then
    begin
      aRes.Status(THTTPStatus.BadRequest);
      Exit;
    end;

    if xDataSource.DataSet.FieldByName('senha').AsString <> xPassword then
    begin
      aRes.Status(THTTPStatus.BadRequest);
      Exit;
    end;

    //Outros Claims
    xToken.Claims.SetClaimOfType<String>('email', xUser);

    //Assinatura
    xCompactToken := TJOSE.SHA256CompactToken('KeyWorkShop', xToken);

    xJSONAuth := TJSONObject.Create;
    xJSONAuth.AddPair('id', xDataSource.DataSet.FieldByName('id').AsString);
    xJSONAuth.AddPair('nome', xDataSource.DataSet.FieldByName('nome').AsString);
    xJSONAuth.AddPair('email', xDataSource.DataSet.FieldByName('email').AsString);
    xJSONAuth.AddPair('token', xCompactToken);

    aRes.Send<TJSONObject>(xJSONAuth);
  finally
    xToken.Free;
  end;
end;

procedure LoginRegistry;
begin
  THorse
    .Post('login', Autenticar);
end;

end.
