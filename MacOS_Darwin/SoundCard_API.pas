unit SoundCard_API;

interface

{ Функция получения имени звуковой карты }
function GetSoundCardName: string;

{ Функция получения производителя звуковой карты }
function GetSoundCardVendor: string;

implementation

uses
  SysUtils, Process, Classes;

function GetSoundCardName: string;
var
  Output: TStringList;
  Command: TProcess;
begin
  Output := TStringList.Create;
  Command := TProcess.Create(nil);
  try
    Command.CommandLine := 'system_profiler SPAudioDataType | grep "Output Device"';
    Command.Options := [poWaitOnExit, poUsePipes];
    Command.Execute;
    Output.LoadFromStream(Command.Output);
    if Command.ExitStatus = 0 then
      Result := Trim(Output.Text)
    else
      Result := 'Failed to retrieve sound card name';
  finally
    Output.Free;
    Command.Free;
  end;
end;

function GetSoundCardVendor: string;
var
  Output: TStringList;
  Command: TProcess;
begin
  Output := TStringList.Create;
  Command := TProcess.Create(nil);
  try
    Command.CommandLine := 'system_profiler SPAudioDataType | grep "Output Device Manufacturer"';
    Command.Options := [poWaitOnExit, poUsePipes];
    Command.Execute;
    Output.LoadFromStream(Command.Output);
    if Command.ExitStatus = 0 then
      Result := Trim(Output.Text)
    else
      Result := 'Failed to retrieve sound card vendor';
  finally
    Output.Free;
    Command.Free;
  end;
end;

end.
