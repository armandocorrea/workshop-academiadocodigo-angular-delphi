program worshop;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.CORS,
  Horse.Jhonson,
  Horse.JWT,

  System.SysUtils,

  workshop.model.resource.interfaces in 'src\model\resource\workshop.model.resource.interfaces.pas',
  workshop.model.resource.impl.configuration in 'src\model\resource\impl\workshop.model.resource.impl.configuration.pas',
  workshop.model.resource.impl.conectionfiredac in 'src\model\resource\impl\workshop.model.resource.impl.conectionfiredac.pas',
  workshop.model.resource.impl.factory in 'src\model\resource\impl\workshop.model.resource.impl.factory.pas',
  workshop.model.service.interfaces in 'src\model\service\workshop.model.service.interfaces.pas',
  workshop.model.service.impl.simpleorm in 'src\model\service\impl\workshop.model.service.impl.simpleorm.pas',
  workshop.model.entity.user in 'src\model\entity\workshop.model.entity.user.pas',
  workshop.controller.dto.interfaces in 'src\controller\dto\workshop.controller.dto.interfaces.pas',
  workshop.controller.dto.impl.user in 'src\controller\dto\impl\workshop.controller.dto.impl.user.pas',
  workshop.controller.interfaces in 'src\controller\workshop.controller.interfaces.pas',
  workshop.controller.impl.controller in 'src\controller\impl\workshop.controller.impl.controller.pas',
  workshop.controller.router.interfaces in 'src\controller\router\workshop.controller.router.interfaces.pas',
  workshop.controller.router.impl.user in 'src\controller\router\impl\workshop.controller.router.impl.user.pas',
  workshop.controller.router.impl.login in 'src\controller\router\impl\workshop.controller.router.impl.login.pas',
  workshop.controller.router.impl.router in 'src\controller\router\impl\workshop.controller.router.impl.router.pas';

begin
  THorse
    .Use(CORS)
    .Use(Jhonson());

  //JWT
  THorse
    .Use(HorseJWT('WorkShop',
      THorseJWTConfig
        .New
          .SkipRoutes(['/user',
                       '/user/:id',
                       '/login'])));

  TRouter
    .New
    .User
    .Login;

  THorse.Listen(8020);
end.
