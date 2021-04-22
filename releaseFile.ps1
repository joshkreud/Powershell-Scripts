Add-Type -AssemblyName System.Windows.Forms

$param1 = $args[0]
Write-Host $param1
$itemExists = Test-Path -Path $param1

if (-Not $itemExists) {
    Write-Host "Couldn't get Input File"
    Read-Host -Prompt "Press Enter to exit"
    exit
}

$file = Get-Item $param1
Write-Host "Processing File: "$param1
$cdate = $file.LastWriteTime
$suffix = Get-Date -Date $cdate -Format "yyMMdd"
$basen = $file.BaseName

Write-Host "Base Name: "$basen
if (  $basen.SubString($basen.length - 12, 12) -ieq "_XXXXXX_WORK" ) {
    write-host "Adjusting for Suffix"
    $basen = $basen.SubString(0, $basen.length - 12)
}

$newpath = Join-Path -Path $file.Directory.FullName -ChildPath "$($basen)_$($suffix)$($file.Extension)"
write-host "Releasing File: $($file.FullName)"
Write-Host "New Path: $($newpath)"
$fexist = Test-Path $newpath
if (!$fexist) {
    Write-Host "Copying..."
    Copy-Item $file -Destination $newpath
    Write-Host "Done Copying"
    [System.Windows.Forms.MessageBox]::Show("File Copied to: $((Get-Item $newpath).Name)", "Success", 0)
    stop-process -Id $PID
}
else {
    Write-Host "FileExist"
    [System.Windows.Forms.MessageBox]::Show("File Exists", "Failure", 0)
}
