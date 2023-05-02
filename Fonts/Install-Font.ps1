# asciidoctor-pdf�ɂ��PDF�o��(�t�H���g)���Q�l�ɓ��{��p�t�H���g��Install����B
# https://waku-take-a.github.io/asciidoctor-pdf%25E3%2581%25AB%25E3%2582%2588%25E3%2582%258BPDF%25E5%2587%25BA%25E5%258A%259B(%25E3%2583%2595%25E3%2582%25A9%25E3%2583%25B3%25E3%2583%2588).html

$urls = @()
# �����S�V�b�N���J�����g�f�B���N�g����DL����B
# https://github.com/chloerei/asciidoctor-pdf-cjk-kai_gen_gothic/releases
$urls += "https://github.com/chloerei/asciidoctor-pdf-cjk-kai_gen_gothic/releases/download/v0.1.0-fonts/KaiGenGothicJP-Bold-Italic.ttf"
$urls += "https://github.com/chloerei/asciidoctor-pdf-cjk-kai_gen_gothic/releases/download/v0.1.0-fonts/KaiGenGothicJP-Bold.ttf"
$urls += "https://github.com/chloerei/asciidoctor-pdf-cjk-kai_gen_gothic/releases/download/v0.1.0-fonts/KaiGenGothicJP-Regular-Italic.ttf"
$urls += "https://github.com/chloerei/asciidoctor-pdf-cjk-kai_gen_gothic/releases/download/v0.1.0-fonts/KaiGenGothicJP-Regular.ttf"
# �R�[�f�B���O�p�ɋC�ɓ����Ă���t�H���gCica�B�ǐ��������̂ŊJ���h�L�������g�ɂ��Ȃ��ށB
# https://github.com/miiton/Cica
$urls += "https://github.com/miiton/Cica/releases/download/v5.0.3/Cica_v5.0.3.zip"

foreach ($url in $urls) {
    Invoke-WebRequest -Uri $url -OutFile @($url -split "/")[-1]
}

# Cica��ZIP�t�@�C����W�J����Fonts�t�H���_��Move����B
Expand-Archive "Cica_v5.0.3.zip"
ls .\Cica_v5.0.3 -Filter "*.ttf" | foreach {
    Move-Item $_.FullName -Destination .\
}
