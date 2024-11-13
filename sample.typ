#set text(font: "Hiragino Mincho ProN")
#show strong: set text(font: "Hiragino Sans", weight: "regular")

#set par(justify: true, first-line-indent: 1em)
#set page(numbering: "— 1 —")
#let numeq(eq) = {
  math.equation(
    block: true,
    numbering: "(1)",
    number-align: bottom,
    supplement: none,
    eq,
  )
}


#show ref: it => {
  if it.element != none and it.element.func() == math.equation {
    link(it.target)[式 (#it)]
  } else {
    it
  }
}

#let dummy-par = {
  par(text(size: 0pt, ""))
  v(-1em)
}


#let today = datetime.today()

#let title(body) = {
  set align(center)
  text(weight: "black", size: 2em)[#body]
  v(0em)
  today.display("[year]年[month padding:none]月[day padding:none]日")
  v(2em)
}


#import "@preview/showybox:2.0.1": *



#let lemma-number = counter("lemma-number")
#let lemma(body) = {
  v(1em)
  lemma-number.step()
  showybox(
    title: strong("補題" + context (lemma-number.display())),
    frame: (
      border-color: olive,
      title-color: olive.lighten(10%),
      body-color: olive.lighten(95%),
      footer-color: olive.lighten(80%),
    ),
  )[
    #dummy-par
    #body]
  v(1em)
}

#let theorem-number = counter("theorem-number")
#let theorem(title, body) = {
  v(1em)
  theorem-number.step()
  showybox(
    title: strong("定理" + context (theorem-number.display()) + "：" + title),
    frame: (
      border-color: blue,
      title-color: blue.lighten(10%),
      body-color: blue.lighten(95%),
      footer-color: blue.lighten(80%),
    ),
  )[
    #dummy-par
    #body]
  v(1em)
}

#import "@preview/quick-maths:0.1.0": shorthands
#show: shorthands.with(
  ($<=$, $lt.equiv$),
  ($>=$, $gt.equiv$),
)
#set enum(numbering: "(1)", spacing: 1.5em)

#let limn = {
  $display(lim_(n -> ∞))$
}
#let qed = sym.qed

#title[高校数学の範囲内でのガウス積分の導出]

ガウス積分の公式
$ ∫_(-∞)^∞ e^(-x^2) d x = √π $
を、重積分の変数変換などは用いず、高校数学の範囲内で導出しよう。

#lemma[
  $x >= 0$ に対して、次の不等式が成り立つ。
  $ 1-x <= e^(-x) <= 1 / (1+x) $
]

*証明*

右側は不等式 $e^x >= 1+x #h(.6em)  (x in bb(R))$ から従い、左側はこの $x$ を $-x$ としたものである。
#qed

#lemma[
  $I_n= ∫_0^(π/2) cos^n θ thin d θ quad (n=0,1,2,...)$ とおくと、以下の性質が成り立つ
  #footnote[
    $!!$ は「二重階乗」という記号で、
    $
      (2n-1)!! &= (2n-1) dot (2n-3) dot dots.h.c dot 3 dot 1\
      (2n)!! &= 2n dot (2n-2) dot dots.h.c dot 4 dot 2\
      0!! &=1
    $
    と定義される。
  ]
  。

  #v(.5em)

  + $I_(n+1) <= I_n$
  + $I_(n+2) = display((n+1)/(n+2)I_n)$
  + $I_(2n)= display((2n-1)!!/(2n)!! dot π/2)$
  + $I_(2n+1)=display((2n)!!/(2n+1)!!)$
  + $I_(2n)dot I_(2n+1)=display(π/(2(2n+1)))$
  + $limn display(I_(2n+1)/I_(2n))=1$
  + $limn n (I_(2n+1))^2=display(π/4)$
  + $limn n (I_(2n-2))^2=display(π/4)$

  #v(1em)

]

*証明*


#enum(
  [$ cos^(n+1) θ <= cos^n θ$ なので明らか。],
  [部分積分で漸化式を立てる。],
  [(2)を繰り返し使う。],
  [(2)を繰り返し使う。],
  [(3)と(4)を辺々掛け合わせる。],
  [(1)と(2)より、
    $
      (2n+1) / (2n+2)= ((2n+1) / (2n+2)I_(2n)) / I_(2n)
      = I_(2n+2) / I_(2n) <=
      I_(2n+1) / I_(2n) <= I_(2n+1) / I_(2n+1)
      = 1
    $
    よって、
    $ (2n+1) / (2n+2) <= I_(2n+1) / I_(2n) <= 1 $
    が成り立ち、$ limn display((2n+1)/(2n+2))=1$ なので、はさみうちの原理より
    $ limn I_(2n+1) / I_(2n)=1 $
    が成り立つ。 #qed
  ],
  [#v(-.7em)
    $
      n (I_(2n+1))^2 &= I_(2n+1)/I_(2n) dot n thin I_(2n)I_(2n+1)\
&= I_(2n+1)/I_(2n) dot (n π)/(2(2n+1))wide (∵ (5))\
&-->_(n -> ∞) 1 times  π /4 wide(∵ (6))\
&= π/4 wide  #qed
    $
  ],
  [#v(-.7em)
    $
      n (I_(2n-2))^2 &= I_(2n-1)/I_(2n-2) dot n thin I_(2n-2) I_(2n-1)\
 &= I_(2n-1)/I_(2n-2) dot (n π)/(2(2n-1)) wide(∵(5))\
&-->_(n -> ∞ ) 1 times  π/4 wide(∵ (6))\
&= π/4 wide  #qed
    $
  ],
)

#theorem[ガウス積分][$ ∫_(-∞)^∞ e^(-x^2) d x = √π $]

*証明*

$R->∞$ を考えるので、$R>1$ としてよい。$R$ を超えない最大の整数を $n$ とおき、$a=R/√n$ とおくと、$a>= 1$ となる。

補題1の $x$ に $t^2 #h(.5em)  (t>= 0)$ を代入して、

#numeq[
  $
    1-t^2<= e^(-t^2) <= 1 / (1+t^2)
  $]<1>

#dummy-par
$0<= t<= 1$ の範囲では、@1 の各辺はいずれも非負であるので、各辺を $n$ 乗して、
$
  (1-t^2)^n<= e^(-n t^2) <= 1 / (1+t^2)^n wide (0<= t<= 1)
$

#dummy-par
これを $t in [0,1]$ で積分して、
#numeq[
  $
    ∫_0^1 (1-t^2)^n d t <= ∫_0^1e^(-n t^2)d t <= ∫_0^1 1 / (1+t^2)^n d t
  $
]<2>

#dummy-par
一方、$1<= t<= a$ の範囲では、@1 の最左辺は正でないが、それ以外は正であるので、
$
  0<= e^(-t^2)<= 1 / (1+t^2) wide (1<= t<= a)
$

#dummy-par
この各辺を $n$ 乗して、
$
  0<= e^(-n t^2)<= 1 / (1+t^2)^n wide (1<= t<= a)
$

#dummy-par
これを $t in [1,a]$ で積分して、
#numeq[$
    0<= ∫_1^a e^(-n t^2)d t <= ∫_1^a 1 / (1+t^2)^n thin d t
  $]<3>

#dummy-par
@2 と@3 の辺々を足して、
#numeq[$
    ∫_0^1(1-t^2)^n d t<= ∫_0^a e^(-n t^2)d t<= ∫_0^a 1 / (1+t^2)^n thin d t
  $]<4>

#dummy-par
@4 の最左辺について、$t= sin θ$ と置換すると、
#numeq[$
    ∫_0^1 (1-t^2)^n d t &= ∫_0^(π / 2) (1- sin^2 θ)^n cos θ thin d θ
    &= ∫_0^(π / 2) cos^(2n+1) θ thin d θ = I_(2n+1)
  $]<5>

#dummy-par
@4 の最右辺について、$t= tan θ$ と置換する。$tan α=a$ となる角 $α med (0<α<π/2)$ をとると、
#numeq[$
    ∫_0^a 1 / (1+t^2)^n d t &= ∫_0^α 1 / (1+ tan^2 θ)^n dot (d θ) / (cos^2 θ)\
    &= ∫_0^α cos^(2n-2) θ d θ\
    &<= ∫_0^(π / 2) cos^(2n-2) θ thin d θ
    = I_(2n-2)
  $]<6>

#dummy-par
@4 の中辺について、$t= x/√n$ と置換すると、
#numeq[$
    ∫_0^a e^(-n t^2)d t &= ∫_0^(a √n)e^(-x^2) dot 1 / √n thin d x\
    &= 1 / √n ∫_0^R e^(-x^2)d x wide (∵ a= R / √n)
  $]<7>

#dummy-par

@4, @5, @6, @7 より、
#numeq[$
    &I_(2n+1)<= 1 / √n ∫_0^R e^(-x^2)d x <= I_(2n-2)\
    therefore & √n thin I_(2n+1)<= ∫_0^R e^(-x^2) d x <= √n thin I_(2n-2)\
    therefore & √(n(I_(2n+1))^2) <=∫_0^R e^(-x^2) d x <= √(n(I_(2n-2))^2)
  $]<8>

#dummy-par
ここで、$n=floor(R)$ であったので、$R->∞$ のとき $n->∞$ となる。さらに、補題2の (7), (8)より、@8 の最左辺・最右辺は $n->∞$ のときともに $ √(π/4)=  √π/2$ に収束する。よって、はさみうちの原理より、
$ lim_(R->∞) ∫_0^R e^(-x^2) d x = √π / 2 $
が成り立つ。ゆえに
$ ∫_0^∞ e^(-x^2) d x = √π / 2 $
であるので
$ ∫_(-∞)^∞ e^(-x^2) d x = √π wide qed $
