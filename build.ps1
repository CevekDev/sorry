# Wraps each Artifact source (which has no <head>) into a complete standalone
# page for GitHub Pages. Edit the source listed in $pages, then re-run this.
#
# Encoding is handled through .NET rather than Get-Content/Set-Content: on
# Windows PowerShell 5.1 those default to the ANSI codepage for BOM-less files,
# which mangles every accented character in the French page.
$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot

$pages = @(
    @{
        src     = 'sorry.html'
        out     = 'index.html'
        lang    = 'en'
        ogTitle = "I'm sorry."
        ogDesc  = 'Something I needed to say to you properly.'
    },
    @{
        src     = 'date.html'
        out     = 'sortie.html'
        lang    = 'fr'
        ogTitle = 'Sors avec moi'
        ogDesc  = "Une question, un calendrier, et une soiree a choisir."
    },
    @{
        src     = 'minuit.html'
        out     = 'gala.html'
        lang    = 'fr'
        ogTitle = 'Minuit dore'
        ogDesc  = "Une invitation. Reponds, choisis le soir, choisis la soiree."
    }
)

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

foreach ($page in $pages) {
    $srcPath = Join-Path $root $page.src
    if (-not (Test-Path -LiteralPath $srcPath)) {
        Write-Host "skipped $($page.src) (not found)"
        continue
    }

    $body = [System.IO.File]::ReadAllText($srcPath, [System.Text.Encoding]::UTF8)

    $title = $page.ogTitle
    if ($body -match '(?s)^\s*<title>(.*?)</title>') {
        $title = $Matches[1]
        $body = $body -replace '(?s)^\s*<title>.*?</title>\s*', ''
    }

    $head = @"
<!doctype html>
<html lang="$($page.lang)">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="robots" content="noindex, nofollow">
<meta name="theme-color" content="#FFF6F9">
<title>$title</title>
<meta property="og:title" content="$($page.ogTitle)">
<meta property="og:description" content="$($page.ogDesc)">
<meta property="og:type" content="website">
<style>
  html{color-scheme:light}
  body{margin:0}
  img{max-width:100%}
  [hidden]{display:none!important}
</style>
</head>
<body>
"@

    $outPath = Join-Path $root $page.out
    [System.IO.File]::WriteAllText($outPath, ($head + $body + "`n</body>`n</html>`n"), $utf8NoBom)
    Write-Host "built $($page.out) from $($page.src) ($((Get-Item $outPath).Length) bytes)"
}
