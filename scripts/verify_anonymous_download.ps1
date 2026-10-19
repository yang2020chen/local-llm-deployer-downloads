$ErrorActionPreference = "Stop"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  Verifying Anonymous Public Distribution for V1.3.1" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$publicRepoUrl = "https://github.com/yang2020chen/local-llm-deployer-downloads"
$publicReleaseUrl = "https://github.com/yang2020chen/local-llm-deployer-downloads/releases/tag/v1.3.1"
$publicDownloadUrl = "https://github.com/yang2020chen/local-llm-deployer-downloads/releases/download/v1.3.1/LocalLlmDeployer-Setup-v1.3.1-x64.exe"

$privateRepoUrl = "https://github.com/yang2020chen/local-llm-windows"

# 1. Verify Anonymous HTTP Access to Web Pages
Write-Host "`n[1/4] Checking Anonymous HTTP Access to Public Repository & Release..." -ForegroundColor Yellow
$codeRepo = & curl.exe -s -o NUL -w "%{http_code}" "$publicRepoUrl"
$codeRelease = & curl.exe -s -o NUL -w "%{http_code}" "$publicReleaseUrl"
Write-Host "      Public Repo Web Page ($publicRepoUrl): HTTP $codeRepo"
Write-Host "      Public Release Page ($publicReleaseUrl): HTTP $codeRelease"

if ($codeRepo -ne "200" -or $codeRelease -ne "200") {
    throw "Public repo or release page returned unexpected HTTP status!"
}
Write-Host "      [PASS] Public pages are freely accessible without authentication." -ForegroundColor Green

# 2. Check Anonymous Direct Download URL Headers (302 Redirect to CDN)
Write-Host "`n[2/4] Checking Direct Download URL Redirection..." -ForegroundColor Yellow
$codeDownloadHead = & curl.exe -s -o NUL -w "%{http_code}" -I "$publicDownloadUrl"
Write-Host "      Initial Download URL HTTP Status: $codeDownloadHead"
if ($codeDownloadHead -ne "302") {
    Write-Warning "Initial download URL returned HTTP $codeDownloadHead (expected 302 redirect)."
}

# 3. Perform Full Anonymous Download via curl (no auth/cookies)
Write-Host "`n[3/4] Performing full anonymous download of installer via curl..." -ForegroundColor Yellow
$testDir = "C:\TestInstall\AnonDownload_v1_3_1"
if (Test-Path $testDir) { Remove-Item -Recurse -Force $testDir }
New-Item -ItemType Directory -Force -Path $testDir | Out-Null
$destFile = Join-Path $testDir "LocalLlmDeployer-Setup-v1.3.1-x64.exe"

$sw = [System.Diagnostics.Stopwatch]::StartNew()
& curl.exe -L -s -S --fail -o "$destFile" "$publicDownloadUrl"
$sw.Stop()
Write-Host "      Download completed in $([math]::Round($sw.Elapsed.TotalSeconds, 1)) seconds."

if (-not (Test-Path $destFile)) {
    throw "Downloaded file does not exist at $destFile!"
}

$item = Get-Item $destFile
$hash = (Get-FileHash -Path $destFile -Algorithm SHA256).Hash
$expectedLen = 422717074
$expectedHash = "30B1A294A7187E9832EE36FD924E1F50A4CD3AB13C6570942AC02ED81884AFEB"

Write-Host "      Downloaded Path:   $destFile"
Write-Host "      Downloaded Bytes:  $($item.Length)"
Write-Host "      Downloaded SHA256: $hash"

if ($item.Length -ne $expectedLen) {
    throw "Downloaded length mismatch! Expected $expectedLen, got $($item.Length)"
}
if ($hash -ne $expectedHash) {
    throw "Downloaded SHA-256 mismatch! Expected $expectedHash, got $hash"
}
Write-Host "      [PASS] Anonymous downloaded installer matches exact byte count and SHA-256!" -ForegroundColor Green

# 4. Verify Original Development Repository Remains PRIVATE
Write-Host "`n[4/4] Verifying Original Development Repository Remains PRIVATE..." -ForegroundColor Yellow
$codePrivate = & curl.exe -s -o NUL -w "%{http_code}" "$privateRepoUrl"
Write-Host "      Original Private Repo Anonymous HTTP Status: $codePrivate"
if ($codePrivate -ne "404") {
    throw "Private repo returned HTTP $codePrivate to anonymous user (expected 404)!"
}
Write-Host "      [PASS] Original development repository is confirmed 100% PRIVATE." -ForegroundColor Green

# Cleanup downloaded file
Remove-Item -Recurse -Force $testDir -ErrorAction SilentlyContinue

Write-Host "`n==========================================================" -ForegroundColor Green
Write-Host ">>> Anonymous Public Distribution Verification: ALL PASS <<<" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green
