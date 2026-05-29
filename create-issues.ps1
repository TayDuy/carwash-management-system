param (
    [string]$ProjectNumber = "",
    [string]$ProjectOwner = "phamtiendung-2005"
)

$repo = "TayDuy/carwash-management-system"
$file = "d:\carwash-management-system-main\carwash-management-system-main\github-issues-to-create.md"

Write-Host "=========================================================="
Write-Host "GitHub Issues Creator & Project Board Integrator"
Write-Host "Repository: $repo"
if ($ProjectNumber) {
    Write-Host "Target Project Number: $ProjectNumber"
    Write-Host "Target Project Owner: $ProjectOwner"
} else {
    Write-Host "No Project Number specified. Skipping Project Board integration."
}
Write-Host "=========================================================="

# 1. Create labels if they do not exist
$labels = @("epic", "backend", "frontend", "ml", "admin", "integration", "data", "docs", "database", "testing", "ci", "security", "compliance")
foreach ($l in $labels) {
    Write-Host "Ensuring label '$l' exists..."
    # Suppress errors if already exists
    & gh label create $l --repo $repo --color "5319e7" --description "Auto-created by script" 2>$null
}

# 2. Read and parse markdown file
if (-not (Test-Path -Path $file)) {
    Write-Error "File not found: $file"
    exit 1
}

$content = Get-Content -Path $file -Raw
$sections = $content -split '(?m)^---$'

$issueUrls = @()

foreach ($section in $sections) {
    $section = $section.Trim()
    if ($section -eq "" -or $section -like "*End of list.*" -or $section -like "Repository:*") {
        continue
    }
    
    # Extract title
    $titleMatch = [regex]::Match($section, '(?m)^##\s*(.*?)$')
    if (-not $titleMatch.Success) {
        continue
    }
    $title = $titleMatch.Groups[1].Value.Trim()
    
    # Extract Labels
    $labelsMatch = [regex]::Match($section, '(?m)^Labels:\s*(.*?)$')
    $secLabels = ""
    if ($labelsMatch.Success) {
        $secLabels = $labelsMatch.Groups[1].Value.Trim()
    }
    
    # Extract Assignees
    $assigneesMatch = [regex]::Match($section, '(?m)^Assignees:\s*(.*?)$')
    $secAssignees = @()
    if ($assigneesMatch.Success) {
        $assigneesStr = $assigneesMatch.Groups[1].Value.Trim()
        $secAssignees = $assigneesStr.Replace("@", "").Split(",") | ForEach-Object { $_.Trim() }
    }
    
    # Extract Body
    $lines = $section -split "`r?`n"
    $bodyLines = @()
    $startBody = $false
    foreach ($line in $lines) {
        if ($line -like "## *" -or $line -like "Labels:*" -or $line -like "Assignees:*") {
            continue
        }
        if (-not $startBody -and $line.Trim() -eq "") {
            continue
        }
        $startBody = $true
        $bodyLines += $line
    }
    $body = $bodyLines -join "`n"
    $body = $body.Trim()
    
    Write-Host "`n----------------------------------------"
    Write-Host "Processing Issue: $title"
    Write-Host "Labels: $secLabels"
    Write-Host "Assignees: ($($secAssignees -join ', '))"
    
    # Prepare arguments
    $labelsArg = $secLabels.Split(",") | ForEach-Object { $_.Trim() }
    
    $argsList = @("issue", "create", "--repo", $repo, "--title", $title, "--body", $body)
    foreach ($l in $labelsArg) {
        if ($l -ne "") {
            $argsList += "--label"
            $argsList += $l
        }
    }
    
    # Build list with assignees
    $argsWithAssignees = $argsList.Clone()
    foreach ($a in $secAssignees) {
        if ($a -ne "") {
            $argsWithAssignees += "--assignee"
            $argsWithAssignees += $a
        }
    }
    
    $createdUrl = ""
    
    # Attempt creation with assignees
    $out = & gh $argsWithAssignees 2>&1
    $exitCode = $LASTEXITCODE
    
    if ($exitCode -ne 0) {
        Write-Warning "Could not assign users (likely due to pending invites). Creating issue without assignees..."
        $out = & gh $argsList 2>&1
        $exitCode = $LASTEXITCODE
        if ($exitCode -ne 0) {
            Write-Error "Failed to create issue: $out"
        } else {
            $createdUrl = $out.Trim()
            Write-Host "Success (unassigned): $createdUrl"
        }
    } else {
        $createdUrl = $out.Trim()
        Write-Host "Success: $createdUrl"
    }
    
    if ($createdUrl -and $createdUrl.StartsWith("http")) {
        $issueUrls += $createdUrl
        
        # Add to Project Board if number provided
        if ($ProjectNumber) {
            Write-Host "Adding to Project $ProjectNumber..."
            $projOut = & gh project item-add $ProjectNumber --owner $ProjectOwner --url $createdUrl 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Host "Successfully added to Project Board!"
            } else {
                Write-Warning "Could not add to Project Board: $projOut"
            }
        }
    }
}

Write-Host "`n=========================================================="
Write-Host "Completed! Created $($issueUrls.Count) issues."
Write-Host "=========================================================="
