unit workshop.controller.router.impl.user;

interface

uses
  Horse,
  Neon.Core.Persistence,
  Neon.Core.Persistence.JSON,
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,

  workshop.controller.interfaces,
  workshop.model.entity.user,

  workshop.controller.impl.controller;

procedure UserRegistry;

implementation

procedure ListAll(aReq: THorseRequest; aRes: THorseResponse);
var
  xController: IController;
  xUsers: TObjectList<TUser>;
begin
  xController := TController.New;
  xUsers := TObjectList<TUser>.Create;

  xController
    .User
    .Build
    .ListAll(xUsers);

  if xUsers.Count > 0 then
    aRes.Send(TNeon.ObjectToJSON(xUsers,
              TNeonConfiguration.Default.SetUseUTCDate(False)))
  else
    aRes.Send('').Status(THTTPStatus.NoContent);
end;

procedure ListById(aReq: THorseRequest; aRes: THorseResponse);
var
  xController: IController;
  xId: Integer;
  xUser: TUser;
begin
  xController := TController.New;

  if (aReq.Params.Count <> 1) or (not(aReq.Params.ContainsKey('id'))) then
  begin
    aRes.Status(THTTPStatus.BadRequest);
    Exit;
  end;

  xId := StrToIntDef(aReq.Params.Items['id'], 0);

  xController
    .User
    .Id(xId)
    .Build
    .ListById(xId, xUser);

  if xUser.Id > 0 then
    aRes.Send(TNeon.ObjectToJSON(xUser,
              TNeonConfiguration.Default.SetUseUTCDate(False)))
  else
    aRes.Send('').Status(THTTPStatus.NoContent);
end;

procedure Insert(aReq: THorseRequest; aRes: THorseResponse);
var
  xController: IController;
  xJsonObject: TJSONObject;
  xUser: TUser;
begin
  xController := TController.New;

  try
    xJsonObject := aReq.Body<TJSONObject>;
    xUser := TNeon.JSONToObject<TUser>(xJsonObject.ToString);

    try
      xController
        .User
        .Nome(xUser.Nome)
        .Email(xUser.Email)
        .Senha(xUser.Senha)
        .Build
        .Insert;

      aRes.Send('{}').Status(THTTPStatus.Created);
    finally
      FreeAndNil(xUser);
    end;
  except
    on e: Exception do
      aRes.Send(e.Message).Status(THTTPStatus.InternalServerError);
  end;
end;

procedure Update(aReq: THorseRequest; aRes: THorseResponse);
var
  xController: IController;
  xJsonObject: TJSONObject;
  xId: Integer;
  xUser, xUserBase: TUser;
begin
  xController := TController.New;

  try
    if (aReq.Params.Count <> 1) or (not(aReq.Params.ContainsKey('id'))) then
    begin
      aRes.Status(THTTPStatus.BadRequest);
      Exit;
    end;

    xJsonObject := aReq.Body<TJSONObject>;
    xId         := StrToIntDef(aReq.Params.Items['id'], 0);
    xUser       := TNeon.JSONToObject<TUser>(xJsonObject.ToString);

    try
      //Buscar Registro Atual na Base
      xController
        .User
        .Id(xId)
        .Build
        .ListById(xId, xUserBase);

      //Montar Atualização
      xController
        .User
        .Id(xId);

      xController.User.Nome(xUserBase.Nome);
      if not xUser.Nome.IsEmpty then
        xController.User.Nome(xUser.Nome);

      xController.User.Email(xUserBase.Email);
      if not xUser.Email.IsEmpty then
        xController.User.Email(xUser.Email);

      xController.User.Senha(xUserBase.Senha);
      if not xUser.Senha.IsEmpty then
        xController.User.Senha(xUser.Senha);

      xController
        .User
        .Build
        .Update;

      aRes.Send('').Status(THTTPStatus.Accepted);
    finally
      FreeAndNil(xUser);
    end;
  except
    on e: Exception do
      aRes.Send(e.Message).Status(THTTPStatus.InternalServerError);
  end;
end;

procedure Delete(aReq: THorseRequest; aRes: THorseResponse);
var
  xController: IController;
  xId: Integer;
begin
  xController := TController.New;

  if (aReq.Params.Count <> 1) or (not(aReq.Params.ContainsKey('id'))) then
  begin
    aRes.Status(THTTPStatus.BadRequest);
    Exit;
  end;

  xId := StrToIntDef(aReq.Params.Items['id'], 0);

  try
    xController
      .User
      .Build
      .Delete('id', xId.ToString);

    aRes.Status(THTTPStatus.NoContent);
  except
    on e: Exception do
      aRes.Send(e.Message).Status(THTTPStatus.InternalServerError);
  end;
end;

procedure UserRegistry;
begin
  THorse
    .Get('user', ListAll)
    .Get('user/:id', ListById)
    .Post('user', Insert)
    .Put('user/:id', Update)
    .Delete('user/:id', Delete)
end;

end.
