<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.langchao.comm.authority.*" %>
<%@ page import="com.inspur.plugins.authority.SessionUtil" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "w3.org/TR/html4/strict.dtd">
<html>
<%
	session = SessionUtil.getRealSession(session);
	//在线人数
	Map mapOnlineUser = (Map)session.getServletContext().getAttribute("ONLINE_USER_LIST");
	int onlineNum = 0;
	if(mapOnlineUser !=  null){
		for (Object key : mapOnlineUser.keySet()) {
			javax.servlet.http.HttpSession userSession = (javax.servlet.http.HttpSession)mapOnlineUser.get((String)key);
			UserinfoObj user = new UserinfoObj();
			try {
				user = (UserinfoObj) userSession
						.getAttribute("UserinfoSen");
				onlineNum ++;		
			} catch (Exception e) {
				// 如果session已经过期，会报一个异常
				continue;
			}
		}	
	}
	UserinfoObj userinfoObj = (UserinfoObj)session.getAttribute("UserinfoSen");
	String useraccount = "";
	String userName = "";
	String cityName="";
	if(userinfoObj != null){
		useraccount = userinfoObj.getUseraccount();
		userName = userinfoObj.getEmpname();
		cityName = userinfoObj.getCompname();
		//cityName = "南京";
	}
	
%>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/plugins/familynet/index/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/plugins/familynet/index/css/todc-bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/plugins/familynet/index/css/frame.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/plugins/familynet/index/css/body-layout.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jslib/jquery-easyui-1.3.5/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jslib/jquery-easyui-1.3.5/themes/icon.css">	
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/plugins/familynet/jslib/jq_tab/css/TabPanel.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jslib/jq_webbox/css/jquery-webox.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/familynet/JsInclude.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/familynet/jslib/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/familynet/jslib/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/familynet/js/base.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/js_juicer/src/juicer.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/familynet/jslib/jq_tab/TabPanel.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/familynet/jslib/jq_tab/Fader.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/familynet/jslib/jq_tab/Math.uuid.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/common/stringutil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jq_webbox/jquery-webox.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/dbNewReport/js/ajaxfileupload.js"></script>
<script src="${pageContext.request.contextPath}/jslib/common/cookieutil.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>
<title>家客性能与质量监测系统</title>

<style>
#bottom {
    background-color: #34a3da;
    clear: both;
    color: #ffffff;
    font-size: 12px;
    height: 25px;
    line-height: 25px;
    padding: 0;
    width: 100%;
}
	.bg{width:100%;height:100%;position:relative;color: #5a5655;}
		.webox #inside h1 	a{width:0px;height:0px;}
		#warning,#warning2{color: #FD6262;margin-top:30px;font-size:14px;}
		a.l-btn span span.l-btn-text{top:0px;}
		#uploadFile{border:none;}
</style>

<script type="text/javascript">
var time = '<%=request.getParameter("time") == null ? "" : request.getParameter("time")%>';
var timeType = '<%=request.getParameter("timeType") == null ? "Hour" : request.getParameter("timeType")%>';
var city = '';

$(document).ready(function(){
	 var xtgl_cityname='<%=cityName%>';	 
     
	  if('江苏'!=xtgl_cityname){
		  
		  
		  $('#xtgl').each(function(){
			  
			    $('#xtgl li:first').hide();
		        $('#xtgl li:first').next().hide();
      
		});
		  
	}else{
		$('#xtgl li').each(function(){
			  
			 $('#xtgl li').show();  
      
		});
		
	}
	
	
});
	
</script>
</head>

<body>
<!-- 顶部导航-start -->
	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<a class="brand" style="color: #fff;font-size: 16px;font-weight: normal;" href="javascript:void(0);">
					<img alt="" src="./img/logo.png">
				</a>
				
				<div class="apply clearfix" style="width: 780px;">
					<!-- <div class="img_l"><img src="../img/navleft.png" /></div> -->
					<div class="apply_nav">
						<div class="apply_w">
							<ul>
								<li  class="dropdown">
									<a class="apply_array"  href="javascript:void(0);" onclick="openUrl('1','概览','/plugins/familynet/index/gailan.jsp?userCity=<%=cityName%>','_tab',false);">
										<div class="apply_img nav-icon1"></div>
										<span class="apply_info">概览</span>
									</a>
								</li>
								<li class="dropdown">
									<a class="apply_array dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
										<div class="apply_img nav-icon2"></div>
										<span class="apply_info">全景视图</span>
									</a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('201','流量流向','/plugins/familynet/flow/index.jsp?userCity=<%=cityName%>','_tab');">流量流向</a></li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('202','端到端性能','/plugins/familynet/net/index.jsp?userCity=<%=cityName%>','_tab');">端到端性能</a></li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('203','业务质量','/plugins/familynet/busi/index.jsp?userCity=<%=cityName%>','_tab');">业务质量</a></li>
									</ul>
								</li>
								<li class="dropdown">
									<a class="apply_array dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
										<div class="apply_img nav-icon3"></div>
										<span class="apply_info">网络性能</span>
									</a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('301','网络能力评估','/plugins/familynet/netpm/evaluation/province.jsp?userCity=<%=cityName%>','_tab');">网络能力评估</a></li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('302','网管性能','/plugins/familynet/netpm/performance.jsp?userCity=<%=cityName%>','_tab');">网管性能</a></li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('300','出口链路质量','/plugins/familynet/source/manage.jsp?userCity=<%=cityName%>','_tab');">出口链路质量</a></li>

										<!--
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('303','测试性能','/plugins/familynet/netpm/testpm/index.jsp','_tab');">测试性能</a></li>-->
										<!-- <li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('304','小区质量监测','http://10.40.96.34:5898/default?m=jiake_cells','_tab');">小区质量监测</a></li> -->
										<li class="dropdown-submenu">
										<a tabindex="-1" href="javascript:void(0);" onclick="javascript:void(0);">质差小区</a>
											<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
												<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('305','质差小区分析','/plugins/familynet/cell/badcell.jsp?userCity=<%=cityName%>','_tab');">质差小区分析</a></li>												
										           <li class="dropdown-submenu">
										           <a tabindex="-1" href="javascript:void(0);" onclick="javascript:void(0);">质差小区明细</a>
											       <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
												    <li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('308','质差小区统计分地市','/plugins/familynet/cell/zxfxfds.jsp?userCity=<%=cityName%>','_tab');">质差小区统计分地市</a></li>
													 <li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('307','质差用户统计分代维公司','/plugins/familynet/cell/zxfxfdwgs.jsp?userCity=<%=cityName%>','_tab');">质差用户统计分代维公司</a></li>
												     <li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('306','质差小区明细','/plugins/familynet/cell/badcell_detail.jsp?userCity=<%=cityName%>','_tab');">质差小区明细</a></li>
											        </ul>
											       </li>	

											</ul>
											</li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('307','质差小区工单统计','/plugins/familynet/cell/zxuserPaid.jsp?userCity=<%=cityName%>','_tab');">质差小区工单统计</a></li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('308','质差小区工单统计','/plugins/familynet/cell/bhltj.jsp?userCity=<%=cityName%>','_tab');">闭环率统计报表</a></li>
	
	                                    <li class="dropdown-submenu">
										<a tabindex="-1" href="javascript:void(0);" onclick="javascript:void(0);">隐患路由器统计</a>
											<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
												<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('311','异常用户整治情况统计','/plugins/familynet/tzbc/abnormal_user.jsp?userCity=<%=cityName%>','_tab');">异常用户整治情况统计</a></li>												
										         <li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('312','异常上下线明细','/plugins/familynet/tzbc/abnormal_user_zztj.jsp?userCity=<%=cityName%>','_tab');">异常上下线明细</a></li>
												 <li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('313','长期异常账号统计','/plugins/familynet/tzbc/abnormal_user_tj.jsp?userCity=<%=cityName%>','_tab');">长期异常账号统计</a></li>

											</ul>
										</li>
										
										 <li class="dropdown-submenu">
										<a tabindex="-1" href="javascript:void(0);" onclick="javascript:void(0);">波动预警分析</a>
											<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
											  
											  <li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('315','PON口分析','/plugins/familynet/kpi/busiPon.jsp?userCity=<%=cityName%>','_tab');">PON口分析</a></li>
									     	<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('314','OLT口分析','/plugins/familynet/kpi/busiOlt.jsp?userCity=<%=cityName%>','_tab');">OLT口分析</a></li>
									      	
	
											</ul>
										</li>
										
	                                     <li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('903','工单闭环管理统计','/plugins/familynet/kpi/nmqs.jsp?userCity=<%=cityName%>','_tab');">工单闭环管理统计</a></li>

	
									</ul>
								</li>
								<li class="dropdown">
									<a class="apply_array dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
										<div class="apply_img nav-icon4"></div>
										<span class="apply_info">探针拨测</span>
									</a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
								
										<!--<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('401','飞思达拨测分析','/plugins/familynet/source/quality.jsp','_tab');">飞思达拨测分析</a></li>-->
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('403','普天拨测业务分析','/plugins/familynet/source/ptbc.jsp?userCity=<%=cityName%>','_tab');">普天拨测业务分析</a></li>
										
										<!--<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('404','竞对网络评估','/plugins/familynet/pecp/contrast/npdgrade.jsp','_tab');">竞对网络评估</a></li>--> 
										<!--<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('405','测试信息查询','/plugins/familynet/pecp/contrast/userdetail.jsp','_tab');">测试信息查询</a></li>-->
							 		
							 			<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('406','分段探针拨测对比','/plugins/familynet/tzbc/main.jsp?userCity=<%=cityName%>','_tab');">分段探针拨测对比</a></li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('407','用户侧探针分析','/plugins/familynet/tzbc/main.jsp?type=user&userCity=<%=cityName%>','_tab');">用户侧探针分析</a></li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('408','省内侧探针分析','/plugins/familynet/tzbc/main.jsp?type=pro&userCity=<%=cityName%>','_tab');">省内侧探针分析</a></li>
									</ul>
								</li>
								<li class="dropdown">
									<a class="apply_array dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
										<div class="apply_img nav-icon5"></div>
										<span class="apply_info">感知评估</span>
									</a>
								
									<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
									
										<li class="dropdown-submenu">
											<a tabindex="-1" href="javascript:void(0);" onclick="javascript:void(0);">满意度评估</a>
											<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
												<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('501','满意度影响力模型','/plugins/familynet/pecp/estimate/model.jsp?userCity=<%=cityName%>','_tab');">满意度影响力模型</a></li>
												<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('502','宽表查询与导出','/plugins/familynet/pecp/estimate/search.jsp?userCity=<%=cityName%>','_tab');">宽表查询与导出</a></li>
												<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('503','预测结果统计分析','/plugins/familynet/pecp/estimate/static.jsp?userCity=<%=cityName%>','_tab');">预测结果统计分析</a></li>
											</ul>
										</li>
									
							
										<li class="dropdown-submenu">
											<a tabindex="-1" href="javascript:void(0);" onclick="javascript:void(0);">满意度分析</a>
											<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
												<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('504','区域满意度分析','/plugins/familynet/pecp/analysis/region.jsp?userCity=<%=cityName%>','_tab');">区域满意度分析</a></li>
												<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('505','设备满意度分析','/plugins/familynet/pecp/analysis/device.jsp?userCity=<%=cityName%>','_tab');">设备满意度分析</a></li>
												<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('506','满意度调查分析','/plugins/familynet/usergrd/allJsp.jsp?userCity=<%=cityName%>','_tab');">满意度调查分析</a></li>

											</ul>
										</li>
										
									    <!-- 
										<li class="dropdown-submenu">
											<a tabindex="-1" href="javascript:void(0);" onclick="javascript:void(0);">竞对网络评估</a>
											<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
												<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('506','竞对网络评估','/plugins/familynet/pecp/contrast/npdgrade.jsp','_tab');">竞对网络评估</a></li>
												<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('507','测试信息查询','/plugins/familynet/pecp/contrast/userdetail.jsp','_tab');">测试信息查询</a></li>
											</ul>
										</li>
										 -->
									</ul>
	
								</li>
								 <li class="dropdown">
									<a class="apply_array dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
										<div class="apply_img nav-icon6"></div>
										<span class="apply_info">用户分析</span>
									</a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('601','质差用户定界','/plugins/familynet/tzbc/user_bound.jsp?userCity=<%=cityName%>','_tab');">质差用户定界</a></li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="auth();">质差用户定界(DPI)</a></li>
										<!--<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('506','用户上网日志','/plugins/familynet/netlog/userdetail.jsp?userCity=<%=cityName%>','_tab');">用户上网日志</a></li>-->
									</ul>
								</li>
								<li class="dropdown">
									<a class="apply_array dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
										<div class="apply_img nav-icon7"></div>
										<span class="apply_info">市场支撑</span>
									</a>
									
									<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('701','精准提速分析','/plugins/familynet/market/speed/speed.jsp?userCity=<%=cityName%>','_tab');">精准提速分析</a></li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('702','流失预警分析','/plugins/familynet/market/alarm/losswarn.jsp?userCity=<%=cityName%>','_tab');">流失预警分析</a></li>
										<li class="dropdown-submenu">
											<a tabindex="-1" href="javascript:void(0);" onclick="javascript:void(0);">数据仿真模型</a>
											<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
												<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('703','提速用户分析','/plugins/familynet/market/model/speedUpUser.jsp?userCity=<%=cityName%>','_tab');">提速用户分析</a></li>
												<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('704','流失用户分析','/plugins/familynet/market/model/losedUser.jsp?userCity=<%=cityName%>','_tab');">流失用户分析</a></li>
												<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('705','扩容小区分析','/plugins/familynet/market/model/expansionCell.jsp?userCity=<%=cityName%>','_tab');">扩容小区分析</a></li>
												<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('706','流失小区分析','/plugins/familynet/market/model/losedCell.jsp?userCity=<%=cityName%>','_tab');">流失小区分析</a></li>
											</ul>
										</li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('707','系统规则','/plugins/familynet/market/alarm/ruleconfig.jsp?userCity=<%=cityName%>','_tab');">系统规则</a></li>
										
									</ul>
								
								</li> 
								<%if(useraccount.equals("xuyinsgs")||useraccount.equals("yaofei")||useraccount.equals("zhangtaolyg")||useraccount.equals("maopingping")||useraccount.equals("fangh")||useraccount.equals("linxiaoming")||
									useraccount.equals("guoyuc")||useraccount.equals("caiyaping")||useraccount.equals("liyinTZ")||useraccount.equals("wangyj")||useraccount.equals("congmx")||
									useraccount.equals("huangyanSQ")||useraccount.equals("linjiejie")||useraccount.equals("yanghe")||useraccount.equals("shengc")||useraccount.equals("nijianzhongYC")||
									useraccount.equals("majian")||useraccount.equals("lijq")||useraccount.equals("nicm")||useraccount.equals("dingyunxia")){%>
								<li class="dropdown">
									<a class="apply_array dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
										<div class="apply_img nav-icon8"></div>
										<span class="apply_info">系统管理</span>
									</a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" id='xtgl'>
									
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('801','指标呈现配置','/plugins/familynet/kpi/list.jsp?userCity=<%=cityName%>','_webox');">指标呈现配置</a></li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('802','指标门限配置','/plugins/familynet/kpi/limit.jsp?userCity=<%=cityName%>','_webox');">指标门限配置</a></li>
										
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('803','登陆日志','http://10.40.96.34:6600/fir/analysisJquery_js/dbReport/js/dbReport.jsp?reportId=178&isShowHeader=true&isShowSearchTool=true','_tab');">登陆日志</a></li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('804','操作日志','http://10.40.96.34:6600/fir/analysisJquery_js/dbReport/js/dbReport.jsp?reportId=175&isShowHeader=true&isShowSearchTool=true','_tab');">操作日志</a></li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('805','EOMS工单统计报表','http://10.40.96.34:6600/fir/analysisJquery_js/dbReport/js/dbReport.jsp?reportId=798&isShowHeader=true&isShowSearchTool=true&userCity=<%=cityName%>','_tab');">EOMS工单统计报表</a></li>
										
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('810','派单对象选择','/plugins/familynet/index/workOrderUpdate.html','_tab');">派单对象选择</a></li>
										
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('901','用户数据完整性','http://10.40.96.34:6600/fir/analysisJquery_js/dbReport/js/dbReport.jsp?reportId=799&isShowHeader=true&isShowSearchTool=true','_tab');">用户数据完整性</a></li>
										<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('902','设备性能数据完整性','http://10.40.96.34:6600/fir/analysisJquery_js/dbReport/js/dbReport.jsp?reportId=800&isShowHeader=true&isShowSearchTool=true','_tab');">设备性能数据完整性</a></li>
                                        <!--<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('903','工单闭环管理统计','/plugins/familynet/kpi/nmqs.jsp?userCity=<%=cityName%>','_tab');">工单闭环管理统计</a></li>-->
										<!--<li><a tabindex="-1" href="javascript:void(0);" onclick="openUrl('904','工单闭环详情','/plugins/familynet/kpi/gdxq.jsp?userCity=<%=cityName%>','_tab');">工单闭环详情</a></li>-->

									</ul>
								</li>
								<%}%>
							</ul>
						</div>
					</div>
					<!-- <div class="img_r"><img src="../img/navright.png" /></div>	 -->
				</div>
			</div>
		</div>
	</div>
	<!-- 顶部导航-end -->

<!-- 内容-start -->
	<div class="page jiake-page" id="contentMain">
	</div>
<!-- 内容-end -->	
	<div class="navbar navbar-fixed-bottom">
		<div class="navbar-inner">
			<div class="container">
				<div class="footer-text pull-left">
					<ul class="navone clearfix">
						<li><a href="javascript:void(0);"><img src="img/ico-user.png">用户名：<%=userName %></a></li>
						<li class="line"><img src="img/ico-line.png"></li>
						<li><a href="javascript:void(0);">在线：<%=onlineNum%>人</a></li>
						<li class="line"><img src="img/ico-line.png"></li>
						<!--javascript:logout();退出系统注释--4A登陆的-->
						<li><a><img src="img/ico-out.png">退出系统</a></li>
						
					</ul>
				</div>
				<div class="footer-text-r pull-right">版权所有：浪潮软件集团有限公司</div>
			</div>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" modal="true" closable="false" closed="true" style="width:600px;height:400px;padding:5px;">
			<div class="bg">
				<div style="background:#fff;width:500px;height:300px;margin: auto;  position: absolute; top: 0; left: 0; bottom: 0; right: 0; text-align:center;">
					<table cellpadding="3" align="center">
					<tr>
						<td>审批人：</td>
						<td><input id="approverName" class="easyui-textbox" type="text" style="width:200px;margin:0px;" readonly></input></td>
						<td><input id="approver" class="easyui-textbox" type="hidden"  style="width:200px;"></input></td>
					</tr>
					<tr>
						<td>手机号码：</td>
						<td><input id="phone" class="easyui-textbox" type="text" style="width:200px;margin:0px;" readonly></input></td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"  onClick="generateCode()" >申请审批</a></td>
					</tr>
					<tr>
						<td>用途:</td>
						<td><textarea id="authUse" class="easyui-textbox"  data-options="multiline:true"  style="width:208px;height:70px;margin:0px;"></textarea></td>
					</tr>
					<tr>
						<td>短信密钥:</td>
						<td><input id="authCode" class="easyui-textbox" type="text" style="width:200px;margin:0px;"></input></td>
					</tr>
					</table>					
			     	<a href="javascript:void(0)" class="easyui-linkbutton" style="margin-top: 30px;" onClick="verifyAuthCode()" >提 交</a>
			     	<a href="javascript:void(0)" class="easyui-linkbutton" id="close" style="margin-top: 30px;" onClick="$('#dlg').dialog('close');" >关 闭</a>
				</div>
			</div>
		</div>
</body>

<script>
var tabpanel;
//tab控件
tabpanel = new TabPanel({
	renderTo : 'contentMain',
	autoResizable : true,
	border : 'none',
	active : 0,
	maxLength : 20,
	items : []
});

//解除tab组件自己注册的resize事件
$(window).unbind("resize");
$(window).resize(function(e){
        var height = $(window).height() - 95;
		$("#contentMain").height(height);
		$(".tabpanel_content").height(height-31);
	}).resize();
	
//添加tab控件
function addurl(tabid, tabtitle, url,target,canClose) {
	if (!url.startWith('http://'))
		url = '${pageContext.request.contextPath}' + url;
	if(target=='_blank'){
		 window.open(url, tabtitle);	
	}else if(target=='_webox'){
		$.webox({
			width: 820,
			height: 520,
			bgvisibel: true,
			title: tabtitle,
			iframe: encodeURI(url)
		});
	}else{
		if ( tabpanel.tabs.length > 10 )
		{
			alert("当前打开的页达到上限，请先关闭其他页！");
			return;
		}
		tabpanel.addTab( {
				id : tabid,
				title : tabtitle,
				closable:canClose,
				//height:$("#menu").height(),
				html : '<iframe src="' + url + '" width="100%" height="100%" frameborder="0" style="position: absolute;"></iframe>',
				click : function(id) {
					
				}
		});
		$(window).resize();
	}
}

//点击出菜单
function openUrl(id, name, path,target,canClose){
	if (!tabpanel.hasTabId(id)) {
		if (path&& path!='null') {
			addurl(id, name, path,target,canClose);
			addOpLog(name);
			tabpanel.show(id);
		}
	} else {
		tabpanel.show(id);
	}
}

//记录操作日志
function addOpLog(menuName)
{
	$.ajax({
		type: 'get',
		url: '${pageContext.request.contextPath}/plugins/main/log/sysoplog/createByMenu.ilf',
		dataType: 'json',
		data: {menuName: menuName.trim()},
		success: function (_data, _textStatus) {
			
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) { 
			
		} 
	});
}

openUrl("1","概览","/plugins/familynet/index/gailan.jsp","_tab",false);

function resizeRightDiv(){
	$(".tabpanel_tab_content").width($(window).width() - parseInt($("#contentMain").css("marginLeft"),10) );
	$(".tabpanel_content").width($(".tabpanel_tab_content").width());
	//$(".tabpanel").width($("#content").width());
	$("#contentMain").width($(".tabpanel_tab_content").width());
	//.height($("#menu").height());
}

//关闭当前tab页
function closeTab(){
    var activedTabIndex = tabpanel.tabpanel_mover.children().index(tabpanel.tabpanel_mover.find('.active')[0]);
    tabpanel.kill(activedTabIndex);
}

function logout() {
	window.location.replace('${pageContext.request.contextPath}/plugins/main/logout.jsp');
};
function auth(){
	var userphone=$("#phone").val()

	$.ajax({
				type : "POST",
			    async: false,    
				url : "${pageContext.request.contextPath}/plugins/main/authapprover/verifyAuth.ilf",
				dataType : "json",
				data : {'userphone':userphone},
				success : function(data) {
					if(data.result == 'hasAuth'){
						//加入正常方法
						openUrl('602','质差用户定界(DPI)','http://10.35.67.250:8081/foura/a/login','_blank');
					}else if(data.result == 'noAuth'){
						$.messager.alert("提示","当前用户无权限访问");
					}else{
						$('#dlg').dialog('open').dialog('setTitle', '鉴权验证');
						$('#approver').val(data.obj.approver);
						$('#approverName').val(data.obj.approverName);
						$('#phone').val(data.obj.approverTel);
					}
					
				},
				error : function(x, r) {
						$.messager.alert("提示","鉴权验证失败");
				}
			});

}

function generateCode(){
	var approver = $('#approver').val();
	var approverTel = $('#phone').val();
	if(approver == null || approver == ''){
		$.messager.alert("提示","审批人不能为空");
		return;
	}
	if(approverTel == null || approverTel == ''){
		$.messager.alert("提示","审批人手机不能为空");
		return;
	}
	$.ajax({
				type : "POST",
				url : "${pageContext.request.contextPath}/plugins/main/authapprover/generateCode.ilf",
				dataType : "json",
				data : {},
				success : function(data) {
					if(data.result){
						$.messager.alert("提示","已发送鉴权验证码");
					}else{
						$.messager.alert("提示","发送鉴权验证码失败");
					}
					
				},
				error : function(x, r) {
						$.messager.alert("提示","发送鉴权验证码失败");
				}
			});
	
}

function verifyAuthCode(){
		var userphone=$("#phone").val()
		var authCode = $('#authCode').val();
		var authUse = $('#authUse').val();
		if(authCode == null || authCode == ''){
			$.messager.alert("提示","短信密钥不能为空");
			return;
		}
		if(authUse == null || authUse == ''){
			$.messager.alert("提示","用途不能为空");
			return;
		}
		$.ajax({
				type : "POST",    
				url : "${pageContext.request.contextPath}/plugins/main/authapprover/verifyAuthCode.ilf",
				dataType : "json",
				data : {'code':authCode,'use':authUse,'userphone':userphone},
				success : function(data) {
					if(data.result){
						$.messager.alert("提示","鉴权验证成功");
						$('#dlg').dialog('close');
						//加入正常方法
						openUrl('602','质差用户定界(DPI)','http://10.35.67.250:8081/foura/a/login','_blank');
					}else{
						$.messager.alert("提示","鉴权验证失败");
					}
					
				},
				error : function(x, r) {
						$.messager.alert("提示","鉴权验证失败");
				}
			});
}

</script>

</html>