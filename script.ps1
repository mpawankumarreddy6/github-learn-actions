$repoPath = "$env:GITHUB_WORKSPACE"
$filePath = "$repoPath\manifest.json"
$filePath1 = "$repoPath\manifest1.json"
$content = Get-Content $filePath
if ($content -ne $null)
{
    echo "inside"

    $json = Get-Content $filePath -Raw | ConvertFrom-Json

    $json | Get-Member
    echo "got Member"
    Test-Path $filePath
    echo "Checked test-path"
    (Get-Acl $filePath).Access
    echo "Checked filepath access rights"
    # Extract the current version number and split it into its components
    $versionParts = $json.version -split '\.'

    # Increment the last component of the version number
    $versionParts[-1] = [int]$versionParts[-1] + 1

    # Combine the version components into a string
    $newVersion = $versionParts -join '.'
    
    echo $newVersion

    # Update the version number in the JSON object
    $json.version = $newVersion
    
    echo "New " + $json.version

    # Save the updated JSON object back to the new file
    $json | ConvertTo-Json -Depth 30 | Out-File $filePath
    
    $json -replace $json.version | Out-File $filePath
    $json | ConvertTo-Json | Out-File $filePath
    echo "done with replacing"
    
    $jsonBase = @{}

    $array = @{}

    $data = @{"Name"="Matt";"Colour"="Black";}

    $array.Add("Person",$data)

    $jsonBase.Add("Data",$array)
    $jsonBase | ConvertTo-Json -Depth 10 | Out-File ".\write-array.json"
} 
else 
{
        echo "failed"
}
