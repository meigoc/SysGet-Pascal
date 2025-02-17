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

{ Функция получения архитектуры процессора
(Processor Architecture Retrieval Function) }
function GetCPUArchitecture: string;

implementation

uses
  Windows, SysUtils;

{ Вспомогательная функция для чтения значений из реестра
(Helper Function for Reading Registry Values) }
function GetSystemRegistryKey(RootKey: HKEY; Key, Value: PChar; var Data; DataSize: DWORD): Boolean;
var
  hKey: HKEY;
begin
  Result := RegOpenKeyEx(RootKey, Key, 0, KEY_QUERY_VALUE, hKey) = ERROR_SUCCESS;
  if Result then
  begin
    Result := RegQueryValueEx(hKey, Value, nil, nil, @Data, @DataSize) = ERROR_SUCCESS;
    RegCloseKey(hKey);
  end;
end;

{ Функция получения имени процессора
(Processor Name Retrieval Function) }
function GetCPUName: string;
var
  CPUName: array[0..255] of Char;
  Size: DWORD;
begin
  Size := SizeOf(CPUName);
  if GetSystemRegistryKey(HKEY_LOCAL_MACHINE, 'HARDWARE\DESCRIPTION\System\CentralProcessor\0', 'ProcessorNameString', CPUName, Size) then
    Result := CPUName
  else
    Result := 'Unknown';
end;

{ Функция получения производителя процессора
(Processor Vendor Retrieval Function) }
function GetCPUVendor: string;
var
  CPUInfo: array[1..4] of Integer;
begin
  asm
    xor eax, eax
    cpuid
    mov CPUInfo[1], ebx
    mov CPUInfo[2], edx
    mov CPUInfo[3], ecx
  end;
  SetString(Result, PChar(@CPUInfo[1]), 12);
end;

{ Функция получения частоты процессора
(Processor Frequency Retrieval Function) }
function GetCPUFrequency: string;
var
  CPUFrequency: DWORD;
  Size: DWORD;
begin
  Size := SizeOf(CPUFrequency);
  if GetSystemRegistryKey(HKEY_LOCAL_MACHINE, 'HARDWARE\DESCRIPTION\System\CentralProcessor\0', '~MHz', CPUFrequency, Size) then
    Result := Format('%d MHz', [CPUFrequency])
  else
    Result := 'Unknown';
end;

{ Функция получения архитектуры процессора
(Processor Architecture Retrieval Function) }
function GetCPUArchitecture: string;
var
  SysInfo: SYSTEM_INFO;
begin
  GetNativeSystemInfo(SysInfo);
  case SysInfo.wProcessorArchitecture of
    PROCESSOR_ARCHITECTURE_INTEL: Result := 'x86';
    PROCESSOR_ARCHITECTURE_AMD64: Result := 'x64';
    PROCESSOR_ARCHITECTURE_ARM: Result := 'ARM';
    PROCESSOR_ARCHITECTURE_ARM64: Result := 'ARM64';
  else
    Result := 'Unknown';
  end;
end;

end.
