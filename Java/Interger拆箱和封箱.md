# Interger拆箱和封箱

1. 
* 基本类型 -> 包装类型：装箱
* 包装类型 -> 基本类型：拆箱

> 自动装包：基本类型自动转为包装类型.(int　       >>　Integer)
> 自动拆包：包装类型自动转为基本类型.(Integer　>>　       int)

---

2. 装箱源码逻辑(-128-127返回 Interger cache[]中的值)

```
public static Integer valueOf(int i) {
    if (i >= IntegerCache.low && i <= IntegerCache.high)
        return IntegerCache.cache[i + (-IntegerCache.low)];
    return new Integer(i);
}
```
3. Demo
```java
/**
 * Interger的装箱和拆箱 (自动和手动)
 */
int i1 = 500;
Integer integer1 = new Integer(i1); // 手动装箱      
int i2 = integer1.intValue(); // 手动拆箱


int i3 = 500;
Integer integer2 = i3; // 自动装箱
int i4 = integer2; // 自动拆箱 
```

> 4. 源码剖析
>
> `Interger integer = new Integer(100)` 直接在堆内存开辟空间存储
>
> `Integer i = 10` 自动装箱实际执行 `Integer.valueOf(i)`
>
> ```java
> public final class Integer extends Number implements Comparable<Integer> {
>     
>   	//......
>   	
> 		/**
>      * The value of the {@code Integer}.
>      *
>      * @serial
>      */
>     private final int value;
> 
>     public Integer(int value) {
>         this.value = value;
>     }
> 
>     public int intValue() {
>         return value;
>     }
> 
>     public long longValue() {
>        return (long)value;
>     }
> 		
>   	public static Integer valueOf(int i) {
>         if (i >= IntegerCache.low && i <= IntegerCache.high)
>             return IntegerCache.cache[i + (-IntegerCache.low)];
>         return new Integer(i);
>     }
>   
>     private static class IntegerCache {
>         static final int low = -128;
>         static final int high;
>         static final Integer cache[];
> 
>         static {
>             // high value may be configured by property
>             int h = 127;
>             String integerCacheHighPropValue =
>                 sun.misc.VM.getSavedProperty("java.lang.Integer.IntegerCache.high");
>             if (integerCacheHighPropValue != null) {
>                 try {
>                     int i = parseInt(integerCacheHighPropValue);
>                     i = Math.max(i, 127);
>                     // Maximum array size is Integer.MAX_VALUE
>                     h = Math.min(i, Integer.MAX_VALUE - (-low) -1);
>                 } catch( NumberFormatException nfe) {
>                     // If the property cannot be parsed into an int, ignore it.
>                 }
>             }
>             high = h;
> 
>             cache = new Integer[(high - low) + 1];
>             int j = low;
>             for(int k = 0; k < cache.length; k++)
>                 cache[k] = new Integer(j++);
> 
>             // range [-128, 127] must be interned (JLS7 5.1.7)
>             assert IntegerCache.high >= 127;
>         }
> 
>         private IntegerCache() {}
>     }
>   
>   
>   
>     public boolean equals(Object obj) {
>         if (obj instanceof Integer) {
>             return value == ((Integer)obj).intValue();
>         }
>         return false;
>     }
>   
>   
>   	//......
>   
> }
> ```
>
> 

