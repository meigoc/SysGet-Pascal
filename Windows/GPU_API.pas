unit GPU_API;

interface

{ Функция получения имени видеокарты
(GPU Name Retrieval Function) }
function GetGPUName: string;

{ Функция получения производителя видеокарты
(GPU Vendor Retrieval Function) }
function GetGPUVendor: string;

implementation

uses
  Windows, SysUtils;

{ Функция получения имени видеокарты
(GPU Name Retrieval Function) }
function GetGPUName: string;
var
  GPUName: array[0..127] of Char;
  Size: DWORD;
begin
  Size := SizeOf(GPUName);
  if GetSystemRegistryKey(HKEY_LOCAL_MACHINE, 'HARDWARE\DEVICEMAP\VIDEO\0', 'DriverDesc', @GPUName, Size) then
    Result := GPUName
  else
    Result := 'Unknown';
end;

{ Функция получения производителя видеокарты
(GPU Vendor Retrieval Function) }
function GetGPUVendor: string;
var
  GPUVendor: array[0..127] of Char;
  Size: DWORD;
begin
  Size := SizeOf(GPUVendor);
  if GetSystemRegistryKey(HKEY_LOCAL_MACHINE, 'HARDWARE\DEVICEMAP\VIDEO\0', 'ProviderName', @GPUVendor, Size) then
    Result := GPUVendor
  else
    Result := 'Unknown';
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
