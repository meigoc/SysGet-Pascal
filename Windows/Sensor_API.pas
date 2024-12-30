unit Sensor_API;

interface

uses
  SysUtils, Classes;

{ Функция получения скорости вентилятора (Fan Speed Retrieval Function) }
function GetFanSpeed: Integer;

{ Функция получения температуры датчика (Temperature Sensor Retrieval Function) }
function GetTemperature: Double;

implementation

uses
  Windows, ComObj, ActiveX;

const
  OpenHardwareMonitorLib = 'OpenHardwareMonitorLib';

function GetOHMValue(SensorType, Index: Integer): Double;
var
  WMI: Variant;
  Sensors: Variant;
  Sensor: Variant;
begin
  Result := -1;
  WMI := CreateOleObject('WbemScripting.SWbemLocator');
  Sensors := WMI.ConnectServer('', 'root\OpenHardwareMonitor').ExecQuery('SELECT * FROM Sensor');
  for Sensor in Sensors do
  begin
    if (Sensor.SensorType = SensorType) and (Sensor.Index = Index) then
    begin
      Result := Sensor.Value;
      Break;
    end;
  end;
end;

{ Функция получения скорости вентилятора (Fan Speed Retrieval Function) }
function GetFanSpeed: Integer;
begin
  Result := Round(GetOHMValue(1, 0)); // Тип 1 для скорости вентилятора
end;

{ Функция получения температуры датчика (Temperature Sensor Retrieval Function) }
function GetTemperature: Double;
begin
  Result := GetOHMValue(2, 0); // Тип 2 для температуры
end;

end.
