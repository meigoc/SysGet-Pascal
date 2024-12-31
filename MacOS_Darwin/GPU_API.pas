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
  SysUtils, Classes, Process;

{ Функция получения имени видеокарты
(GPU Name Retrieval Function) }
function GetGPUName: string;
var
  Output: TStringList;
  Command: TProcess;
begin
  Output := TStringList.Create;
  Command := TProcess.Create(nil);
  try
    Command.CommandLine := 'system_profiler SPDisplaysDataType | grep "Chipset Model"';
    Command.Options := [poWaitOnExit, poUsePipes];
    Command.Execute;
    Output.LoadFromStream(Command.Output);
    if Command.ExitStatus = 0 then
      Result := Trim(Output.Text)
    else
      Result := 'Failed to retrieve GPU name';
  finally
    Output.Free;
    Command.Free;
  end;
end;

{ Функция получения производителя видеокарты
(GPU Vendor Retrieval Function) }
function GetGPUVendor: string;
var
  Output: TStringList;
  Command: TProcess;
begin
  Output := TStringList.Create;
  Command := TProcess.Create(nil);
  try
    Command.CommandLine := 'system_profiler SPDisplaysDataType | grep "Vendor"';
    Command.Options := [poWaitOnExit, poUsePipes];
    Command.Execute;
    Output.LoadFromStream(Command.Output);
    if Command.ExitStatus = 0 then
      Result := Trim(Output.Text)
    else
      Result := 'Failed to retrieve GPU vendor';
  finally
    Output.Free;
    Command.Free;
  end;
end;

end.
