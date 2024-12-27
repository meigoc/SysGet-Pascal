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
  SysUtils, Process;

{ Функция получения имени процессора
(Processor Name Retrieval Function) }
function GetCPUName: string;
var
  Output: TStringList;
  Command: string;
begin
  Command := 'sysctl -n machdep.cpu.brand_string';
  Output := TStringList.Create;
  try
    Output.Text := Trim(SysUtils.ExecuteProcess('/bin/sh', ['-c', Command], Output));
    Result := Output.Text;
  finally
    Output.Free;
  end;
end;

{ Функция получения производителя процессора
(Processor Vendor Retrieval Function) }
function GetCPUVendor: string;
var
  Output: TStringList;
  Command: string;
begin
  Command := 'sysctl -n machdep.cpu.vendor';
  Output := TStringList.Create;
  try
    Output.Text := Trim(SysUtils.ExecuteProcess('/bin/sh', ['-c', Command], Output));
    Result := Output.Text;
  finally
    Output.Free;
  end;
end;

{ Функция получения частоты процессора
(Processor Frequency Retrieval Function) }
function GetCPUFrequency: string;
var
  Output: TStringList;
  Command: string;
begin
  Command := 'sysctl -n hw.cpufrequency';
  Output := TStringList.Create;
  try
    Output.Text := Trim(SysUtils.ExecuteProcess('/bin/sh', ['-c', Command], Output));
    Result := Format('%s Hz', [Output.Text]);
  finally
    Output.Free;
  end;
end;

{ Функция получения максимальной частоты процессора
(Maximum Processor Frequency Retrieval Function) }
function GetCPUMaxFrequency: string;
var
  Output: TStringList;
  Command: string;
begin
  Command := 'sysctl -n hw.cpufrequency_max';
  Output := TStringList.Create;
  try
    Output.Text := Trim(SysUtils.ExecuteProcess('/bin/sh', ['-c', Command], Output));
    Result := Format('%s Hz', [Output.Text]);
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
