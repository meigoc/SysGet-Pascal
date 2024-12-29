unit Battery_API;

interface

{ Функция получения уровня заряда батареи
(Battery Charge Level Retrieval Function) }
function GetBatteryChargeLevel: string;

{ Функция проверки наличия батареи
(Battery Presence Check Function) }
function IsBatteryPresent: Boolean;

{ Функция получения статуса батареи (зарядка/разрядка)
(Battery Status Retrieval Function) }
function GetBatteryStatus: string;

implementation

uses
  Windows, SysUtils;

{ Функция получения уровня заряда батареи
(Battery Charge Level Retrieval Function) }
function GetBatteryChargeLevel: string;
var
  SysPowerStatus: SYSTEM_POWER_STATUS;
begin
  if GetSystemPowerStatus(SysPowerStatus) then
  begin
    if SysPowerStatus.BatteryLifePercent <> 255 then
      Result := Format('%d%%', [SysPowerStatus.BatteryLifePercent])
    else
      Result := 'Unknown';
  end
  else
    Result := 'Error retrieving battery level';
end;

{ Функция проверки наличия батареи
(Battery Presence Check Function) }
function IsBatteryPresent: Boolean;
var
  SysPowerStatus: SYSTEM_POWER_STATUS;
begin
  if GetSystemPowerStatus(SysPowerStatus) then
    Result := (SysPowerStatus.BatteryFlag and 128) = 0
  else
    Result := False;
end;

{ Функция получения статуса батареи (зарядка/разрядка)
(Battery Status Retrieval Function) }
function GetBatteryStatus: string;
var
  SysPowerStatus: SYSTEM_POWER_STATUS;
begin
  if GetSystemPowerStatus(SysPowerStatus) then
  begin
    case SysPowerStatus.ACLineStatus of
      0: Result := 'Discharging';
      1: Result := 'Charging';
      else Result := 'Unknown';
    end;
  end
  else
    Result := 'Error retrieving battery status';
end;

end.
