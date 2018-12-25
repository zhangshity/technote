# Java中的 hashcode() 方法


* hashCode 是jdk根据对象的地址或者字符串或者数字算出来的int类型的数值   

* public int hashCode()返回该对象的哈希码值。支持此方法是为了提高哈希表（例如 java.util.Hashtable 提供的哈希表）的性能。




* hashcode相等 <=== 对象相等  （hash是对象的必要不充分条件）
* 对象相等 ===> hashcode相等   (对象是hash的充分不必要条件)



#### 数学逻辑演算:
* 对象相等 ==> hashcode相等
* 对象不等 ==> hashcode大多数情况不等。但也有可能冲突不同对象hashcode相等
* hashcode相等 ==> 对象大多数情况相同。但也有可能hash表冲突不同对象hashcode相等
* hashcode不等 ==> 对象不等 





## 百度解释
### 一致性：
*         在 Java 应用程序执行期间，在对同一对象多次调用 hashCode 方法时，必须一致地返回相同的整数，前提是将对象进行hashcode比较时所用的信息没有被修改。
### equals：
*         如果根据 equals(Object) 方法，两个对象是相等的，那么对这两个对象中的每个对象调用 hashCode 方法都必须生成相同的整数结果，注：这里说的equals(Object) 方法是指Object类中未被子类重写过的equals方法。
即使两个hashCode()返回的结果相等，两个对象的equals方法也不一定相等。
### 附加：
*         如果根据equals(java.lang.Object)方法，两个对象不相等，那么对这两个对象中的任一对象上调用 hashCode 方法不一定生成不同的整数结果。但是，程序员应该意识到，为不相等的对象生成不同整数结果可以提高哈希表的性能。
### 重写：
*         HashMap对象是根据其Key的hashCode来获取对应的Value。
在重写父类的equals方法时，也重写hashcode方法，使相等的两个对象获取的HashCode也相等，这样当此对象做Map类中的Key时，两个equals为true的对象其获取的value都是同一个，比较符合实际。



[注]
========================================================================================
因此有人会说，可以直接根据hashcode值判断两个对象是否相等吗？肯定是不可以的，因为不同的对象可能会生成相同的hashcode值。虽然不能根据hashcode值判断两个对象是否相等，但是可以直接根据hashcode值判断两个对象不等，如果两个对象的hashcode值不等，则必定是两个不同的对象。如果要判断两个对象是否真正相等，必须通过equals方法。

　　也就是说对于两个对象，如果调用equals方法得到的结果为true，则两个对象的hashcode值必定相等；

　　如果equals方法得到的结果为false，则两个对象的hashcode值不一定不同；

　　如果两个对象的hashcode值不等，则equals方法得到的结果必定为false；

　　如果两个对象的hashcode值相等，则equals方法得到的结果未知。

