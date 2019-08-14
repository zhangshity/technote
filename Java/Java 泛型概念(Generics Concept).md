# Java 泛型概念(Generics Concept)

###### @Author: ChunYang . Zhang

---

#### 概念
> Java 泛型（generics）是 JDK 5 中引入的一个新特性, 泛型提供了编译时类型安全检测机制，该机制允许程序员在编译时检测到非法的类型。
>
> * 泛型的本质是`参数化类型`，也就是说所操作的数据类型被指定为一个参数。



1. ##### 泛型方法

   > 你可以写一个泛型方法，该方法在调用时可以接收不同类型的参数。根据传递给泛型方法的参数类型，编译器适当地处理每一个方法调用。

   > 下面是定义泛型方法的规则：
   > 
   >   - 所有泛型方法声明都有一个**类型参数声明**部分（由尖括号分隔），该**类型参数声明**部分在方法返回类型之前（例子中的<E>）。
   >    - 每一个**类型参数声明**部分包含一个或多个类型参数，参数间用逗号隔开。一个泛型参数，也被>称为一个类型变量，是用于指定一个泛型类型名称的标识符。
   >    - **类型参数**能被用来声明返回值类型，并且能作为泛型方法得到的实际参数类型的占位符。
   >   - 泛型方法体的声明和其他方法一样。注意类型参数只能代表引用型类型，不能是原始类型（像int,double,char的等）

   * 例子详见GitHub简单代码https://github.com/zhangshity/aysos/blob/master/src/main/java/com/zcy/generics/GenericsMethod.java

   ```java
   public class GenericMethodTest
   {
      // 泛型方法 printArray                         
      public static < E > void printArray( E[] inputArray )
      {
         // 输出数组元素            
            for ( E element : inputArray ){        
               System.out.printf( "%s ", element );
            }
            System.out.println();
       }
    
       public static void main( String args[] )
       {
           // 创建不同类型数组： Integer, Double 和 Character
           Integer[] intArray = { 1, 2, 3, 4, 5 };
           Double[] doubleArray = { 1.1, 2.2, 3.3, 4.4 };
           Character[] charArray = { 'H', 'E', 'L', 'L', 'O' };
    
           System.out.println( "整型数组元素为:" );
           printArray( intArray  ); // 传递一个整型数组
    
           System.out.println( "\n双精度型数组元素为:" );
           printArray( doubleArray ); // 传递一个双精度型数组
    
           System.out.println( "\n字符型数组元素为:" );
           printArray( charArray ); // 传递一个字符型数组
       } 
   }
   ```
   ###### 编译以上代码，运行结果如下所示：

   ```
整型数组元素为:
   1 2 3 4 5 
   
   双精度型数组元素为:
   1.1 2.2 3.3 4.4 
   
   字符型数组元素为:
   H E L L O 
   ```
   
2. ##### 泛型类

