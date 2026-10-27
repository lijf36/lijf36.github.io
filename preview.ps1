[CmdletBinding()]
param(
    [ValidateRange(1, 65535)]
    [int]$Port = 4000,
    [switch]$Build
)

$ErrorActionPreference = 'Stop'
$previousPath = $env:PATH
$previousRubyOpt = $env:RUBYOPT
$previousConsoleEncoding = [Console]::OutputEncoding
$exitCode = 1

Push-Location -LiteralPath $PSScriptRoot
try {
    $utf8 = New-Object System.Text.UTF8Encoding($false)
    [Console]::OutputEncoding = $utf8
    $OutputEncoding = $utf8
    $env:RUBYOPT = (($previousRubyOpt, '-EUTF-8') -join ' ').Trim()

    $ruby = Get-Command ruby -CommandType Application -ErrorAction SilentlyContinue |
        Select-Object -First 1
    if ($ruby) {
        $rubyPath = $ruby.Source
    } else {
        $rubyPath = Join-Path $env:LOCALAPPDATA 'Programs\Ruby33-x64\bin\ruby.exe'
        if (-not (Test-Path -LiteralPath $rubyPath)) {
            throw 'Ruby was not found. Install Ruby+Devkit 3.3 x64 first; see README.md.'
        }
    }

    # Use the selected Ruby's companion commands, even in an existing terminal.
    $rubyBin = Split-Path -Parent $rubyPath
    $env:PATH = "$rubyBin;$previousPath"
    & $rubyPath -S bundle --version
    if ($LASTEXITCODE -ne 0) {
        throw 'Bundler is unavailable. Run gem install bundler, then bundle install; see README.md.'
    }

    & $rubyPath -S bundle check
    if ($LASTEXITCODE -ne 0) {
        throw 'Project dependencies are missing. Run bundle install in this folder; see README.md.'
    }

    if ($Build) {
        & $rubyPath -S bundle exec jekyll build
    } else {
        Write-Host "Starting local preview at http://localhost:$Port/"
        Write-Host 'Wait for the server-ready message. Press Ctrl+C to stop.'
        & $rubyPath -S bundle exec jekyll serve --host 127.0.0.1 --port $Port
    }
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne 0) {
        throw "Jekyll exited with code $exitCode. Review the output above."
    }
} catch {
    Write-Error -Message $_.Exception.Message -ErrorAction Continue
    $exitCode = 1
} finally {
    $env:PATH = $previousPath
    $env:RUBYOPT = $previousRubyOpt
    [Console]::OutputEncoding = $previousConsoleEncoding
    Pop-Location
}
exit $exitCode
