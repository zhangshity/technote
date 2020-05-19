# 无锁机制----比较交换CAS Compare And Swap


一、锁与共享变量
       加锁是一种悲观的策略，它总是认为每次访问共享资源的时候，总会发生冲突，所以宁愿牺牲性能（时间）来保证数据安全。

       无锁是一种乐观的策略，它假设线程访问共享资源不会发生冲突，所以不需要加锁，因此线程将不断执行，不需要停止。一旦碰到冲突，就重试当前操作直到没有冲突为止。
    
       无锁的策略使用一种叫做比较交换的技术（CAS Compare And Swap）来鉴别线程冲突，一旦检测到冲突产生，就重试当前操作直到没有冲突为止。

二、无锁如何鉴别冲突
        CAS核心算法：执行函数：CAS(V，E，N)   

V表示准备要被更新的变量       

E表示我们提供的 期望的值

N表示新值 ，准备更新V的值

       算法思路：V是共享变量，我们拿着自己准备的这个E，去跟V去比较，如果E == V ，说明当前没有其它线程在操作，所以，我们把N 这个值 写入对象的 V 变量中。如果 E ！= V ，说明我们准备的这个E，已经过时了，所以我们要重新准备一个最新的E ，去跟V 比较，比较成功后才能更新 V的值为N。



三、无锁的效果
        如果多个线程同时使用CAS操作一个变量的时候，只有一个线程能够修改成功。其余的线程提供的期望值已经与共享变量的值不一样了，所以均会失败。

       由于CAS操作属于乐观派，它总是认为自己能够操作成功，所以操作失败的线程将会再次发起操作，而不是被OS挂起。所以说，即使CAS操作没有使用同步锁，其它线程也能够知道对共享变量的影响。
    
        因为其它线程没有被挂起，并且将会再次发起修改尝试，所以无锁操作即CAS操作天生免疫死锁。
    
        另外一点需要知道的是，CAS是系统原语，CAS操作是一条CPU的原子指令，所以不会有线程安全问题。

四、Java提供的CAS操作：原子操作类
        Java提供了一个Unsafe类，其内部方法操作可以像C的指针一样直接操作内存，方法都是native的。

        为了让Java程序员能够受益于CAS等CPU指令，JDK并发包中有一个atomic包，它们是原子操作类，它们使用的是无锁的CAS操作，并且统统线程安全。atomic包下的几乎所有的类都使用了这个Unsafe类。






分类如下：



       这些类中，最有代表性的就是AtomicInteger类。
    
       看源码，省略了部分代码

public class AtomicInteger extends Number implements java.io.Serializable {
    private static final long serialVersionUID = 6214790243416807050L;

    // 这个就是封装CAS操作的指针
    private static final Unsafe unsafe = Unsafe.getUnsafe();
      
    //原来内部的共享变量，就是这个value，并且使用volatile让其在多个线程之间可见
    private volatile int value;
     
    //初始化的构造函数
    public AtomicInteger(int initialValue) {
        value = initialValue;
    }
     
    //获取当前值
    public final int get() {
        return value;
    }
     
    //设置当前的共享变量的值
    public final void set(int newValue) {
        value = newValue;
    }
     
    //使用CAS操作设置新的值，并且返回旧的值
    public final int getAndSet(int newValue) {
        //使用指针unsafe类的三大原子操作方法之一
        return unsafe.getAndSetInt(this, valueOffset, newValue);
    }

 

    //把expect与内部的value进行比较，如果相等，那么把value的值设置为update的值
    public final boolean compareAndSet(int expect, int update) {
        return unsafe.compareAndSwapInt(this, valueOffset, expect, update);
    }
     
    //返回value，并把value + 1 
    public final int getAndIncrement() {
        return unsafe.getAndAddInt(this, valueOffset, 1);
    }
     
    //自增，并且返回自增后的值
    public final int incrementAndGet() {
        return unsafe.getAndAddInt(this, valueOffset, 1) + 1;
    }

}


       查看指针类unsafe类的incrementAndGet方法的代码实现，颇具教学意义。
    
       这个方法是一个死循环，不断尝试获取最新的值，也就不断获取 CAS（V，E，N）中的E，也就是我们要提供的期望的值。
    
       如果此时 共享变量V 与 我们的 E 相同，那么就把 V 的值 修改成 N。
    
       下面代码中，先不断尝试获取最新的共享变量的值V，如果其它线程也在同时获取V，并且其它线程抢先将共享变量V 修改成了 V+1，那么此时，当前线程持有的共享变量的值是V，它去与实际的共享变量值V+1比较，将会比较失败，所以本次自增失败。但是因为是一个死循环，当前线程将会重新调用 get（）方法获取最新的值，直到在其它线程执行CAS操作之前，抢先执行自增共享变量的操作。

public final int incrementAndGet(){
        for(;;){
            int current = get();
            int next = current + 1;
            if(compareAndSet(current,next)){
                return next;
            }
        }
    }
      

 

五、ABA问题及其解决方案
        在CAS的核心算法中，通过死循环不断获取最新的E。如果在此之间，V被修改了两次，但是最终值还是修改成了旧值V，这个时候，就不好判断这个共享变量是否已经被修改过。为了防止这种不当写入导致的不确定问题，原子操作类提供了一个带有时间戳的原子操作类。

        带有时间戳的原子操作类AtomicStampedReference （音:a  tommy k S dan P de ..）

 CAS（V，E，N）

        当带有时间戳的原子操作类AtomicStampedReference对应的数值被修改时，除了更新数据本身外，还必须要更新时间戳。
    
        当AtomicStampedReference设置对象值时，对象值以及时间戳都必须满足期望值，写入才会成功。因此，即使对象值被反复读写，写回原值，只要时间戳发生变化，就能防止不恰当的写入。

底层实现为： 通过Pair私有内部类存储数据和时间戳, 并构造volatile修饰的私有实例

接着看AtomicStampedReference类的compareAndSet（）方法的实现：

同时对当前数据和当前时间进行比较，只有两者都相等是才会执行casPair()方法，

单从该方法的名称就可知是一个CAS方法，最终调用的还是Unsafe类中的compareAndSwapObject方法

到这我们就很清晰AtomicStampedReference的内部实现思想了，

通过一个键值对Pair存储数据和时间戳，在更新时对数据和时间戳进行比较，

只有两者都符合预期才会调用Unsafe的compareAndSwapObject方法执行数值和时间戳替换，也就避免了ABA的问题。

public class AtomicStampedReference<V> {
     //通过一个volatile修饰的Pair对象
     private volatile Pair<V> pair;

     //嵌套类Pair技能存储对象引用，也存储了时间戳
     private static class Pair<T> {
          final T reference;
          final int stamp;
          private Pair(T reference, int stamp) {
            this.reference = reference;
            this.stamp = stamp;
    }
     
    public boolean compareAndSet(V   expectedReference,
                                 V   newReference,
                                 int expectedStamp,
                                 int newStamp) {
        Pair<V> current = pair;
        return
            expectedReference == current.reference &&
            expectedStamp == current.stamp &&
            ((newReference == current.reference &&
              newStamp == current.stamp) ||
             casPair(current, Pair.of(newReference, newStamp)));
    }

 


}

————————————————
版权声明：本文为CSDN博主「小大宇」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/yanluandai1985/article/details/82686486