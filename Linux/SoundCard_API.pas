unit SoundCard_API;

interface

{ Функция получения имени звуковой карты }
function GetSoundCardName: string;

{ Функция получения производителя звуковой карты }
function GetSoundCardVendor: string;

implementation

uses
  SysUtils, Classes;

function GetSoundCardName: string;
var
  Output: TStringList;
  Command: string;
begin
  Command := 'lspci | grep -i audio';
  Output := TStringList.Create;
  try
    Output.Text := Trim(SysUtils.ExecuteProcess('/bin/sh', ['-c', Command], Output));
    Result := Output.Text;
  finally
    Output.Free;
  end;
end;

function GetSoundCardVendor: string;
var
  Output: TStringList;
  Command: string;
begin
  Command := 'lspci -nn | grep -i audio';
  Output := TStringList.Create;
  try
    Output.Text := Trim(SysUtils.ExecuteProcess('/bin/sh', ['-c', Command], Output));
    Result := Output.Text;
  finally
    Output.Free;
  end;
end;

end.
