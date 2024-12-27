program Test;

{$IFDEF MSWINDOWS}
uses Windows.CPU_API, Windows.GPU_API;
{$ENDIF}
{$IFDEF LINUX}
uses Linux.CPU_API, Linux.GPU_API;
{$ENDIF}
{$IFDEF DARWIN}
uses MacOS_Darwin.CPU_API, MacOS_Darwin.GPU_API;
{$ENDIF}

begin
  writeln('CPU Name: ', GetCPUName);
  writeln('CPU Vendor: ', GetCPUVendor);
  writeln('CPU Frequency: ', GetCPUFrequency);
  writeln('CPU Max Frequency: ', GetCPUMaxFrequency);
  writeln('CPU Architecture: ', GetCPUArchitecture);
  
  writeln('GPU Name: ', GetGPUName);
  writeln('GPU Vendor: ', GetGPUVendor);
end.
