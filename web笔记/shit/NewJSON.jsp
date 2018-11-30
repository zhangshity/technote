<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- <p id="id1">段落p1</p>
<p id="id2">段落p2</p>
<p id="id3">段落P3</p> -->
<p>
网站名称: <span id="id1"></span><br /> 
网站地址: <span id="id2"></span><br /> 
网站 slogan: <span id="id3"></span><br /> 
</p>
<script type="text/javascript">
	var jo = {
		"name" : "yang",
		"age" : 18,
		"url" : "www.zhihu.com"
	};
	document.getElementIdBy("id1").innerHTML = jo.name;
	document.getElementIdBy("id2").innerHTML = jo.age;
	document.getElementIdBy("id3").innerHTML = jo.url;
</script>


</head>
<body>

</body>
</html>