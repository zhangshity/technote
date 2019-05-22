# Java中String直接赋值和使用new的区别

---
* [验证例子]https://github.com/zhangshity/aysos/blob/master/src/main/java/com/zcy/string_test/DemoStringMain.java line214 -line288
```java
String str1 = "ABC";
```

```java
String str2 = new String("ABC");
```

> String str1 = “ABC”;可能创建一个或者不创建对象，如果”ABC”这个字符串在java String池里不存在，会在java String池里创建一个创建一个String对象(“ABC”)，然后str1指向这个内存地址，无论以后用这种方式创建多少个值为”ABC”的字符串对象，始终只有一个内存地址被分配，之后的都是String的拷贝，Java中称为“字符串驻留”，所有的字符串常量都会在编译之后自动地驻留。

> String str2 = new String(“ABC”);至少创建一个对象，也可能两个。因为用到new关键字，肯定会在heap中创建一个str2的String对象，它的value是“ABC”。同时如果这个字符串再java String池里不存在，会在java池里创建这个String对象“ABC”。

> 在JVM里，考虑到垃圾回收（Garbage Collection）的方便，将heap(堆)划分为三部分：young generation(新生代)、tenured generation （old generation）（旧生代）、permanent generation（永生代）。

> 字符串为了解决字符串重复问题，生命周期长，存于pergmen中。

> JVM中，相应的类被加载运行后，常量池对应的映射到JVM运行时的常量池中。

考虑下面的问题：

```java
String str1 = new String("ABC");
String str2 = new String("ABC");
```

> str1 == str2的值是true还是false呢？false

```java
String str3 = "ABC";
String str4 = "ABC";
String str5 =  "AB" + "C";
str3 == str4   //true
str3 == str5  // true
```

```java
String a  = "ABC";
String b = "AB";
String c = b + "C";
System.out.println( a == c );//false
```

> a、b在编译时就已经被确定了，而c是引用变量，不会在编译时就被确定。

#### 应用的情况：建议在平时的使用中，尽量使用String = “abcd”;这种方式来创建字符串，而不是String = new String(“abcd”);这种形式，因为使用new构造器创建字符串对象一定会开辟一个新的heap空间，而双引号则是采用了String interning(字符串驻留)进行了优化，效率比构造器高。


原文：https://blog.csdn.net/OREO_GO/article/details/51397903 
