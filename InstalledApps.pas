program InstalledApps;

{$APPTYPE CONSOLE}

uses
  Windows,
  Classes,
  SysUtils,
  Registry;

const
  UNINST_PATH = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall';
var
  Registry: TRegistry;
  Keys: TStrings;
  Key: string;
  AppName: string;
  AppLookingFor: string;
  IsAppInstalled: Boolean;
begin
  Write('application''s name you''re looking for: ');
  Readln(AppLookingFor);

  Registry := TRegistry.Create;
  Registry.RootKey := HKEY_LOCAL_MACHINE;
  if Registry.OpenKeyReadOnly(UNINST_PATH) then
  begin
    Keys := TStringList.Create;
    try
      Registry.GetKeyNames(Keys);
      Registry.CloseKey();
      for Key in Keys do
      begin
        if Registry.OpenKeyReadOnly(Format('%s\%s', [UNINST_PATH, Key])) then
        begin
          try
            AppName := Registry.ReadString('DisplayName');
            IsAppInstalled := Pos(AnsiUpperCase(AppLookingFor), AnsiUpperCase(AppName)) > 0;
            if IsAppInstalled then Break;
          finally
            Registry.CloseKey();
          end;
        end;
      end;
    finally
      Keys.Free();
    end;
    if IsAppInstalled then
      Writeln(AppLookingFor + ' is installed!')
    else 
      Writeln(AppLookingFor + ' is unavailable or not installed!');
    ReadLn; //don't close the window, wait for [Enter]
  end;
end.