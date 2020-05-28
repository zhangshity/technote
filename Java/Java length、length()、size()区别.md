# Java length、length()、size()区别

> 1. length：
>
> 　　是一个 属性
>
> 　　针对的是 数组
>
> 　　得到的结果是 数组的长度
>
> ​	eg:　　
>
> ```java
> char [] array = {'a','b','c'};
> 
> System.out.println( array.length );
> 
> //=====> 3
> ```

---
> 2. length()：
>
> 　　是一个 方法
>
> 　　针对的是 字符串
>
> 　　获取的是 字符串的长度
>
> ​	eg:　　
>
> ```java
> String [] array = {"abc","def","ghi"};
> 
> String s = "abcdef";
> 
> System.out.println( array[0].length() );
> 
> System.out.println( s.length() );
> 
> //=====> 3  6
> ```
---
> 3. size()：
>
> 　　是一个 方法
>
> 　　针对的是 泛型集合
>
> 　　获取的是 集合的元素个数
>
> ​	eg:　　
>
> ```java
> List<Object> list = new ArrayList();
> 
> list.add("aaa");
> 
> System.out.println( list.size() );
> 
> //=====> 1
> ```
>
> 
>
