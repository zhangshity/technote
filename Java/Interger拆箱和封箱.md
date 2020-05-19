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
Integer integer1 = new Integer(i1); // 手动装箱      new Integer(i) 与 Integer.valueOf(i)相似
int i2 = integer1.intValue(); // 手动拆箱


int i3 = 500;
Integer integer2 = i3; // 自动装箱
int i4 = integer2; // 自动拆箱 
```

