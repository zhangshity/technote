# clone()方法

> 浅克隆 shadow clone  : 只克隆 引用(reference)
> 深克隆 deep clone    : 既克隆 引用(reference),又克隆 实例对象(instance)

#### 区别例子见 chunyang.zhang的GitHub库代码
`https://github.com/zhangshity/aysos/tree/master/src/main/java/com/zcy/clone/sample`

* ·! Java中的 clone()方法必须实现 Cloneable 接口
   `protected native Object clone() throws CloneNotSupportedException;`

   当然此接口是native 修饰的,故其实现使用底层的C/C++

##### ==================================================================================
> [转]
* 1.Java的clone()：深复制与浅复制
`https://www.cnblogs.com/acode/p/6306887.html`

* 2.浅谈Java中的浅复制和深复制
`https://blog.csdn.net/weixin_38810239/article/details/79506461`

* 3.java Clone使用方法详解
`https://www.cnblogs.com/felixzh/p/6021886.html`
