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
  SysUtils, Classes;

{ Функция получения имени видеокарты
(GPU Name Retrieval Function) }
function GetGPUName: string;
var
  Output: TStringList;
  Command: string;
begin
  Command := 'lspci | grep VGA';
  Output := TStringList.Create;
  try
    Output.Text := Trim(SysUtils.ExecuteProcess('/bin/sh', ['-c', Command], Output));
    Result := Output.Text;
  finally
    Output.Free;
  end;
end;

{ Функция получения производителя видеокарты
(GPU Vendor Retrieval Function) }
function GetGPUVendor: string;
var
  Output: TStringList;
  Command: string;
begin
  Command := 'lspci -nn | grep VGA';
  Output := TStringList.Create;
  try
    Output.Text := Trim(SysUtils.ExecuteProcess('/bin/sh', ['-c', Command], Output));
    Result := Output.Text;
  finally
    Output.Free;
  end;
end;

end.
