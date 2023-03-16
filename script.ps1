$repoPath = "$env:GITHUB_WORKSPACE"
$filePath = "$repoPath\manifest.json"
$content = Get-Content $filePath
if ($content -ne $null)
{
        echo "inside"
} 
else 
{
        echo "failed"
}
