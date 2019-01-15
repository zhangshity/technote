# ServletRequest、 HttpServletRequest、Request的联系与区别

                                                                 Chunyang.Zhang
---
##### 一
    servlet理论上可以处理多种形式的请求响应形式
    http只是其中之一

    所以HttpServletRequest、HttpServletResponse分别是ServletRequest和ServletResponse的子类(子接口)

##### 二
         HttpServletRequest和ServletRequest都是接口

         HttpServletRequest继承自ServletRequest

        HttpServletRequest比ServletRequest多了一些针对于Http协议的方法。如getHeader (String name)， getMethod () ，getSession () 等等。

        他们对应的实现类：

        javax.servlet.ServletRequestWrapper (implements javax.servlet.ServletRequest)

        javax.servlet.http.HttpServletRequestWrapper (implements javax.servlet.http.HttpServletRequest)

##### 三

        而所谓的request（在JSP中使用的）其实只是规范中的一个名称而已。它当然是一个对象，但并不是SUN提供的，这是由各个不同的Servlet提供商编写的，SUN只是规定这个类要实现HttpServletRequest接口，并且规定了各个方法的用途，但具体是什么类是由各个提供商自己决定的。

> >
> >
> >
> >
### ========================================================================

# 补充Servlet 、HttpServlet关系

##### Servlet HttpServlet 代码关系

* public abstract class `HttpServlet` extends javax.servlet.`GenericServlet` implements java.io.`Serializable`

* public abstract class `GenericServlet` implements javax.servlet.`Servlet`, javax.servlet.`ServletConfig`, java.io.`Serializable`
