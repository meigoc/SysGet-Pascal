unit Monitor_API;

interface

{ Функция получения имени монитора }
function GetMonitorName: string;

{ Функция получения разрешения монитора }
function GetMonitorResolution: string;

implementation

uses
  Windows, SysUtils;

{ Функция получения имени монитора }
function GetMonitorName: string;
var
  MonitorName: array[0..127] of Char;
  Size: DWORD;
begin
  Size := SizeOf(MonitorName);
  if GetSystemRegistryKey(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Services\Monitor\Enum', '0', @MonitorName, Size) then
    Result := MonitorName
  else
    Result := 'Unknown';
end;

{ Функция получения разрешения монитора }
function GetMonitorResolution: string;
var
  DevMode: TDevMode;
begin
  EnumDisplaySettings(nil, ENUM_CURRENT_SETTINGS, DevMode);
  Result := Format('%dx%d', [DevMode.dmPelsWidth, DevMode.dmPelsHeight]);
end;

function GetSystemRegistryKey(RootKey: HKEY; Key, Value: PChar; var Data; DataSize: DWORD): Boolean;
var
  hKey: HKEY;
begin
  Result := RegOpenKeyEx(RootKey, Key, 0, KEY_QUERY_VALUE, hKey) = ERROR_SUCCESS;
  if Result then
  begin
    Result := RegQueryValueEx(hKey, Value, nil, nil, @Data, @DataSize) = ERROR_SUCCESS;
    RegCloseKey(hKey);
  end;
end;

end.
