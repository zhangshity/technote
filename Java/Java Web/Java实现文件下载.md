# Java实现文件下载

* download.jsp：


```jsp
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>文件下载</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
  </head>
  
  <body>
  	<a href="/download/DownloadServlet?filename=1.jpg">文件下载</a>
  </body>
</html>
```

* DownloadServlet：	

```java
public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setCharacterEncoding("UTF-8");
		//设置ContentType字段值
		response.setContentType("text/html;charset=utf-8");
		//获取所要下载的文件名称
		String filename = request.getParameter("filename");
		//下载文件所在目录
		String folder = "/filename/";
		//通知浏览器以下载的方式打开
		response.addHeader("Content-type", "appllication/octet-stream");
		response.addHeader("Content-Disposition", "attachment;filename="+filename);
		//通知文件流读取文件
		InputStream in = getServletContext().getResourceAsStream(folder+filename);
		//获取response对象的输出流
		OutputStream out = response.getOutputStream();
		byte[] buffer = new byte[1024];
		int len;
		//循环取出流中的数据
		while((len = in.read(buffer)) != -1){
			out.write(buffer,0,len);
		}
	}
```

效果图：

![](https://img-blog.csdn.net/20171122111450916?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQ2hlbmdfTWF5/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)


![](https://img-blog.csdn.net/20171122111504616?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQ2hlbmdfTWF5/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)