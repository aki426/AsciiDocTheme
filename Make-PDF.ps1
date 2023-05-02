cls 
# スクリプトファイルの配置フォルダを起点として実行する。
$origin_dir = $pwd

foreach ($_ in (ls -Filter "*.adoc" -Recurse)) {
    cd $_.DirectoryName

    if (-not (Test-Path .\pdf)) {
        mkdir pdf
    }

    $latest_file = @(ls .\pdf -Filter "????-??-??_??????_$($_.BaseName).pdf" | sort CreationTime -Descending)[0]
    if ($latest_file -eq $null) {
        # nop
    } else {
        if ($_.LastWriteTime -lt $latest_file.CreationTime)
        {
            # PDFファイルに対してadocファイルの更新日時が古ければ、PDFを再生成する意味が無いのでスキップする。
            Write-Host "$($_.Name) has no update after generating latest pdf file." -ForegroundColor Cyan
            Write-Host "skip." -ForegroundColor Yellow
            continue
        }
    }

    $outfile_name = (Get-Date -Format "yyyy-MM-dd_HHmmss_") + $_.BaseName + ".pdf"
    $cmd = "asciidoctor-pdf '$($_.Name)' -r asciidoctor-diagram -D .\pdf -o '$($outfile_name)' --trace　--verbose"

    # 実行
    Write-Host $cmd -ForegroundColor Cyan
    iex $cmd

    # 完了表示
    Write-Host "...done." -ForegroundColor Yellow
}

cd $origin_dir