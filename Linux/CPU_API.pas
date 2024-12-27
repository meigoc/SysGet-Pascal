unit CPU_API;

interface

{ Функция получения имени процессора
(Processor Name Retrieval Function) }
function GetCPUName: string;

{ Функция получения производителя процессора
(Processor Vendor Retrieval Function) }
function GetCPUVendor: string;

{ Функция получения частоты процессора
(Processor Frequency Retrieval Function) }
function GetCPUFrequency: string;

{ Функция получения максимальной частоты процессора
(Maximum Processor Frequency Retrieval Function) }
function GetCPUMaxFrequency: string;

{ Функция получения архитектуры процессора
(Processor Architecture Retrieval Function) }
function GetCPUArchitecture: string;

implementation

uses
  SysUtils, Classes;

{ Функция получения имени процессора
(Processor Name Retrieval Function) }
function GetCPUName: string;
var
  Output: TStringList;
  i: Integer;
begin
  Output := TStringList.Create;
  try
    Output.LoadFromFile('/proc/cpuinfo');
    for i := 0 to Output.Count - 1 do
    begin
      if Pos('model name', Output[i]) > 0 then
      begin
        Result := Trim(Copy(Output[i], Pos(':', Output[i]) + 2, Length(Output[i])));
        Exit;
      end;
    end;
  finally
    Output.Free;
  end;
end;

{ Функция получения производителя процессора
(Processor Vendor Retrieval Function) }
function GetCPUVendor: string;
var
  Output: TStringList;
  i: Integer;
begin
  Output := TStringList.Create;
  try
    Output.LoadFromFile('/proc/cpuinfo');
    for i := 0 to Output.Count - 1 do
    begin
      if Pos('vendor_id', Output[i]) > 0 then
      begin
        Result := Trim(Copy(Output[i], Pos(':', Output[i]) + 2, Length(Output[i])));
        Exit;
      end;
    end;
  finally
    Output.Free;
  end;
end;

{ Функция получения частоты процессора
(Processor Frequency Retrieval Function) }
function GetCPUFrequency: string;
var
  Output: TStringList;
  i: Integer;
begin
  Output := TStringList.Create;
  try
    Output.LoadFromFile('/proc/cpuinfo');
    for i := 0 to Output.Count - 1 do
    begin
      if Pos('cpu MHz', Output[i]) > 0 then
      begin
        Result := Trim(Copy(Output[i], Pos(':', Output[i]) + 2, Length(Output[i]))) + ' MHz';
        Exit;
      end;
    end;
  finally
    Output.Free;
  end;
end;

{ Функция получения максимальной частоты процессора
(Maximum Processor Frequency Retrieval Function) }
function GetCPUMaxFrequency: string;
var
  Output: TStringList;
  i: Integer;
begin
  Result := 'Unknown'; // По умолчанию
  Output := TStringList.Create;
  try
    Output.LoadFromFile('/proc/cpuinfo');
    for i := 0 to Output.Count - 1 do
    begin
      if Pos('cpu MHz', Output[i]) > 0 then
      begin
        // Макс. частота может быть определена на основе текущей частоты в процентах или других данных
        Result := Trim(Copy(Output[i], Pos(':', Output[i]) + 2, Length(Output[i]))) + ' MHz';
        Exit;
      end;
    end;
  finally
    Output.Free;
  end;
end;

{ Функция получения архитектуры процессора
(Processor Architecture Retrieval Function) }
function GetCPUArchitecture: string;
var
  Output: TStringList;
  Command: string;
begin
  Command := 'uname -m';
  Output := TStringList.Create;
  try
    Output.Text := Trim(SysUtils.ExecuteProcess('/bin/sh', ['-c', Command], Output));
    Result := Output.Text;
  finally
    Output.Free;
  end;
end;

end.
