# sevlet加载流程

* 自定义servlet 实现servlet接口
```
public class HelloServlet implements servlet{

  /* 构造函数constructor(自定义overload) */
	public HelloServlet() {
		// TODO Auto-generated constructor stub
	}

  /* destory() */
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}

  /* Configuration */
	@Override
	public ServletConfig getServletConfig() {
		// TODO Auto-generated method stub
		return null;
	}

	/* Info */
	@Override
	public String getServletInfo() {
		// TODO Auto-generated method stub
		return null;
	}

	/* init() */
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	/* service() */
	@Override
	public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
}
```
##### 加载流程
* 1.初始加载 `constructor(){}`
* 2.初始加载 `init()` 方法
* 3.每次调用都加载 `service()` 方法
* 4.关闭时调用 `destory()` 方法

##### web.xml 文件配置
* 功能: 配置和映射 `自定义的Servlet`
* 所在位置:
```
    WebContent-|
               |-META-INF -|
               |           |-MANIFEST.MF
               |
               |-WEB-INF -|
                          |-lib
                          |
                          |-web.xml
```
* 配置的xml代码:
```
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee
                      http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
	version="3.1" metadata-complete="true">

    <servlet>
      	<servlet-name>HelloServlet</servlet-name>
		    <servlet-class>com.zcy.test.HelloServlet</servlet-class>
    </servlet>

    <servlet-mapping>
	    	<servlet-name>HelloServlet</servlet-name>
	    	<url-pattern>/hello</url-pattern>
	</servlet-mapping>

</web-app>
```
