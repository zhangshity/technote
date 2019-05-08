# Java 全局变量和局部变量的默认初始化

##### @Author:Chunyang . Zhang
---
> ###### 1.全局变量
>
> (可不手动初始化调用)
>
> 不给定初始值，JVM会默认初始化`null`或` 0` 

> ###### 2.局部变量：
>
> (不手动初始化调用无法过编译)
>
> 不给定初始值，如果调用无法通过编译

---

#### 例：

* 例子详见https://github.com/zhangshity/aysos/blob/master/src/main/java/com/zcy/string_test/DemoStringMain.java   line148-158

```java

 /**
  * @Author: chunyang.zhang
  * @Description: String不赋初值初始化
  * @Date: Created in 16:31 2019-05-08
  * @Modified: By:
  */
 //String不赋初值初始化
 System.out.println("\n\n" + "=========String不赋初值初始化===============");
 String stringNoValue;
 String stringValueIsNull = null;
 //此行无法通过编译,局部变量没有堆内存指向,空指针异常
 System.out.println("String stringNoValue;  >>" + stringNoValue);
 //可以正常输出null
 System.out.println("String stringValueIsNull = null;  >>" + stringValueIsNull);
```



##### 题目

```java

22. 下面代码的运行结果为：（）

import java.io.*;
import java.util.*;

public class foo{

    public static void main (String[] args){

        String s;

        System.out.println("s=" + s);

    }

}

A 代码得到编译，并输出“s=”

B 代码得到编译，并输出“s=null”

C 由于String s没有初始化，代码不能编译通过

D 代码得到编译，但捕获到 NullPointException异常
答案：C



//原因是,方法中的局部变量一定要手动初始化,不然编译会报错.

`Exception in thread "main" java.lang.Error: Unresolved compilation problem: 
    The local variable s may not have been initialized
    
//局部变量，只定义引用只会栈内存分配，没有指向的堆内存。可以定义，但引用会空指针。显然，编译器在识别到 堆内存为空的引用 的调用的时候会不予通过。
```

