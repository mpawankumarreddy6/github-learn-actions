$repoPath = "$env:GITHUB_WORKSPACE"
$filePath = "$repoPath\manifest.json"
$filePath1 = "$repoPath\manifest1.json"
$content = Get-Content $filePath
if ($content -ne $null)
{
    echo "inside"

    $json = Get-Content $filePath -Raw | ConvertFrom-Json

    $json | Get-Member
    
    Test-Path $filePath
    
    (Get-Acl $filePath).Access
    
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

    # Save the updated JSON object back to the file
    $json | ConvertTo-Json -Depth 100 | Set-Content $filePath1
} 
else 
{
        echo "failed"
}
