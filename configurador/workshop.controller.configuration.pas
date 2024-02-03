unit workshop.controller.configuration;

interface

type
  TConfiguration = class
    private
      FPort: String;
      FDatabase: String;
      FDriverID: String;
      FUsername: String;
      FServer: String;
      FSchema: String;
      FPassword: String;
    public
      procedure SaveConfiguration;
      procedure LoadConfiguration;

      property DriverID: String read FDriverID write FDriverID;
      property Database: String read FDatabase write FDatabase;
      property Username: String read FUsername write FUsername;
      property Password: String read FPassword write FPassword;
      property Port: String     read FPort     write FPort;
      property Server: String   read FServer   write FServer;
      property Schema: String   read FSchema   write FSchema;
  end;

implementation

uses
  LocalCache4D;

{ TConfiguration }

procedure TConfiguration.LoadConfiguration;
begin
  LocalCache.LoadDatabase('WorkshopAngularDelphi.lc4');

  LocalCache.TryGetItem('DriverID', FDriverID);
  LocalCache.TryGetItem('Database', FDatabase);
  LocalCache.TryGetItem('Username', FUsername);
  LocalCache.TryGetItem('Password', FPassword);
  LocalCache.TryGetItem('Port', FPort);
  LocalCache.TryGetItem('Server', FServer);
  LocalCache.TryGetItem('Schema', FSchema);
end;

procedure TConfiguration.SaveConfiguration;
begin
  LocalCache.LoadDatabase('WorkshopAngularDelphi.lc4');

  LocalCache.SetItem('DriverID', DriverID);
  LocalCache.SetItem('Database', Database);
  LocalCache.SetItem('Username', Username);
  LocalCache.SetItem('Password', Password);
  LocalCache.SetItem('Port', Port);
  LocalCache.SetItem('Server', Server);
  LocalCache.SetItem('Schema', Schema);

  LocalCache.SaveToStorage('WorkshopAngularDelphi.lc4');
end;

end.
