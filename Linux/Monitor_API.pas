unit Monitor_API;

interface

{ Функция получения имени монитора }
function GetMonitorName: string;

{ Функция получения разрешения монитора }
function GetMonitorResolution: string;

implementation

uses
  SysUtils, Classes;

{ Функция получения имени монитора }
function GetMonitorName: string;
var
  Output: TStringList;
  Command: string;
begin
  Command := 'xrandr --verbose | grep "connected"';
  Output := TStringList.Create;
  try
    Output.Text := Trim(SysUtils.ExecuteProcess('/bin/sh', ['-c', Command], Output));
    Result := Output.Text;
  finally
    Output.Free;
  end;
end;

{ Функция получения разрешения монитора }
function GetMonitorResolution: string;
var
  Output: TStringList;
  Command: string;
begin
  Command := 'xrandr | grep "*"';
  Output := TStringList.Create;
  try
    Output.Text := Trim(SysUtils.ExecuteProcess('/bin/sh', ['-c', Command], Output));
    Result := Output.Text;
  finally
    Output.Free;
  end;
end;

end.
