#import "mod.typ": *

#show: book.page.with(title: [编写一篇基本文档])

Typst是一门简明但强大的现代排版语言，你可以使用简洁直观的语法排版出好看的文档。

Typst希望用户总是尽可能少的配置样式，就获得一个排版优秀的文档。这意味着在许多情况下，你都只需要进行文档的撰写，而不需要在文档内部对排版做任何更复杂的调整。

得益于此，本节只涉及编写一篇文档所需的最基本的语法。只要学会这些语法，你就已经可以在大部分场合下编写出满足需求的文档。

== 段落

在Typst中所有文本默认组成段落。

#code(```typ
我是一段文本
```)

另起一行文本不会产生新的段落。为了创建新的段落，你需要空至少一行。

#code(```typ
轻轻的我走了，
正如我轻轻的来；

我轻轻的招手，
作别西天的云彩。
```)

缩进并不会产生新的空格：

#code(```typ
  轻轻的我走了，
      正如我轻轻的来；

  我轻轻的招手，
      作别西天的云彩。
```)

注意：在Typst的中文排版中，另起一行会引入一个小的空格。该问题会在未来修复。

```typ
轻轻的我走了，
正如我轻轻的来；

轻轻的我走了，正如我轻轻的来；
```

#code(```typ
轻轻的我走了，#box(fill: blue, outset: (right: 0.2em), sym.space)
正如我轻轻的来；

轻轻的我走了，正如我轻轻的来；
```, show-cc: false)

== 标题

在Typst中，你可以使用一个或多个*连续*的「等于号」（`=`）开启一个标题。

#code(```typ
= 一级标题
我走了。
== 二级标题
我来了。
=== 三级标题
我走了又来了。
```)

等于号的数量恰好对应了标题的级别。一级标题由一个「等于号」开启，二级标题由两个「等于号」开启，以此类推。

注意：正如你所见，标题会强制划分新的段落。

== 着重和强调语义

在Typst中有许多与等于号类似的语法标记，当你以相应的语法标记文本内容时，相应的文本就被赋予了特别的语义和样式。

与许多标记语言相同，Typst中使用一系列「定界符」规则确定一段语义的开始和结束。为了组成一段带有语义的文本，需要将一个「定界符」置于文本之前，表示该语义的开始；同时将另一个「定界符」置于文本末尾，表示该语义的结束。

例如，「星号」（`*`）作为定界符赋予所包裹的一段文本以「着重语义」。

#code(```typ
着重语义：这里有一个*重点！*
```)

与「着重语义」类似，「下划线」（`_`）作为定界符将赋予「强调语义」：

#code(```typ
强调语义：_emphasis_
```)

着重语义一般比强调语义语气更重。着重和强调语义可以相互嵌套：

#code(```typ
着重且强调：*_strong emph_* 或 _*strong emph*_
```)

注意：中文排版一般不使用斜体表示着重或强调。

== （计算机）代码片段

Typst的代码片段标记语法与Markdown完全相同。如果你使用过Markdown，那么你将对以下代码片段的标记方式非常熟悉。

例如，配对的「反引号」（``` ` ```）包裹一段内容，表示内容为代码片段。

#code(````typ
短代码片段：`code`
````)

有时候你希望允许代码内容包含反引号。这时候，你需要使用*至少连续*三个「反引号」组成定界符标记代码片段：

#code(`````typ
包含反引号的长代码片段：``` ` ```

包含三个反引号的长代码片段：```` ``` ````
`````)

特别的，如果使用长的代码片段定界符包裹内容，你还可以在起始定界符后*紧接着*指定该代码的语言类别，以便Typst自动进行语法高亮。

#code(`````typ
一段有高亮的代码片段：```javascript function uninstallLaTeX {}```

另一段有高亮的代码片段：````typst 包含反引号的长代码片段：``` ` ``` ````
`````)

除了定界符的长短，代码片段还有是否成块的区分。如果代码片段符合以下两点，那么它就是一个「块代码片段」：
+ 使用*至少连续*三个「反引号」作为长定界符。
+ 包含至少一个换行符。

#code(`````typ
将代码片段插入行内：你可以通过单独实现```rust trait World```为Typst编译器提供执行环境。

让代码自成一段：```js
function fibnacci(n) {
  return n <= 1 ? n : fibonacci(n - 1) + fibonacci(n - 2);
}
```
`````)

// typ
// typc

== 列表

Typst的代码片段标记语法与Markdown非常类似，但不完全相同。如果你使用过Markdown，那么你将可以很快上手。

在Typst中，你可以使用一个的「减号」（`-`）开启一个无编号列表项，并使用缩进调整列表项等级：

#code(```typ
- 一级列表项1
  - 二级列表项1.1
    - 三级列表项1.1.1
  - 二级列表项1.2
- 一级列表项2
  - 二级列表项2.1
```)

与之相对，「加号」（`+`）开启一个有编号列表项，并可以与无编号列表项相混合。

#code(```typ
+ 一级列表项1
  - 二级列表项1.1
    + 三级列表项1.1.1
  - 二级列表项1.2
+ 一级列表项2
  - 二级列表项2.1
```)

注意，Markdown允许使用`1.`开启一个有编号列表项，但是Typst不允许。这意味着以下内容均为普通段落文本：

#code(```typ
1. 列表项1
1. 列表项2
1. 列表项3
```)

== 转义序列

有的时候，你不希望使用Typst提供的语义标记，而是直接展示标记符号本身的真实内容。例如，你可能希望在段落中直接展示一个「下划线」，而非期望使用「下划线」赋予强调语义：

#code(````typ
在段落中直接使用下划线 >\_<！
````)

Typst遵从了大部分语言的习惯，使用「反斜杠」（`\`）转义特殊标记。显然除了下划线，还有其他特殊符号，但这里我们就不再一一列出。你只需要记住一件事情：如果你发现一个字符无法直接输出到文档内容，请尝试在字符前添加一个反斜杠。

除了转义特殊字符，Typst还允许你使用`\u{unicode}`的语法，直接通过#link("https://zh.wikipedia.org/zh-cn/%E7%A0%81%E4%BD%8D")[Unicode码位]的值输出一个字符到文档内容。例如：

#code(````typ
香辣牛肉粉好吃\u{2665}
````)

== 内容块

通常情况下，我们只会使用着重或强调语义标记一小段段落，这时使用星号或下划线可以方便的对相应文本做标记。但有的时候我们需要连续大段的标记文本，此时需要使用内容块语法对一段文本做装饰。

内容块的内容使用中括号包裹，如下所示：

#code(```typ
#[一段文本]#[两段文本] #[三段文本]
```)

内容块的语法并不改变任何文本的语义。当Typst见到一个内容块时，它仅仅是解析内部的文本作为内容块的内容。由于我们没有任何额外的操作，内部的文本被原封不动的插入到原地。

乍一看，内容块并没有任何意义，但在接下来两小节我们将看到Typst作为一门语言的核心设计，也是进行更高级排版必须要掌握的知识点。由于本文的目标仅仅是《编写一篇基本文档》，我们将会尽可能减少引入更多知识点。接下来两小节，我们仅仅将一部分最简单常用的语法剥离开来，首先带读者管中窥豹地理解Typst的设计。

== 解释模式

回顾内容块的语法：

#code(```typ
#[一段文本]
```)

在这里，值得注意地是，在内容块前，还有一个「井号」（`#`）。那么，这个「井号」属于内容块的语法一部分吗？

答曰：「井号」与中括号不同，它是Typst中关于「解释模式」的定界符。

我们首先思考，是否可以直接像使用「星号」那样，直接将中括号包裹的一段作为内容块的内容？这是可以的，但是存在一些问题。例如，人们也常常在正文中使用中括号等标记，并甚至可能存在括号不匹配的情况：

#code(```typ
#[脚本模式中的中括号配对解析为内容块]

但是非脚本模式中的左中括号（[）被解析为普通文本
```)

于是，基于种种考虑，Typst的决定是：
+ 让文档默认处于「标记模式」。
+ 将「井号」作为定界符，代表*紧接*的内容以「脚本模式」解释。
+ 当处于「脚本模式」时，我们可以使用计算机编程处理文本内容。这大大提高了Typst的排版能力。
+ 同时，当处于「脚本模式」时，在*适当*的时候从「脚本模式」退回为「标记模式」。

在示例中，Typst在右中括号的位置退回了「标记模式」。再次回顾内容块的语法：

#code(```typ
#[一段文本后，]紧接着退回了标记模式，看：左中括号（[）
```)

== 函数和函数调用

内容块本身没有任何作用，但是允许我们进而使用函数标记大段内容，而不影响内容的书写。

在Typst中，函数与函数调用同样归属「脚本模式」，所以我们在调用函数时，需要先使用「井号」让Typst先进入「脚本模式」。

与大部分语言相同的是，在调用Typst函数时，你可以向其传递以「逗号」分隔的内容，这些内容被称为参数。

#code(```typ
四的三次方为#calc.pow(4, 3)。
```)

这里```typ #calc.pow()```是内置的幂函数，接受两个参数：第一个参数为4为幂的底，3为幂的指数。

同理，你可以使用函数修饰内容块。例如，你可以使用着重函数 ```typ #strong()``` 标记一整段内容：

#code(```typ
#strong([
  And every _fair from fair_ sometime declines,
  
  By chance, or nature's changing course untrimm'd;

  But thy _eternal summer_ shall not fade,

  Nor lose possession of that fair thou ow'st;
])
```)

类似地，```typ #emph()```可以标记一整段内容为强调语义：

#code(```typ
#emph([
  And every *fair from fair* sometime declines,
  
  By chance, or nature's changing course untrimm'd;

  But thy *eternal summer* shall not fade,

  Nor lose possession of that fair thou ow'st;
])
```)

在许多的语言中，函数参数必须包裹在函数调用参数列表。但在Typst中，如果将内容块作为参数，内容块可以紧贴在参数列表的「圆括号」之后。

#code(```typ
着重语义：这里有一个*重点！*

着重语义：这里有一个#strong([重点！])

着重语义：这里有一个#strong()[重点！]
```)

特别地，如果参数列表为空，Typst允许省略多余的参数列表。

#code(```typ
着重语义：这里有一个#strong()[重点！]

着重语义：这里有一个#strong[重点！]
```)

所以，示例也可以写为：

#code(```typ
#strong[
  And every _fair from fair_ sometime declines,
]

#emph[
  And every *fair from fair* sometime declines,
]
```)

== 文字修饰

- highlight
- overline
- underline
- strikethrough
- subscript
- superscript

== 文字颜色

略

== 图片

略

== 链接

略

== 引用

略

== 表格基础

略

== 数学模式

#code(````typ
行内数学公式：$sum_x$

行间数学公式：$ sum_x $
````)

== 注释

Typst采用C语言风格的注释语法。

Typst语言的注释有两种表示方法。

第一种写法是将注释放在「双斜杠」（`//`）后面，从双斜杠到行尾都属于注释。

#code(````typ
// 这是一行注释
一行文本 // 这也是注释
````)

与代码片段的情形类似，Typst也提供了另外一种格式的注释`/*...*/`。

#code(````typ
你没有看见/* 混入其中 */注释
````)

值得注意的是，Typst会将行注释从源码中剔除后再解释你的文档，因此它们对文档没有影响。

以下两个段落等价：

#code(````typ
注释不会
// 这是一行注释 // 注释内的注释还是注释
插入换行 // 这也是注释

注释不会
插入换行
````)

以下三个段落等价：

#code(````typ
注释不会/* 混入其中 */插入空格

注释不会/*
混入其中
*/插入空格

注释不会插入空格
````)

== 使用其他人的模板

虽然这是一片教你写基础文档的教程，但是为什么不更进一步？有赖于Typst将样式与内容分离，如果你能找到一个朋友愿意为你分享两行神秘代码，当你粘贴到文档开头时，你的文档将会变得更为美观：

#code(````typ
#import "latex-look.typ": latex-look
#show: latex-look

= 这是一篇与LaTeX样式更接近的文档

Hey there!

Here are two paragraphs. The
output is shown to the right.

Let's get started writing this
article by putting insightful
paragraphs right here!
+ following best practices
+ being aware of current results
  of other researchers
+ checking the data for biases

$
  f(x) = integral _(-oo)^oo hat(f)(xi)e^(2 pi i xi x) dif xi 
$
````)

一般来说，使用他人的模板需要做两件事：
+ 将`latex-look.typ`放在你的文档文件夹中。
+ 使用以下两行代码应用模板样式：

  ```typ
  #import "latex-look.typ": latex-look
  #show: latex-look
  ```

// set text font

== 总结

基于本节掌握的知识你应该可以：
+ 查看#(refs.reference-math-symbols)[《参考：常用数学符号》]，以助你编写简单的数学公式。

Todo：
+ 术语-翻译表
+ 本文使用的符号-标记对照表
+ 常用函数表和外部链接，用于增加广度。
