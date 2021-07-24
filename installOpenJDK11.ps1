if (Test-Path 'C:\jdk-11') {
  Write-Output 'JDK 11 is already installed.'
  Write-Output 'See [C:\jdk-11] folder.'
  exit
}

$is64bitProcess = [System.Environment]::Is64BitProcess
if ($is64bitProcess) {

  Write-Output '######################################'
  Write-Output '##### Start Open JDK Download... #####'
  Write-Output '######################################'
  Write-Output ''

  $uri = New-Object System.Uri('https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_windows-x64_bin.zip')
  $fileName = Split-Path $uri.AbsolutePath -Leaf

  $currentPath = Convert-Path .
  $downloadZipPath = (Join-Path $currentPath $fileName)
  curl.exe -Lo $downloadZipPath $uri

  Write-Output '######################################'
  Write-Output '######## JDK unzip to c:/...  ########'
  Write-Output '######################################'
  Write-Output ''

  Expand-Archive -Path $downloadZipPath -DestinationPath 'C:\'

  Write-Output '######################################'
  Write-Output '####### Add path C:\jdk-11\bin; ######'
  Write-Output '######################################'
  Write-Output ''

  [Environment]::SetEnvironmentVariable('Path', 'C:\jdk-11\bin;' + $env:Path , [EnvironmentVariableTarget]::Machine)

  Write-Output '######################################'
  Write-Output '############ Completed!! #############'
  Write-Output '######################################'

  Remove-Item $downloadZipPath

}
else {
  Write-Output 'Only 64-bit is supported.'
}