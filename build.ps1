# Wraps sorry.html (the Artifact source, which has no <head>) into a complete
# standalone index.html for GitHub Pages. Edit sorry.html, then re-run this.
$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot

$src = Get-Content -Raw -LiteralPath (Join-Path $root 'sorry.html')

$title = 'One More Chance'
if ($src -match '(?s)^\s*<title>(.*?)</title>') {
    $title = $Matches[1]
    $src = $src -replace '(?s)^\s*<title>.*?</title>\s*', ''
}

$head = @"
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="robots" content="noindex, nofollow">
<meta name="theme-color" content="#FFF6F9">
<title>$title</title>
<meta property="og:title" content="I'm sorry.">
<meta property="og:description" content="Something I needed to say to you properly.">
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

$foot = "`n</body>`n</html>`n"

$out = Join-Path $root 'index.html'
Set-Content -LiteralPath $out -Value ($head + $src + $foot) -Encoding utf8 -NoNewline
Write-Host "built index.html ($((Get-Item $out).Length) bytes)"
