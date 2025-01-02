unit Monitor_API;

interface

{ Функция получения имени монитора }
function GetMonitorName: string;

{ Функция получения разрешения монитора }
function GetMonitorResolution: string;

implementation

uses
  SysUtils, Classes, Process;

{ Функция получения имени монитора }
function GetMonitorName: string;
var
  Output: TStringList;
  Command: TProcess;
begin
  Output := TStringList.Create;
  Command := TProcess.Create(nil);
  try
    Command.CommandLine := 'system_profiler SPDisplaysDataType | grep "Display Type"';
    Command.Options := [poWaitOnExit, poUsePipes];
    Command.Execute;
    Output.LoadFromStream(Command.Output);
    if Command.ExitStatus = 0 then
      Result := Trim(Output.Text)
    else
      Result := 'Failed to retrieve monitor name';
  finally
    Output.Free;
    Command.Free;
  end;
end;

{ Функция получения разрешения монитора }
function GetMonitorResolution: string;
var
  Output: TStringList;
  Command: TProcess;
begin
  Output := TStringList.Create;
  Command := TProcess.Create(nil);
  try
    Command.CommandLine := 'system_profiler SPDisplaysDataType | grep "Resolution"';
    Command.Options := [poWaitOnExit, poUsePipes];
    Command.Execute;
    Output.LoadFromStream(Command.Output);
    if Command.ExitStatus = 0 then
      Result := Trim(Output.Text)
    else
      Result := 'Failed to retrieve monitor resolution';
  finally
    Output.Free;
    Command.Free;
  end;
end;

end.
