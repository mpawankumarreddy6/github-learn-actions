$jsonfiles = Get-ChildItem -Path ./github-learn-actions -Filter *.json -Recurse
foreach($file in $jsonfiles)
{ 
     write-host $file.FullName
     $newContent = Invoke-WebRequest $file.FullName | ConvertFrom-Json    
     $oldBuildNumber = $newContent.version    
     $MajorVersion = $oldBuildNumber.split('.')[0]    
     $MinorVersion = $oldBuildNumber.split('.')[1]    
     $PatchVersion = $oldBuildNumber.split('.')[2]    
     $PatchVersionNew = [int]$PatchVersion + 1     
     $newBuildNumber = $MajorVersion + '.' + $MinorVersion + '.' + [string]$PatchVersionNew    
     $newContent.version = $newBuildNumber     
     ConvertTo-Json -InputObject $newContent -Depth 10 | set-content $file.FullName    
}
