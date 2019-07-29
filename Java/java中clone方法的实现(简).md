# java中clone方法的实现(简)

[转]https://www.jianshu.com/p/04ff0a7bf52b

> Java中仅有的创建对象的两种方式：
> 
> ​		①.使用new操作符创建对象；
> 
> ​		②.使用clone方法复制对象。
> 
> 由于clone方法将最终将调用JVM中的原生方法完成复制，所以一般使用clone方法复制对象要比新建一个对象然后逐一进行元素复制效率要高。

## 浅拷贝与深拷贝

在java中基本数据类型是按值传递的，而对象是按引用传递的。所以当调用对象的clone方法进行对象复制时将涉及深拷贝和浅拷贝的概念。

浅拷贝是指拷贝对象时仅仅拷贝对象本身（包括对象中的基本变量），而不拷贝对象包含的引用指向的对象。深拷贝不仅拷贝对象本身，而且拷贝对象包含的引用指向的所有对象。通过clone方法复制对象时，若不对clone()方法进行改写，则调用此方法得到的对象为浅拷贝。

例如：浅拷贝

```
    public class Stack implements Cloneable {
        private Object[] elements;
        private int size = 0;
        private static final int DEFAULT_INITIAL_CAPACITY = 16;

        public Stack() {
            elements = new Object[DEFAULT_INITIAL_CAPACITY];
        }

        public void push(Object o) {
            ensureCapacity();
            elements[size++] = o;
        }

        public Object pop() {
            if (size == 0)
                throw new EmptyStackException();
            Object result = elements[--size];
            elements[size] = null; // 【避免内存泄漏】
            return result;
        }

        private void ensureCapacity() {
            if (elements.length == size) {
                elements = Arrays.copyOf(elements, 2 * size + 1);
            }
        }

        // 实现clone方法,浅拷贝
        @Override
        protected Stack clone() throws CloneNotSupportedException {

            return (Stack) super.clone();
        }
    }
```

深拷贝：

```
    //深拷贝
    @Override
    protected Stack clone() throws CloneNotSupportedException {
        Stack result = (Stack) super.clone();
        result.elements = elements.clone(); //对elements元素进行拷贝（引用或基本数据类型）
        return result;
    }
```

其原理图：





![img]([https://github.com/zhangshity/technote/blob/master/Resources/clone_memory/clone%E5%8E%9F%E7%90%861.png](https://github.com/zhangshity/technote/blob/master/Resources/clone_memory/clone原理1.png))

深拷贝与浅拷贝的原理



注意：

- 由于java5.0后引入了协变返回类型（covariant return type）实现（基于泛型），即覆盖方法的返回类型可以是被覆盖方法的返回类型的子类型，所以clone方法可以直接返回Stack类型，而不用返回Object类型，然后客户端再强转。
- 在数组上调用clone返回的数组，其编译时类型与被克隆数组的类型相同。
- 若elements域是final的，深拷贝不能正常工作。因为clone架构与引用可变对象的final域的正常用法是不兼容的。
- 若elements数组中的元素是引用类型，则此方法仅仅是对引用的拷贝，元素指向的还是原来的对象

还应该注意，**数组的clone，仅仅复制的是数组中的元素，即若数组中元素为引用类型，仅仅复制引用。若clone的对象中含有链表，则应单独对链表进行循环复制。**例如，一个内部包含一个散列桶数组的散列表，其数组中每个元素都指向一个独立的链表。此时仅仅使用上面的方法就是不完全拷贝。

代码：

```
    public class HashTable implements Cloneable {

        private static final int CAPACITY = 10;

        //散列桶数组，数组中元素指向由Entry对象组成的链表（指向链表第一个Entry）
        private Entry[] buckerts = new Entry[CAPACITY];

        public void put(Object key, Object value) {
            int index = key.hashCode() % CAPACITY;
            Entry e = buckerts[index];
            buckerts[index] = new Entry(key,value,e);
        }

        @Override
        public HashTable clone() throws CloneNotSupportedException {
            HashTable result = (HashTable)super.clone();
            result.buckerts = buckerts.clone(); //仅仅复制了对链表的引用。
            return result;
        }

        //轻量级单链表
        private static class Entry {
            final Object key;
            Object value;
            Entry next;

            Entry(Object key, Object value, Entry next) {
                this.key = key;
                this.value = value;
                this.next = next;
            }
        }
    }
```

原理图：





![img]([https://github.com/zhangshity/technote/blob/master/Resources/clone_memory/clone%E5%8E%9F%E7%90%862.png](https://github.com/zhangshity/technote/blob/master/Resources/clone_memory/clone原理2.png))

不完全拷贝



虽然被克隆对象有自己的散列桶数组，但数组引用的链表与原对象是一样的。数组的clone方法，仅仅拷贝了对链表的引用，而没有复制链表中的元素。

改进代码：

```
    @Override
    public HashTable clone() throws CloneNotSupportedException {
        HashTable result = (HashTable)super.clone();
        result.buckerts = buckerts.clone();
        for(int i=0; i<buckerts.length; i++) {
            result.buckerts[i] = buckerts[i].deepCopy();
        }
        return result;
    }

    //轻量级单链表
    private static class Entry {
        final Object key;
        Object value;
        Entry next;

        Entry(Object key, Object value, Entry next) {
            this.key = key;
            this.value = value;
            this.next = next;
        }

        //递归实现链表复制
        Entry deepCopy() {
            return new Entry(key,value,next == null ? null : next.deepCopy());
        }
    }
```

在内部类Entry中的深度拷贝方法递归的调用自身，以完成链表的拷贝。虽然这种方法比较简洁，但如果链表很长，有可能会导致栈溢出。可以使用迭代代替递归实现链表的复制。代码如下：

```
    //迭代实现链表复制
    Entry deepCopy() {
        Entry result = new Entry(key, value, next);
        for(Entry e = result; e.next != null; e = e.next) {
            e.next = new Entry(e.next.key, e.next.value, e.next.next);
        }
        return result;
    }
```

**实现clone方法的步骤：**

- 首先调用父类的super.clone方法（父类必须实现clone方法），这个方法将最终调用Object的中native型的clone方法完成浅拷贝
- 对类中的引用类型进行单独拷贝
- 检查clone中是否有不完全拷贝(例如，链表），进行额外的复制

## 参考

- Effective java教材
- [Java中的深拷贝(深复制)和浅拷贝(浅复制)](https://link.jianshu.com/?t=http://www.cnblogs.com/shuaiwhu/archive/2010/12/14/2065088.html)
- [详解Java中的clone方法 -- 原型模式](https://link.jianshu.com/?t=http://blog.csdn.net/zhangjg_blog/article/details/18369201)