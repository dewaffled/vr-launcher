# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}

do {
    $input = Read-Host "Activate or Deactivate? (a/d)"

    if ($input -eq "a") {
        Get-PnpDevice -Class 'Holographic' | Enable-PnpDevice -Confirm:$false
        exit
    } elseif ($input -eq "d") {
        Get-PnpDevice -Class 'Holographic' | Disable-PnpDevice -Confirm:$false 
        exit
    }

    Write-Host "Invalid input. Enter either 'a' or 'd'"

} while ($input -ne "a" -and $input -ne "d")
