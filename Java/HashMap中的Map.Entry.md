# HashMap中的 Map.Entry<k,v>

##### Entry: 键值对  对象。

> 在Map类设计时，提供了一个嵌套接口 **Entry** (嵌套接口默认static修饰)。Entry将键值对的对应关系封装成了对象——即键值对对象。
>
> 这样我们在遍历Map集合时，就可以从每一个 <u>键值对对象(Entry Object)</u> 中获取对应的<u>键(key)</u> 与 对应的<u>值 (value)</u>。

```java
public interface Map<K,V> {    
	 
   /**
     * A map entry (key-value pair).  The <tt>Map.entrySet</tt> method returns
     * a collection-view of the map, whose elements are of this class.  The
     * <i>only</i> way to obtain a reference to a map entry is from the
     * iterator of this collection-view.  These <tt>Map.Entry</tt> objects are
     * valid <i>only</i> for the duration of the iteration; more formally,
     * the behavior of a map entry is undefined if the backing map has been
     * modified after the entry was returned by the iterator, except through
     * the <tt>setValue</tt> operation on the map entry.
     *
     * @see Map#entrySet()
     * @since 1.2
     */
    interface Entry<K,V> {
        
        K getKey();

        V getValue();

        V setValue(V value);

        boolean equals(Object o);

        int hashCode();

        public static <K extends Comparable<? super K>, V> Comparator<Map.Entry<K,V>> comparingByKey() {
            return (Comparator<Map.Entry<K, V>> & Serializable)
                (c1, c2) -> c1.getKey().compareTo(c2.getKey());
        }

        public static <K, V extends Comparable<? super V>> Comparator<Map.Entry<K,V>> comparingByValue() {
            return (Comparator<Map.Entry<K, V>> & Serializable)
                (c1, c2) -> c1.getValue().compareTo(c2.getValue());
        }

        public static <K, V> Comparator<Map.Entry<K, V>> comparingByKey(Comparator<? super K> cmp) {
            Objects.requireNonNull(cmp);
            return (Comparator<Map.Entry<K, V>> & Serializable)
                (c1, c2) -> cmp.compare(c1.getKey(), c2.getKey());
        }

        public static <K, V> Comparator<Map.Entry<K, V>> comparingByValue(Comparator<? super V> cmp) {
            Objects.requireNonNull(cmp);
            return (Comparator<Map.Entry<K, V>> & Serializable)
                (c1, c2) -> cmp.compare(c1.getValue(), c2.getValue());
        }
    }
   
}
```

---

> * Entry为什么是静态的?
>
>   Entry是Map接口中提供的一个静态内部嵌套接口，(嵌套接口默认static)修饰为静态可以通过类名调用。
>
>   ```
>   for (Map.Entry<String, Integer> entry : map.entrySet()) {
>       System.out.println("key >>> " + entry.getKey() + " | value >>> " + entry.getValue());
>   }
>   ```

Map集合遍历键值对的方式：

```java
/**
 *@return a set view of the mappings contained in this map
 */

//返回此映射中包含的映射关系的Set视图 
Set<Map.Entry<K,V>> entrySet();
```

该方法返回值是Set集合，里面装的是Entry接口类型，即将映射关系装入Set集合。

HashMap中具体实现 entrySet()方法：

```java
public Set<Map.Entry<K,V>> entrySet() {
        Set<Map.Entry<K,V>> es;
        return (es = entrySet) == null ? (entrySet = new EntrySet()) : es;
}
```

---

实现步骤：

1，调用Map集合中的entrySet()方法，将集合中的映射关系对象存储到Set集合中

2，迭代Set集合

3，获取Set集合的元素，是映射关系的对象

4，通过映射关系对象的方法，getKey()和getValue(),获取键值对