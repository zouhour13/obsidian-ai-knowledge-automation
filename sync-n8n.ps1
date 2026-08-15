param(
    [Parameter(Mandatory=$true)]
    [string]$CommitMessage
)

$WorkflowId = "u94XogbUybzZLcI8"
$ExportFile = "/tmp/ai-obsidian.json"
$LocalFile = ".\workflow\AI Obsidian Assistant.json"

Write-Host "=== AI Obsidian Assistant Sync ===" -ForegroundColor Cyan

Write-Host "`n[1/4] Exporting workflow from n8n..." -ForegroundColor Yellow

docker exec n8n n8n export:workflow --id=$WorkflowId --output=$ExportFile

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: n8n export failed." -ForegroundColor Red
    exit 1
}

Write-Host "`n[2/4] Copying workflow to repository..." -ForegroundColor Yellow

docker cp "n8n:$ExportFile" $LocalFile

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Docker copy failed." -ForegroundColor Red
    exit 1
}

Write-Host "Workflow synchronized." -ForegroundColor Green

Write-Host "`n[3/4] Creating Git commit..." -ForegroundColor Yellow

git add $LocalFile

git add .\sync-n8n.ps1

git commit -m $CommitMessage

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Git commit failed." -ForegroundColor Red
    exit 1
}

Write-Host "Commit created successfully." -ForegroundColor Green

Write-Host "`n[4/4] Pushing to GitHub..." -ForegroundColor Yellow

git push

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Git push failed." -ForegroundColor Red
    exit 1
}

Write-Host "`n=== Sync completed successfully ===" -ForegroundColor Green