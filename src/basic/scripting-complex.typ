#import "mod.typ": *

#show: book.page.with(title: "复合字面量、控制流和复杂函数")

== Hello World程序改

有的时候，我们想要访问字面量、变量与函数中存储的“信息”。例如，给定一个字符串```typ #"Hello World"```，我们想要截取其中的第二个单词。单词`World`就在那里，但仅凭我们有限的脚本知识，却没有方法得到它。这是因为字符串本身是一个整体，虽然它有信息，我们却缺乏了*访问*信息的方法。

Typst为我们提供了「成员」和「方法」两种概念访问这些信息。使用「方法」，可以使用以下脚本完成目标：

#code(```typ
#"Hello World".split(" ").at(1)
```)

为了方便讲解，我们将其拆分为6行脚本。除了第二行，每一行都输出一段内容：

#code(```typ
#let x = "Hello World"; #x \
#let split = str.split
#split(x, " ") \
#str.split(x, " ") \
#x.split(" ") \
#x.split(" ").at(1)
```)

从```typ #x.split(" ").at(1)```的输出可以看出，这一行帮助我们实现了“截取其中的第二个单词”的目标。我们虽然隐隐约约能揣测出其中的意思：

```typ
#(       x .split(" ")           .at(1)          )
// 将字符串 根据字符串拆分  取出其中的第2个单词（字符串）
```

但至少我们对「点号」（`.`）仍是一无所知。

本节我们就来讲解Typst中较为高级的脚本语法。这些脚本语法与大部分编程语言的语法相同，但是我们假设你并不知道这些语法。

== 成员与方法

Typst提供了一系列「成员」和「方法」访问字面量、变量与函数中存储的“信息”。

其实在上一节，我们就已经使用了「成员」语法。回忆：

#code(```typ
这是一个代码块内容：`Hello world!!!`

这是一段文本：#`Hello world!!!`.text
```)

其中，```typ `Hello world!!!` ```是一个代码块内容，而`text`英文单词的意思是“文本”。在Typst的世界中，文本”就是“代码块”的一个固有属性，也就是说：文本是代码块的「成员」。由此我们可以通过「点号」，即```typ #`Hello world!!!`.text ```，获得代码块的文本内容。

进一步，「方法」则是一种特殊的「成员」。准确来说，如果一个「成员」是一个对象的函数，那么它就被称为该对象的「方法」。

为了体会“「方法」则是一种特殊的「成员」”这句话，我们来看Hello World程序的第三行、第四行与第五行脚本：

#code(```typ
#let x = "Hello World"
#let str-split = str.split
#str-split(x, " ") \
#str.split(x, " ") \
#x.split(" ")
```)

它们输出了相同的内容，事实上，它们是*同一*「函数调用」的不同写法。

第三行脚本含义对照如下：

```typ
#(        str-split(         x,  " "   ))
// 调用  字符串拆分函数，参数为 变量x和空格
```

我们之前已经学过，这正是「函数调用」的语法。

观察第四行脚本，我们还发现调用`str.split`函数的输出与调用`str-split`函数的输出一样。`str.split(...)`实际上就是在做「函数调用」，只不过在语法上更为紧凑。

第五行脚本的写法则更加简明。这种写法被称为「方法调用」，即一种特殊的「函数调用」，是一个在各编程语言中广泛存在的简写规则。约定`str.split(x, y)`可以简写为`x.split(y)`，如果：
+ `x`是`str`类型。
+ `x`是`str.split`的第一个参数。

这个规则可以进一步推及其他类型和类型的方法。

这就避免了我们写非常一长串脚本：

#code(```typ
#let x = "Hello World" // 声明变量`x`与"Hello World"等同。
#let split = str.split // 声明函数`split`为属于`str`的`split`函数。
#split(x, " ")         // 调用函数`split`，参数为变量`x`本身和一个空格。
```)

这里有一个问题：为什么Typst要引入「方法」的概念呢？主要有以下几点考量。

其一，为了引入「方法调用」的语法，这种语法相对要更为方便和易读。对比以下两行，它们都完成了获取`"Hello World"`字符串的第二个单词的第一个字母的功能：

#code(```typ
#"Hello World".split(" ").at(1).split("").at(1)

#array.at(str.split(array.at(str.split("Hello World", " "), 1), ""), 1)
```)

可以明显看见，第一行脚本全部写在一行还能很方便地阅读，但第二行语句的参数已经散落在括号的里里外外，很难理解到底做了什么事情。

其二，相比「函数调用」，「方法调用」更有利于现代IDE补全脚本。如果你使用了带脚本自动补全的编辑器，当你在`"Hello World"`字符串后敲下一个「点号」时，IDE会自动联想你接下来可能需要与“字符串”相关的函数，你便可以通过`.split`很快定位到“字符串拆分”这个函数。

与之相对，「函数调用」的“筛选效率”更低。若想调用`str-split`或`str.split`，我们首先需要敲下一个`s`字符，很快编辑器就会把所有以`s`开头的函数都告诉你了，这可就有点头疼了。

其三，方便用户管理相似功能的函数。你很快就可以联想到，不仅仅是字符串可以拆分，似乎内容也可以拆分。不仅如此，我们将来可能还有各种各样的拆分。如果需要为他们都取不同的名字，那可就太头疼了。相比`str.split`就简单多了。要知道，程序员最讨厌给变量和函数想命名这种东西了。

接下来只需要理解最后一行脚本，我们就彻底搞懂这个Hello World程序了。看起来，它也是属于其他什么类型的一个「方法」。

#code(```typ
#let x = "Hello World".split(" ")
#x.at(1)
```)

若需要理解最后一行，则需引入「数组」的概念。

== 数组和字典字面量

当处于脚本模式下，可以创建两种非常重要的复合字面量，它们是「数组」和「字典」。

先看数组字面量。在Typst中，数组是按照顺序存储的y一些「值」，你可以在数组中存放任意内容。你可以使用圆括号与一个逗号分隔的列表创建一个数组：

#code(```typ
#let x = (1, "Hello, World", [一段内容])
#x
```)

构造数组字面量时，允许尾随一个多余的逗号而不造成影响。

#code(```typ
#let x = (1, "Hello, World", [一段内容] , )
//                   这里有一个多余的逗号^^^
#x
```)

为了访问数组，你可以使用`at`方法。

#code(```typ
#let x = (1, "Hello, World", [一段内容])
#x.at(0) \
#x.at(1) \
#x.at(2)
```)

“at”在中文里是“在”的意思，它表示对「数组」使用「索引」操作。可见，在`x`数组中，第0个值就是我们刚刚在字面量声明中的第一个值，第1个值就是我们刚刚在字面量声明中的第二个值，以此类推。至于为什么「索引」从零开始，这只是一个约定俗成。相信等你习惯了，你也会变成计数从零开始的好程序员。

与数组相关的另一个重要语法是`in`，`x in (...)`，表示判断`x`是否在某个数组中：

#code(```typ
#(1 in(1, "Hello, World", [一段内容])) \
#([一段内容] in(1, "Hello, World", [一段内容])) \
#([另一段内容] in(1, "Hello, World", [一段内容]))
```)

回顾Hello World程序：

#code(```typ
#let x = "Hello World".split(" ")
#x \
#x.at(1)
```)

含义不言而喻：使用空格拆分字符串我们可以得到两个单词，使用`at`方法，当「索引」参数为1的时候，我们就取出了其中的第二个元素，即`"Hello World"`字符串中的第二个单词。

同理，你可以使用圆括号与一个逗号分隔的列表创建一个字典字面量。与数组略微不同的是，列表的每一项是由冒号分隔的「键值对」。

#code(```typ
#let cat = (neko-mimi: 2, "utterance": "喵喵喵", attribute: [kawaii\~])
#cat
```)

构造字典字面量时，允许尾随一个多余的逗号而不造成影响。

#code(```typ
#let cat = (
  neko-mimi: 2,
  "utterance": "喵喵喵",
  attribute: [kawaii\~] ,
//    这里有一个多余的逗号^^^
)
#cat
```)

所谓「字典」即是「键值对」的集合。

其中，“neco-mimi”、“utterance”和“attribute”是字典的「键」，它们必须是字符串。而`2`、`"喵喵喵"`和`[kawaii\~]`分别是对应的「值」。

为了访问字典，你可以使用`at`方法。但由于「键」都是字符串，你需要使用字符串作为字典的「索引」。

#code(```typ
#let cat = (neko-mimi: 2, "utterance": "喵喵喵", attribute: [kawaii\~])
#cat.at("neko-mimi") \
#cat.at("utterance") \
#cat.at("attribute")
```)

与数组类似，字典也可以使用相关的另一个重要语法是`in`，`x in (...)`，表示判断`x`是否是字典的一个「键」：

#code(```typ
#let cat = (neko-mimi: 2, "utterance": "喵喵喵", attribute: [kawaii\~])
#("neko-mimi" in cat)
```)

注意：`x in (...)`中的`x`必须是一个字符串类型，否则，例如`neko-mimi in cat`将是另一种含义，而非检查`"neko-mimi"`是否字典变量`cat`的一个「键」。

这里讲解一些关于数组与字典字面量相关的重要语法：

#code(```typ
#() \ // 是空的数组
#(:) \ // 是空的字典
#(1) \ // 被括号包裹的整数1
#(()) \ // 被括号包裹的空数组
#((())) \ // 被括号包裹的被括号包裹的空数组
#(1,) \ // 是含有一个元素的数组
```)

`()`是空的数组，不含任何值；如果你想构建空的字典，需要中置一个冒号，`(:)`是空的字典，不含任何键值对。

如果括号内含了一个值，而无法与数组区分，例如`(1)`，那么它仅仅是被括号包裹的整数1，仍然是整数1本身。

类似的，`(())`是被括号包裹的空数组，`((()))`是被括号包裹的被括号包裹的空数组。

如果你想构建含有一个元素的数组，需要在列表末尾放置一个额外的逗号以区分括号语法，例如`(1,)`。

== 数组和字典字面量的「解构赋值」

除了使用字面量「构造」元素，Typst还支持「构造」的反向操作：「解构赋值」。顾名思义，我们可以在左侧用相似的语法从数组或字典中获取值并赋值到*对应*的变量上。

#code(```typ
#let x = (1, "Hello, World", [一段内容])
#let (one, hello-world, a-content) = x
#one \
#hello-world \
#a-content
```)

#code(```typ
#let cat = (neko-mimi: 2, "utterance": "喵喵喵", attribute: [kawaii\~])
#let (utterance: u, attribute: a) = cat
#u \
#a
```)

数组的「解构赋值」必须一一解构，如果数组包含10项，则你必须解构出10个变量。否则，如果我们只想解构其中一部分值，可以尾随一个「延展符」（`..`），以示省略：

#code(```typ
#let (first, ..) = (1, "Hello, World", [一段内容])
#first \
#let (_, second, ..) = (1, "Hello, World!!!", [一段内容])
#second \
#let (attribute: a, ..) = (neko-mimi: 2, "utterance": "喵喵喵", attribute: [kawaii\~])
#a
```)

从如下脚本，你可以更好地体会到「构造」与「解构赋值」互为相反操作的含义：

#code(```typ
#let (one, hello-world,    a-content) = {
     (1,   "Hello, World", [一段内容])
}
#one \
#hello-world \
#a-content
```)

todo: (a, b) = (b, a)
todo: let \_

todo: field access
- dictionary
- symbol
- module
- content

todo: not in

todo: return

== `none`类型和控制流

默认情况下，在逻辑上，Typst按照顺序执行执行你的代码，即先执行前面的语句，再执行后面的语句。开发者如果想要控制程序执行的流程，就必须使用流程控制的语法结构，主要是条件执行和循环执行。

`if`语句用于条件判断，满足条件时，就执行指定的语句。

#```typ
#if expression { then-block } else { else-block }
#if expression { then-block }
```

上面式子中，表达式`expression`为真（值为布尔值`true`）时，就执行`then-block`代码块，否则执行`else-block`代码块。特别地，`else`可以省略。

如下所示：

#code(```typ
#(1 < 2) \
#if (1 < 2) { "确实" } else { "啊？" }
```)

因为`1 < 2`表达式为真，所以脚本执行了`then-block`代码块，而忽略了`else-block`代码块，于是最后文档的内容为“确实”。

这里有一个疑问，如果我们只写了`then`代码块，而没写`else`代码块，但偏偏表达式不为真，最终脚本会报错吗？我们看：

#code(```typ
#if (1 > 2) { "啊？" }
```)

虽然很合理，但是为了学到更多知识，我们深挖一点，用`repr`一探究竟：

#code(```typ
#repr(if (1 > 2) { "啊？" })
```)

当`if`表达式没写`else`代码块而条件为假时，结果为`none`。“none”在中文里意思是“无”，“什么都没有”。

在程序执行中，有很多地方都会产生`none`，作为教程我们不会将它们一一列出。但我们可以指出`none`在「可折叠」的值（见上一节）中很重要的一个性质：`none`在折叠过程中被忽略。

见下程序，其根据数组所包含的值输出特定字符串：

#code(```typ
#let 查成分(成分数组) = {
  "是个"
  if "A" in 成分数组 { "萌萌" }
  if "C" in 成分数组 { "萌萌" }
  if "G" in 成分数组 { "萌萌" }
  if "T" in 成分数组 { "工具" }
  "人"
}

#查成分(())

#查成分(("A","C",))

#查成分(("A","T",))
```)

由于`if`也是表达式，我们可以直接将`if`作为函数体，例如fibnacci函数的递归可以非常简单：

#code(```typ
#let fib(n) = if n <= 1 {
  n
} else {
  fib(n - 1) + fib(n - 2)
}

#fib(46)
```)

// if condition {..}
// if condition [..]
// if condition [..] else {..}
// if condition [..] else if condition {..} else [..]

`while`语句用于循环结构，满足条件时，不断执行循环体。

```typ
#while expression { CONT }
```

上面代码中，如果表达式`expression`为真，就会执行`CONT`代码块，然后再次判断`expression`是否为假；如果`expression`为假就跳出循环，不再执行循环体。

#code(```typ
#{
  let i = 0;
  while i < 10 {
    (i * 2, )
    i += 1;
  }
}
```)

上面代码中，循环体会执行`10`次，每次将`i`增加`1`，直到等于`10`才退出循环。

`for`语句也是常用的循环结构，它迭代访问某个对象的每一项。

```typ
#for X in A { CONT }
```

上面代码中，对于`A`的每一项，都执行`CONT`代码块。在执行`CONT`时，项的内容是`X`。例如以下代码做了与之前循环相同的事情：

#code(```typ
#for i in range(10) {
  (i * 2, )
}
```)

其中`range(10)`创建了一个内容为`(0, 1, 2, ..., 9)`一共10个值的的数组。

所有的数组都可以使用`for`遍历，同理所有字典也都可以使用`for`遍历。在执行`CONT`时，项的内容是键值对，而Typst将用一个数组代表这个键值对，交给你。键值对数组的第0项是键，键值对数组的第1项是对应的值。

#code(```typ
#let cat = (neko-mimi: 2, "utterance": "喵喵喵", attribute: [kawaii\~])
#for i in cat {
  [猫猫的 #i.at(0) 是 #i.at(1)\ ]
}
```)

你可以同时使用「解构赋值」让代码变得更容易阅读：

#code(```typ
#let cat = (neko-mimi: 2, "utterance": "喵喵喵", attribute: [kawaii\~])
#for (特色, 这个) in cat {
  [猫猫的 #特色 是 #这个\ ]
}
```)

无论是`while`还是`for`，都可以使用`break`跳出循环，或`continue`直接进入下一次执行。

基于以下`for`循环，我们探索`break`和`continue`语句的作用。

#code(```typ
#for i in range(10) { (i, ) }
```)

在第一次执行时，如果我们直接使用`break`跳出循环，但是在break之前就已经产生了一些值，那么`for`的结果是`break`前的那些值的「折叠」。

#code(```typ
#for i in range(10) { (i, ); (i + 1926, ); break }
```)

特别地，如果我们直接使用`break`跳出循环，那么`for`的结果是*`none`*。

#code(```typ
#for i in range(10) { break }
```)

在`break`之后的那些值将会被忽略：

#code(```typ
#for i in range(10) { break; (i, ); (i + 1926, ); }
```)

以下代码将收集迭代的所有结果，直到`i >= 5`：
#code(```typ
#for i in range(10) {
  if i >= 5 { break }
  (i, )
}
```)

// #for 方位 in ("东", "南", "西", "北", "中", "间", "东北", "西北", "东南", "西南") [鱼戏莲叶#方位，]

`continue`有相似的规则，便不再赘述。我们举一个例子，以下程序输出在`range(10)`中不是偶数的数字：

#code(```typ
#let 是偶数(i) = calc.even(i)
#for i in range(10) {
  if 是偶数(i) { continue }
  (i, )
}
```)

== 变量的可变性

略。

== 闭包和含变参函数

#code(```typ
#let f = (x, y) => [两个值#(x)和#(y)偷偷混入了我们内容之中。]
#let g(..args) = [很多个值，#args.pos().join([、])，偷偷混入了我们内容之中。]

#f("a", "b")

#g([一个俩个], [仨个四个], [五六七八个])
```)

Typst很快，并不是因为它的解析器、解释器有世界领先水平的优化，而是因为在Typst脚本的世界中，一切都是纯的，没有几乎。这允许Typst有效地缓存计算，在相当一部分文档的编译速度上，快过LaTeX等语言上百倍。

Typst对内置实现的所有函数都有良好的自我管理，但总免不了用户打算写一些逆天的函数。为了保证缓存计算仍较为有效，Typst强制要求用户编写的*所有函数*都是纯函数。

Typst如何保证一个简单函数甚至是一个闭包是“纯函数”？

答：1. 禁止修改外部变量，则捕获的变量的值是“纯的”或不可变的；2. 折叠的对象是纯的，且「折叠」操作是纯的。

Typst的多文件特性从何而来？

答：1. import函数产生一个模块对象，而模块其实是文件顶层的scope。2. include函数即执行该文件，获得该文件对应的内容块。

基于以上两个特性，Typst为什么快？

+ Typst支持增量解析文件。
+ Typst所有由*用户声明*的函数都是纯的，在其上的调用都是纯的。例如Typst天生支持快速计算递归实现的fibnacci函数：

  #code(```typ
  #let fib(n) = if n <= 1 { n } else { fib(n - 1) + fib(n - 2) }
  #fib(42)
  ```)
+ Typst使用`include`导入其他文件的顶层「内容块」。当其他文件内容未改变时，内容块一定不变，而所有使用到对应内容块的函数的结果也一定不会因此改变。

这意味着，如果你发现了Typst中与一般语言的不同之处，可以思考以上种种优势对用户脚本的增强或限制。
