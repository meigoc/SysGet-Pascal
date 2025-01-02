# Planned or already Implemented:
🟡 - in development

| SystemAPI                          | Implemented        | Supported Platforms             |
| ---------------------------------- | ------------------ | ------------------------------- |
| CPU Information                    | :white_check_mark:       | Windows, MacOS, Linux |
| GPU Information                    | :white_check_mark:       | Windows, MacOS, Linux |
| Battery Status                     | :yellow_circle:       | Windows, MacOS, Linux (Planned) |
| RAM Usage                          | :red_circle:       | Windows, MacOS, Linux (Planned) |
| Disk Storage Information           | :red_circle:       | Windows, MacOS, Linux (Planned) |
| Network Status                     | :red_circle:       | Windows, MacOS, Linux (Planned) |
| USB Connected Devices Support      | :red_circle:       | Windows, MacOS, Linux (Planned) |
| Operating System Details           | :red_circle:       | Windows, MacOS, Linux (Planned) |
| System Uptime                      | :red_circle:       | Windows, MacOS, Linux (Planned) |
| Fan Speed and Temperature Sensors  | :white_check_mark:                 | Windows, MacOS, Linux  |
| Virtualization Support             | :red_circle:       | Windows, MacOS, Linux (Planned) |
| Monitor Information                | :white_check_mark:        | Windows, MacOS, Linux |
| Sound Card                         | :white_check_mark:       | Windows, MacOS, Linux  |
| Peripheral Device Status           | :red_circle:       | Windows, MacOS, Linux (Planned) |

# Example:
```pascal
program Test;

{$IFDEF MSWINDOWS}
uses Windows.CPU_API, Windows.GPU_API, Windows.Battery_API, Windows.Monitor_API, Windows.Sensor_API, Windows.SoundCard_API;
{$ENDIF}
{$IFDEF LINUX}
uses Linux.CPU_API, Linux.GPU_API, Linux.Monitor_API, Linux.Sensor_API, Linux.SoundCard_API;
{$ENDIF}
{$IFDEF DARWIN}
uses MacOS_Darwin.CPU_API, MacOS_Darwin.GPU_API, MacOS_Darwin.Monitor_API, MacOS_Darwin.Sensor_API, MacOS_Darwin.SoundCard_API;
{$ENDIF}

begin
  writeln('CPU Name: ', GetCPUName);
  writeln('CPU Vendor: ', GetCPUVendor);
  writeln('CPU Frequency: ', GetCPUFrequency);
  writeln('CPU Max Frequency: ', GetCPUMaxFrequency);
  writeln('CPU Architecture: ', GetCPUArchitecture);
  
  writeln('GPU Name: ', GetGPUName);
  writeln('GPU Vendor: ', GetGPUVendor);

  writeln('Monitor Name: ', GetMonitorName);
  writeln('Monitor Resolution: ', GetMonitorResolution);

  writeln('Fan Speed: ', GetFanSpeed);
  writeln('Temperature: ', GetTemperature:0:2);

  writeln('Sound Card Name: ', GetSoundCardName);
  writeln('Sound Card Vendor: ', GetSoundCardVendor);

  {$IFDEF MSWINDOWS}
  if IsBatteryPresent then
  begin
    writeln('Battery Charge Level: ', GetBatteryChargeLevel);
    writeln('Battery Status: ', GetBatteryStatus);
  end
  else
    writeln('Battery not present.');
  {$ENDIF}
end.
```
