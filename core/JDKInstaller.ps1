function InstallJDK([String]$urlStr, [String]$targetPath) {
    if (Test-Path $targetPath) {
        $log = '[' + $targetPath + '] already exists.'
        Write-Output $log
        exit
    }
      
    $is64bitProcess = [System.Environment]::Is64BitProcess
    if ($is64bitProcess) {
      
        Write-Output '######################################'
        Write-Output '##### Start Open JDK Download... #####'
        Write-Output '######################################'
        Write-Output ''
      
        $uri = New-Object System.Uri($urlStr)
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
        Write-Output '############ Completed!! #############'
        Write-Output '######################################'
      
        Remove-Item $downloadZipPath
      
    }
    else {
        Write-Output 'Only 64-bit is supported.'
    }
}