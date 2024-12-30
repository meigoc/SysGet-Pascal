unit Sensor_API;

interface

{ Функция получения скорости вентилятора (Fan Speed Retrieval Function) }
function GetFanSpeed: Integer;

{ Функция получения температуры датчика (Temperature Sensor Retrieval Function) }
function GetTemperature: Double;

implementation

uses
  SysUtils, Classes;

{ Функция получения скорости вентилятора (Fan Speed Retrieval Function) }
function GetFanSpeed: Integer;
var
  Output: TStringList;
  Command: string;
begin
  Command := 'sensors | grep -i "fan"';
  Output := TStringList.Create;
  try
    Output.Text := Trim(SysUtils.ExecuteProcess('/bin/sh', ['-c', Command], Output));
    Result := StrToIntDef(Output.Text, 0);
  finally
    Output.Free;
  end;
end;

{ Функция получения температуры датчика (Temperature Sensor Retrieval Function) }
function GetTemperature: Double;
var
  Output: TStringList;
  Command: string;
begin
  Command := 'sensors | grep -i "temp"';
  Output := TStringList.Create;
  try
    Output.Text := Trim(SysUtils.ExecuteProcess('/bin/sh', ['-c', Command], Output));
    Result := StrToFloatDef(Output.Text, 0.0);
  finally
    Output.Free;
  end;
end;

end.
