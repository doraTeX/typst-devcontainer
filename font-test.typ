#set text(font: "Hiragino Mincho ProN")
#show strong: set text(font: "Hiragino Sans", weight: "medium", fill: red)
#show emph: set text(font: "Hiragino Maru Gothic ProN", fill: blue)

#let AppleEmoji(body) = {
    set text(font: ("Apple Color Emoji"))
    body
}

現在のTypstバージョンは #sys.version です。

ここは*強調*します。この部分は_丸ゴシック_です。

なお、☃は、#emoji.snowman;や#AppleEmoji("☃")などと出力されます。
