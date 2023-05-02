# asciidoctor-pdfによるPDF出力(フォント)を参考に日本語用フォントをInstallする。
# https://waku-take-a.github.io/asciidoctor-pdf%25E3%2581%25AB%25E3%2582%2588%25E3%2582%258BPDF%25E5%2587%25BA%25E5%258A%259B(%25E3%2583%2595%25E3%2582%25A9%25E3%2583%25B3%25E3%2583%2588).html

$urls = @()
# 懐源ゴシックをカレントディレクトリにDLする。
# https://github.com/chloerei/asciidoctor-pdf-cjk-kai_gen_gothic/releases
$urls += "https://github.com/chloerei/asciidoctor-pdf-cjk-kai_gen_gothic/releases/download/v0.1.0-fonts/KaiGenGothicJP-Bold-Italic.ttf"
$urls += "https://github.com/chloerei/asciidoctor-pdf-cjk-kai_gen_gothic/releases/download/v0.1.0-fonts/KaiGenGothicJP-Bold.ttf"
$urls += "https://github.com/chloerei/asciidoctor-pdf-cjk-kai_gen_gothic/releases/download/v0.1.0-fonts/KaiGenGothicJP-Regular-Italic.ttf"
$urls += "https://github.com/chloerei/asciidoctor-pdf-cjk-kai_gen_gothic/releases/download/v0.1.0-fonts/KaiGenGothicJP-Regular.ttf"
# コーディング用に気に入っているフォントCica。可読性が高いので開発ドキュメントにもなじむ。
# https://github.com/miiton/Cica
$urls += "https://github.com/miiton/Cica/releases/download/v5.0.3/Cica_v5.0.3.zip"

foreach ($url in $urls) {
    Invoke-WebRequest -Uri $url -OutFile @($url -split "/")[-1]
}

# CicaのZIPファイルを展開してFontsフォルダにMoveする。
Expand-Archive "Cica_v5.0.3.zip"
ls .\Cica_v5.0.3 -Filter "*.ttf" | foreach {
    Move-Item $_.FullName -Destination .\
}
