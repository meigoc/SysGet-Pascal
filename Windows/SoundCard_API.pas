unit SoundCard_API;

interface

{ Функция получения имени звуковой карты }
function GetSoundCardName: string;

{ Функция получения производителя звуковой карты }
function GetSoundCardVendor: string;

implementation

uses
  Windows, SysUtils, ComObj, ActiveX;

function GetSoundCardName: string;
var
  WMI: Variant;
  Devices: Variant;
  Device: Variant;
begin
  Result := 'Unknown';
  WMI := CreateOleObject('WbemScripting.SWbemLocator');
  Devices := WMI.ConnectServer('', 'root\CIMV2').ExecQuery('SELECT * FROM Win32_SoundDevice');
  for Device in Devices do
  begin
    Result := Device.Name;
    Break;
  end;
end;

function GetSoundCardVendor: string;
var
  WMI: Variant;
  Devices: Variant;
  Device: Variant;
begin
  Result := 'Unknown';
  WMI := CreateOleObject('WbemScripting.SWbemLocator');
  Devices := WMI.ConnectServer('', 'root\CIMV2').ExecQuery('SELECT * FROM Win32_SoundDevice');
  for Device in Devices do
  begin
    Result := Device.Manufacturer;
    Break;
  end;
end;

end.
