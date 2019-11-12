# [Java线程状态切换以及核心方法](https://www.cnblogs.com/cowboys/p/9315331.html)

**1.Java线程状态**

**1.1 线程主要状态**

**①初始(NEW)**：新创建了一个线程对象，但还没有调用start()方法。
②**运行(RUNNABLE)**：Java线程中将就绪（ready）和运行中（running）两种状态笼统的成为“运行”。
线程对象创建后，其他线程(比如main线程）调用了该对象的start()方法。该状态的线程位于可运行线程池中，等待被线程调度选中，获取cpu 的使用权，此时处于就绪状态（ready）。就绪状态的线程在获得cpu 时间片后变为运行中状态（running）。
③**阻塞(BLOCKED)**：表线程阻塞于锁。
④**等待(WAITING)**：进入该状态的线程需要等待其他线程做出一些特定动作（通知或中断）。
⑤**超时等待(TIME_WAITING)**：该状态不同于WAITING，它可以在指定的时间内自行返回。

⑥**终止(TERMINATED)**：表示该线程已经执行完毕。

***\*1.2 线程状态切换
\****

示意图如下：

***\*![img](https://images2018.cnblogs.com/blog/930824/201807/930824-20180715222029724-1669695888.jpg)\****

 

 **1.2.1 初始状态**

1. 实现Runnable接口和继承Thread可以得到一个线程类，new一个实例出来，线程就进入了初始状态

**1.2.2 就绪状态**

1. 就绪状态只是说你资格运行，调度程序没有挑选到你，你就永远是就绪状态。
2. 调用线程的start()方法，此线程进入就绪状态。
3. 当前线程sleep()方法结束，其他线程join()结束，等待用户输入完毕，某个线程拿到对象锁，这些线程也将进入就绪状态。
4. 当前线程时间片用完了，调用当前线程的yield()方法，当前线程进入就绪状态。
5. 锁池里的线程拿到对象锁后，进入就绪状态。

**1.2.3 运行中状态**

1. 线程调度程序从可运行池中选择一个线程作为当前线程时线程所处的状态。这也是线程进入运行状态的唯一一种方式。

**1.2.4 阻塞状态**

1. 阻塞状态是线程阻塞在进入synchronized关键字修饰的方法或代码块(获取锁)时的状态。

**1.2.5 终止状态**

1. 当线程的run()方法完成时，或者主线程的main()方法完成时，我们就认为它终止了。这个线程对象也许是活的，但是，它已经不是一个单独执行的线程。线程一旦终止了，就不能复生。
2. 在一个终止的线程上调用start()方法，会抛出java.lang.IllegalThreadStateException异常。

**1.2.6 等待队列(本是Object里的方法，但影响了线程)**

1. 调用obj的wait(), notify()方法前，必须获得obj锁，也就是必须写在synchronized(obj) 代码段内。
2. 与等待队列相关的步骤和图

![img](https://img-blog.csdn.net/20180701221233161?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3BhbmdlMTk5MQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

- 1.线程1获取对象A的锁，正在使用对象A。
- 2.线程1调用对象A的wait()方法。
- 3.线程1释放对象A的锁，并马上进入等待队列。
- 4.锁池里面的对象争抢对象A的锁。
- 5.线程5获得对象A的锁，进入synchronized块，使用对象A。
- 6.线程5调用对象A的notifyAll()方法，唤醒所有线程，所有线程进入同步队列。若线程5调用对象A的notify()方法，则唤醒一个线程，不知道会唤醒谁，被唤醒的那个线程进入同步队列。
- 7.notifyAll()方法所在synchronized结束，线程5释放对象A的锁。
- 8.同步队列的线程争抢对象锁，但线程1什么时候能抢到就不知道了。 

注意：等待队列里许许多多的线程都wait()在一个对象上，此时某一线程调用了对象的notify()方法，那唤醒的到底是哪个线程？随机？队列FIFO？or sth else？java文档就简单的写了句：选择是任意性的（The choice is arbitrary and occurs at the discretion of the implementation）。

**1.2.7 同步队列状态**

1. 当前线程想调用对象A的同步方法时，发现对象A的锁被别的线程占有，此时当前线程进入同步队列。简言之，同步队列里面放的都是想争夺对象锁的线程。
2. 当一个线程1被另外一个线程2唤醒时，1线程进入同步队列，去争夺对象锁。
3. 同步队列是在同步的环境下才有的概念，一个对象对应一个同步队列。

**2.线程的核心方法**

1. Thread.sleep(long millis)，一定是当前线程调用此方法，当前线程进入TIME_WAITING状态，但不释放对象锁，millis后线程自动苏醒进入就绪状态。作用：给其它线程执行机会的最佳方式。
2. Thread.yield()，一定是当前线程调用此方法，当前线程放弃获取的cpu时间片，由运行状态变会就绪状态，让OS再次选择线程。作用：让相同优先级的线程轮流执行，但并不保证一定会轮流执行。实际中无法保证yield()达到让步目的，因为让步的线程还有可能被线程调度程序再次选中。Thread.yield()不会导致阻塞。
3. t.join()/t.join(long millis)，当前线程里调用其它线程t的join方法，当前线程进入TIME_WAITING/TIME_WAITING状态，当前线程不释放已经持有的对象锁。线程t执行完毕或者millis时间到，当前线程进入就绪状态。
4. obj.wait()，当前线程调用对象的wait()方法，当前线程释放对象锁，进入等待队列。依靠notify()/notifyAll()唤醒或者wait(long timeout)timeout时间到自动唤醒。
5. obj.notify()唤醒在此对象监视器上等待的单个线程，选择是任意性的。notifyAll()唤醒在此对象监视器上等待的所有线程。

 **2.1 wait/notify/notifyAll方法详细介绍**
wait()和notify()一系列的方法，是属于对象的，不是属于线程的。它们用在线程同步时，synchronized语句块中。
我们都知道，在synchronized语句块中，同一个对象，一个线程在执行完这一块代码之前，另一个线程，如果传进来的是同一个object，是不能进入这个语句块的。也就是说，同一个对象是不能同时被两个线程用来进入synchronized中的。这就是线程同步。
wait()意思是说，我等会儿再用这把锁，CPU也让给你们，我先休息一会儿！
notify()意思是说，我用完了，你们谁用？

也就是说，wait()会让出对象锁，同时，当前线程休眠，等待被唤醒，如果不被唤醒，就一直等在那儿。notify()并不会让当前线程休眠，但会唤醒休眠的线程。
先看第一个例子！

```java
`public` `class` `ThreadTest {` ` ``public` `static` `void` `main(String[] args) {`` ``final` `Object object = ``new` `Object();``    ``Thread t1 = ``new` `Thread() {``      ``public` `void` `run()``      ``{``        ``synchronized` `(object) {``          ``System.out.println(``"T1 start!"``);``          ``try` `{``            ``object.wait();``          ``} ``catch` `(InterruptedException e) {``            ``e.printStackTrace();``          ``}``          ``System.out.println(``"T1 end!"``);``        ``}``      ``}``    ``};``    ``Thread t2 = ``new` `Thread() {``      ``public` `void` `run()``      ``{``        ``synchronized` `(object) {``          ``System.out.println(``"T2 start!"``);``          ``object.notify();``          ``System.out.println(``"T2 end!"``);``        ``}``      ``}``    ``};   ``    ``t1.start();``    ``t2.start();`` ``}``}`
```

这第一个例子很简单，写了两个线程（分别是两个类，两个run方法）。两个run方法之间没有关系，但是，他们都用了同一个object!仔细看，T1里面主要写了个wait()，而T2里面主要写了个notify()。我们看到执行结果是：
T1 start!
T2 start!
T2 end!
T1 end!
流程可以这样解释：
T1启动，让出锁，让出CPU，T2获得CPU，启动，唤醒使用了object的休眠的线程，T1被唤醒后等待启动，T2继续执行，T2执行完，T1获得CPU后继续执行。
值得一提的是，再强调一遍：
wait会让出CPU而notify不会，notify重在于通知使用object的对象“我用完了！”，wait重在通知其它同用一个object的线程“我暂时不用了”并且让出CPUT。
所以说，看上面的顺序，
T2 start!
T2 end!
是连续的，说明它并没有因调用了notify而暂停！

那么，如果两个线程都写wait没有线程写notify会有什么现象呢？试一下就知道了。
结果是，
T1 start!
T2 start!
然后就是一直等待!
道理很显然，T1先启动，然后wait了，T2获得了锁和CPU，在没有其它线程与它竞争的情况下，T2执行了，然后也wait了。
在这里，两个线程都在等待，没有其它线程将它们notify，所以结果就是无休止地等下去！
至少说明了一点，wait后如果没有其它线程将它notify，是绝不可能重新启动的。不可能因为目前没有线程占用CPU，某一个正在等待的线程就自动重启。

下面，我再把它改一下，写四个线程，分别是
T1 wait()
T2 notify()
T3 notify()
T4 wait()

```java
public class ThreadF {

 public static void main(String[] args) {
 final Object object = new Object();
    Thread t1 = new Thread() {
      public void run()
      {
        synchronized (object) {
          System.out.println("T1 start!");
          try {
            object.wait();
          } catch (InterruptedException e) {
            e.printStackTrace();
          }
          System.out.println("T1 end!");
        }
      }
    };
    Thread t2 = new Thread() {
      public void run()
      {
        synchronized (object) {
          System.out.println("T2 start!");
          object.notify();
          System.out.println("T2 end!");
        }
      }
    };
    Thread t3 = new Thread() {
     public void run()
     {
     synchronized (object) {
      System.out.println("T3 start!");
      object.notify();
      System.out.println("T3 end!");
     }
     }
    };
    Thread t4 = new Thread() {
      public void run()
      {
        synchronized (object) {
          System.out.println("T4 start!");
          try {
            object.wait();
          } catch (InterruptedException e) {
            e.printStackTrace();
          }
          System.out.println("T4 end!");
        }
      }
    };
    t1.start();
    t2.start();
    t3.start();
    t4.start();
    }

}
```

首先，大家知道，线程启动的顺序，和代码的先后顺序，理论上是没有关系的！
比如我这儿写的是按T1-T2-T3-T4的先后顺序先后start()，但实际上谁先启动，是有一定几率的。
执行上面代码，有两种结果：
一种是刚好wait两次，notify两次，notify在wait之后执行，刚好执行完。
另一种是，也是刚好wait两次，notify两次，但是，notify在wait之前执行，于是，至少会有一个线程由于后面没有线程将它notify而无休止地等待下去！
我摘选了两种情况的输出结果，仅供参考：
1、可以执行结束的情况：
T1 start!
T2 start!
T2 end!
T1 end!
T4 start!
T3 start!
T3 end!
T4 end!
执行流程是：
T1启动，wait,T2获得锁和CPU，T2宣布锁用完了其它线程可以用了，然后继续执行，T2执行完，T1被刚才T2唤醒后，等待T2执行完后，抢到了CPU，T1执行，
T1执行完，T4获得CPU，启动，wait,T3获得了锁和CPU，执行，宣布锁用完了，其它线程可以用了，然后继续执行，T3执行完，已经被唤醒并且等待已久的T4
得到CPU，执行。
2、不能执行结束，有线程由于没有其它线程唤醒，一直在等待中：
T1 start!
T2 start!
T2 end!
T1 end!
T3 start!
T3 end!
T4 start!
执行流程：
T1启动，wait，让出CPU和锁，T2得以启动。T2启动，并唤醒一个线程，自己继续执行。被唤醒的线程，也就是T1等待启动机会。
T2执行完，T1抢到了CPU，执行，并结束。
这时，只剩下T3和T4，在此时，两个线程的机会均等。
但是，T3抢到了CPU，于是它执行了，而且唤醒了线程，虽然此时并没有线程休眠。说白了，它浪费了一次notify。T3顺利执行完。
这时，终于轮到了T4，它启动了，wait了，但是，后面已经没有线程了，它的wait永远不会有线程帮它notify了！
于是，它就这么等着！

顺便说一下，如果没有线程在wait，调用notify是不会有什么问题的，就像这样：
public class ThreadG {
 public static void main(String[] args) {
 final Object object = new Object();
    Thread t1 = new Thread() {
      public void run()
      {
        synchronized (object) {
          System.out.println("T1 start!");
          object.notify();
          System.out.println("T1 end!");
        }
      }
    };
    t1.start();
 }
}
T1 start!
T1 end!

引用：

https://blog.csdn.net/pange1991/article/details/53860651/

https://blog.csdn.net/superit401/article/details/52254087