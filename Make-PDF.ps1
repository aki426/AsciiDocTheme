cls 
# �X�N���v�g�t�@�C���̔z�u�t�H���_���N�_�Ƃ��Ď��s����B
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
            # PDF�t�@�C���ɑ΂���adoc�t�@�C���̍X�V�������Â���΁APDF���Đ�������Ӗ��������̂ŃX�L�b�v����B
            Write-Host "$($_.Name) has no update after generating latest pdf file." -ForegroundColor Cyan
            Write-Host "skip." -ForegroundColor Yellow
            continue
        }
    }

    $outfile_name = (Get-Date -Format "yyyy-MM-dd_HHmmss_") + $_.BaseName + ".pdf"
    $cmd = "asciidoctor-pdf '$($_.Name)' -r asciidoctor-diagram -D .\pdf -o '$($outfile_name)' --trace�@--verbose"

    # ���s
    Write-Host $cmd -ForegroundColor Cyan
    iex $cmd

    # �����\��
    Write-Host "...done." -ForegroundColor Yellow
}

cd $origin_dir