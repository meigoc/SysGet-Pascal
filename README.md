# Planned or already Implemented:

| SystemAPI                          | Implemented        | Supported Platforms             |
| ---------------------------------- | ------------------ | ------------------------------- |
| CPU Information                    | :white_check_mark:       | Windows, MacOS, Linux |
| GPU Information                    | :white_check_mark:       | Windows, MacOS, Linux |
| Battery Status                     | :red_circle:       | Windows, MacOS, Linux (Planned) |
| RAM Usage                          | :red_circle:       | Windows, MacOS, Linux (Planned) |
| Disk Storage Information           | :red_circle:       | Windows, MacOS, Linux (Planned) |
| Network Status                     | :red_circle:       | Windows, MacOS, Linux (Planned) |
| USB Connected Devices Support      | :red_circle:       | Windows, MacOS, Linux (Planned) |
| Operating System Details           | :red_circle:       | Windows, MacOS, Linux (Planned) |
| System Uptime                      | :red_circle:       | Windows, MacOS, Linux (Planned) |
| Fan Speed and Temperature Sensors  | :red_circle:       | Windows, MacOS, Linux (Planned) |
| Virtualization Support             | :red_circle:       | Windows, MacOS, Linux (Planned) |
| Monitor Information                | :red_circle:       | Windows, MacOS, Linux (Planned) |
| Sound Card Status                  | :red_circle:       | Windows, MacOS, Linux (Planned) |
| Peripheral Device Status           | :red_circle:       | Windows, MacOS, Linux (Planned) |

# Example:
```pascal
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

```
