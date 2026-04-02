# Matrix Rain for interactive PowerShell sessions.
# Safe: exits immediately when no real console is attached.

try {
    if (-not [Environment]::UserInteractive) { return }
    $null = [Console]::WindowWidth
} catch {
    return
}

[Console]::CursorVisible = $false
$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

$width = $Host.UI.RawUI.WindowSize.Width
$height = $Host.UI.RawUI.WindowSize.Height

$streams = for ($i = 0; $i -lt $width; $i++) {
    [PSCustomObject]@{
        X = $i
        Y = Get-Random -Minimum 0 -Maximum $height
        Length = Get-Random -Minimum 5 -Maximum 25
        Speed = Get-Random -Minimum 1 -Maximum 3
        Counter = 0
    }
}

while ($true) {
    foreach ($stream in $streams) {
        $stream.Counter++
        if ($stream.Counter -lt $stream.Speed) { continue }

        $stream.Counter = 0
        $stream.Y++

        if ($stream.Y -gt ($height + $stream.Length)) {
            $stream.Y = 0
            $stream.Length = Get-Random -Minimum 5 -Maximum 25
            $stream.Speed = Get-Random -Minimum 1 -Maximum 3
        }

        for ($i = 0; $i -lt $stream.Length; $i++) {
            $posY = $stream.Y - $i
            if ($posY -lt 0 -or $posY -ge $height) { continue }

            try {
                [Console]::SetCursorPosition($stream.X, $posY)
            } catch {
                return
            }

            $char = [char](Get-Random -Minimum 33 -Maximum 126)
            if ($i -eq 0) {
                Write-Host $char -NoNewline -ForegroundColor White
            } elseif ($i -lt 3) {
                Write-Host $char -NoNewline -ForegroundColor Green
            } else {
                Write-Host $char -NoNewline -ForegroundColor DarkGreen
            }
        }
    }

    Start-Sleep -Milliseconds 30
}
