# Java类_初始化顺序 (Extends)

**@Author: Yang**

---

> 类的初始化顺序：(先父后子)
>
> * 先静态
>   * 父类的<u>**静态变量**</u>->父类<u>**静态初始化代码块**</u>->
>   * 子类的<u>**静态成员**</u>->子类<u>**静态初始化代码块**</u>->
> * 后类成员
>   * 父类的<u>**成员变量**</u>->父类的<u>**初始化代码块**</u>->父类的<u>**构造函数**</u>->
>   * 子类的<u>**成员变量**</u>->子类的<u>**初始化代码块**</u>->子类的<u>**构造函数**</u>



##### 代码示例

```java
public class Test {
  
    static class ClassA {
       
      	private static int staticField = 10; //静态成员变量
        static {
            System.out.println("static A {}"); //静态代码段
        }

        private int normalField = 5; //成员变量
        {
            System.out.println("A {}"); //初始化代码段
        }

        public ClassA() {
            System.out.println("ClassA()"); //构造函数
        }
    }
  
    // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    static class ClassB extends ClassA {
       
      	private static int staticField = 50; //子类静态成员变量
        static {
            System.out.println("static B {}"); //子类静态代码段
        }

        private int normalField = 25; //子类成员变量
        {
            System.out.println("B {}"); //子类初始化代码段
        }
      
        public ClassB() {
            System.out.println("ClassB()"); //子类构造函数
        }
    }


    //=======================================================================
    public static void main(String[] args) {
        new ClassB();
    }

}
```

#####  结果

```java
static A {}
static B {}
A {}
ClassA()
B {}
ClassB()
```

> 示例 ：
>
> https://github.com/zhangshity/aysos/blob/04af102f3efbf4d62e3ba7bb2ec100f27dcacf84/src/main/java/com/zcy/_extends/Test.java





#### 结论

> * 代码块其实就是为变量的初始化服务的 ——其更像异种格式化的规范，一堆变量配置一个代码块来一起初始化。https://github.com/zhangshity/aysos/blob/5c52d4be494ffb15cfe045f46e19b232e2d57f0f/src/main/java/com/zcy/_extends/InitializationRegular.java
>
>   ```java
>   public class InitializationRegular {
>   
>       private static int a;
>       private static int b;
>       private static int c;
>       private static int d;
>       private static int e;
>   
>       static {
>           a = 1;
>           b = 2;
>           c = 3;
>           d = 4;
>           e = 5;
>       }
>   
>   
>       private int f;
>       private int g;
>       private int h;
>       private int i;
>       private int j;
>   
>       {
>           f = 6;
>           g = 7;
>           h = 8;
>           i = 9;
>           j = 10;
>       }
>   
>   
>       public static void main(String[] args) {
>           System.out.println("a=" + a + " b=" + b + " c=" + c + " d=" + d + " e=" + e);
>   
>           InitializationRegular clazz = new InitializationRegular();
>           System.out.println("f=" + clazz.f + " g=" + clazz.g + " h=" + clazz.h + " i=" + clazz.i + " j=" + clazz.j);
>       }
>   }
>   ```
>
>   
>
> * 总是先静态后普通成员变量的，总是先父类后子类的



其他分析贴：https://www.cnblogs.com/wenjianes/p/9999325.html