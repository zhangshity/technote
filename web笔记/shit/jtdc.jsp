<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jslib/jq_webbox/css/jquery-webox.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/plugins/familynet/style/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/plugins/familynet/style/css/todc-bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/plugins/familynet/style/css/body.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/plugins/familynet/css/body-layout.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/jslib/dbNewReport/css/dbReport.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/jslib/jq_olLoading/css/loading.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/jslib/jq_message/css/jquery.message.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/plugins/familynet/net/css/frame.css"/>

<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/familynet/jslib/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/familynet/jslib/jquery.json-2.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/js_searchComponent/Date.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/js_juicer/src/juicer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jq_olLoading/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jq_olLoading/js/loading.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/js_searchComponent/jquery.inputlabel.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/js_searchComponent/InputGray.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/js_my97datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/familynet/JsInclude.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/familynet/jslib/echarts/echarts.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/familynet/jslib/echarts/macarons.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jq_message/jquery.message.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/messageEvent/messageEvent.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/dbNewReport/js/Table.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/familynet/usergrd/js/xlsx.core.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/familynet/js/slider.js"></script>

<style>
.datePick input {border: 1px solid #dfe8f1;cursor: pointer;height: 18px;width: 125px !important;margin-bottom: 0;padding : 0;}
#sel_item dt {
	background:#ffffff url("./img/ico.png") no-repeat scroll 80px center;
    border: 1px solid #dfe8f1;
    cursor: pointer;
    display: inline-block;
    font-size: 12px;
    height: 20px;
    line-height: 20px;
    overflow: hidden;
    padding-left: 10px;
    padding-right: 22px;
    position: relative;
    text-overflow: ellipsis;
    white-space: nowrap;
    width: 80px;
    z-index: 99;
}
#sel_item dd ul {
    max-height: 120px;
    overflow: auto;
    width: 110px;
}
</style>
<script type="text/javascript">
var reportId = "1861";
var time = '<%=request.getParameter("time") == null ? "" : request.getParameter("time")%>';
var timeType = '<%=request.getParameter("timeType") == null ? "Hour" : request.getParameter("timeType")%>';
var _controller =  "${pageContext.request.contextPath}"+ '/plugins/familynet/usergrid';
var _insert ='';
timeType='Hour';
var city = '';
var cityName='';
var dimension ='';
var useracc="";
var jsons = "";
var selectitem = "";
var usernum = "";
var dimenName='';
var userCity = '<%=request.getParameter("userCity") == null ? "" : request.getParameter("userCity")%>';
	var selectList = [{
			key : "1",
			value : "互联网电视",
			select : true,
			mapName : ""
		},{
			key : "2",
			value : "宽带",
			select : false,
			mapName : ""
		}]
$(document).ready(function(){
	if (time != "") {
		switch (timeType) {
			case "Day" :
				var timeText = time.substring(0, 4) + '-'
						+ time.substring(4, 6) + '-' + time.substring(6, 8);
				$("#stime").Date('init', {
							dateFmt : 'yyyy-MM-dd',
							defaultValue : timeText
						});
				break;
			case "Hour" :
				var hourText = time.substring(0, 4) + '-'
						+ time.substring(4, 6) + '-' + time.substring(6, 8) + ' ' + time.substring(8, 10);
				$("#stime").Date('init', {
							dateFmt : 'yyyy-MM-dd HH',
							defaultValue : hourText
						});
				break;
			case "Week" :
		
				var weekText = time.substring(0, 4) + '-'
						+ time.substring(4, 6) + '-' + time.substring(6, 8);
				$("#stime").Date('init', {
							dateFmt : 'yyyy-MM-dd',
							defaultValue : weekText
						});
				break;
			case "Month" :
				var monthText = time.substring(0, 4) + '-'
						+ time.substring(4, 6);
				$("#stime").Date('init', {
							dateFmt : 'yyyy-MM',
							defaultValue : monthText
						});
				break;
			default :
				break;
		}
	} else {
		switch (timeType) {
			case "Day" :
				var dayObj = getDefalutDateVale(1, "Day", true);
				
				$("#stime").Date('init', {
							dateFmt : 'yyyy-MM-dd',
							defaultValue : dayObj.text
						});
				time = $("#stime").Date('getRealValue');
			
				break;
			case "Hour" :
				var hourObj = getDefalutDateVale(2, "Hour", true);
				$("#stime").Date('init', {
							dateFmt : 'yyyy-MM-dd HH',
							defaultValue : hourObj.text
						});
				time = $("#stime").Date('getRealValue');
				break;
			case "Week" :
			
			var weekObj = getMonDay(getDefalutDateVale(7, "Day", true).value);
						var timeText = weekObj.substring(0, 4) + '-'
						+ weekObj.substring(4, 6) + '-' + weekObj.substring(6, 8);
				$("#stime").Date('init', {
							dateFmt : 'yyyy-MM-dd',
							defaultValue : timeText
						});
				time = $("#stime").Date('getRealValue');
				break;
			case "Month" :
				var monthObj = getDefalutDateVale(1, "Month", true);
				$("#stime").Date('init', {
							dateFmt : 'yyyy-MM',
							defaultValue : monthObj.text
						});
				time = $("#stime").Date('getRealValue');
				break;
			default :
				break;
		}
	}

	//$("#sel_city dd ul").append("<li><a href='javascript:void(0);' value='1'>全省</a></li>");
	/*for(var i=0;i<cityList.length;i++){
		$("#sel_city dd ul").append("<li><a href='javascript:void(0);' value="+cityList[i].key+">"+cityList[i].value+"</a></li>");
		if(cityList[i].select == true){
			$("#sel_city dt").attr("value",cityList[i].key);
			$("#sel_city dt").html(cityList[i].value);
			city = $("#sel_city dt").attr('value');
		}
	}*/
			for(var i=0;i<cityList.length;i++){
	      
		if(userCity == '' || userCity == '江苏'){
			$("#sel_city dd ul").append("<li><a href='javascript:void(0);' value="+cityList[i].key+">"+cityList[i].value+"</a></li>");
			if(cityList[i].select == true){

				$("#sel_city dt").attr("value",cityList[i].key);
				$("#sel_city dt").html(cityList[i].value);
			 city = $("#sel_city dt").attr('value');

			}
			
		}else if(userCity.indexOf(cityList[i].value) >= 0){
			$("#sel_city dd ul").append("<li><a href='javascript:void(0);' value="+cityList[i].key+">"+cityList[i].value+"</a></li>");

			$("#sel_city dt").attr("value",cityList[i].key);
			$("#sel_city dt").html(cityList[i].value);
			city = $("#sel_city dt").attr('value');
		}
		
	}
     /* for (var i = 0; i < selectList.length; i++) {
		$("#sel_item dd ul").append("<li><a href='javascript:void(0);' value="
				+ selectList[i].key + ">" + selectList[i].value + "</a></li>");
		if (selectList[i].select == true) {

			$("#sel_item dt").attr("value", selectList[i].key);
			$("#sel_item dt").html(selectList[i].value);
			
		}
	}*/
	$(".select").each(function(){
		var s=$(this);
		var z=parseInt(s.css("z-index"));
		var dt=$(this).children("dt");
		var dd=$(this).children("dd");
		var _show=function(){dd.slideDown(200);dt.addClass("cur");s.css("z-index",z+1);};   //展开效果
		var _hide=function(){dd.slideUp(200);dt.removeClass("cur");s.css("z-index",z);};    //关闭效果
		dt.click(function(){dd.is(":hidden")?_show():_hide();});
		dd.find("a").click(function(){
			dt.html($(this).html());
			dt.attr("value",$(this).attr("value")); 
			dt.attr("name",$(this).attr("name")); 

			_hide();
			 city = $("#sel_city dt").attr('value');
			
		});     //选择效果（如需要传值，可自定义参数，在此处返回对应的“value”值 ）
		$("body").click(function(i){ !$(i.target).parents(".select").first().is(s) ? _hide():"";});
	});
	$('#btn_import').bind("click", function() {
			$("#_f").click();
	});
	
	$("#_f").bind("change", function(e) {
       jsons="";
	   useracc="";
	   usernum="";
		selectitem="";
		var files = e.target.files;
    
		var fileReader = new FileReader();
		fileReader.onload = function(ev) {
	
			try {
				var data = ev.target.result, workbook = XLSX.read(data, {
							type : 'binary'
						}), // 以二进制流方式读取得到整份excel表格对象
						
				persons = []; // 存储获取到的数据
			} catch (e) {
				console.log('文件类型不正确');
			
				return;
			}
          var jsondata=to_csv(workbook).split('\n');
		
		   var userDataTitle=null;
		   var table=null;
		  
			
			    _insert = _controller + '/jtdcSave.ilf';
				table="A_FT_PRV_JT_investigate";
			userDataTitle="start_time,telephone,Period,carrier_operator_uk,province_uk,city_name,carrier_operator,is_broadband,is_log_off,broadband_type,sex,is_install_broadband,used_operator_uk,operator_appraise,NPS,user_type,Q1_GRADE,Q2_GRADE,Q3_GRADE,Q4_GRADE,Q5_GRADE,Q6_GRADE,Q7_GRADE,N2_GRADE,";
			
		 var jsonList={};
			
              for(var i = 1; i < jsondata.length-1;i++){
		   var formParams = {};
				var  jsonExcel=jsondata[i].split(',');
				
				 var title=userDataTitle.split(',');
				for(var j=0;j<jsonExcel.length;j++){
				
					var name =title[j];
				    formParams[name] = jsonExcel[j];
					
				}  

				var name =i;
				jsonList[name]=formParams;


           } 
				   $.ajax({
					type : "POST",
					url : _insert,
					dataType : "json",
					data : {
						"datalist" : JSON.stringify(jsonList),"datatitle" : userDataTitle,"table" : table 
					},
					//async:false,
					success : function(result) {
						
					},
					error : function(x, r) {
						alert(x.status + r);
						
					}
				});
         
		};

		// 以二进制方式打开文件
		fileReader.readAsBinaryString(files[0]);

	});
	
	$('#btn_export').bind("click", function() {	
if(city=='123'){
      city="";
    }else{
    city=city;
    }
	var dimenName=$("#sel_item dt").text();
	if(dimenName=='全部'){
		dimenName='';
	}
	cityName = $("#sel_city dt").text();
	
	if(cityName=='全省'){
		cityName='';
	}
	var zx_name=$("#sel_item dt").html();
	time = $("#stime").Date('getRealValue');


	//var form_no=$("#form_no").val();
	//,"form_no":"'+form_no+'"
		
			
			exportData(reportId,'data1','{"time":"'+time+'","city":"'+cityName+'"}');	    
	});

	$('#searchBtn').bind("click", function() {
	
					LoadTableLayout("集团调查样本","data1",'#table1',reportId);

		
	});

	$('#searchBtn').click();
});
function to_csv(workbook) {
	var result = [];
	
	for(sheetName in workbook.Sheets){
	 if (workbook.Sheets.hasOwnProperty(sheetName)){
		var csv = XLSX.utils.sheet_to_csv(workbook.Sheets[sheetName]);
		if(csv.length > 0){
	       
			result.push(csv);
			
		 }
	  }
			break;
	}
	return result.join("\n");
}
function getParameterConfig(){
    if(city=='123'){
      city="";
    }else{
    city=city;
    }
	var dimenName=$("#sel_item dt").text();
	if(dimenName=='全部'){
		dimenName='';
	}
	cityName = $("#sel_city dt").text();
	
	if(cityName=='全省'){
		cityName='';
	}
	var zx_name=$("#sel_item dt").html();
	time = $("#stime").Date('getRealValue');
	//time=time.substring(0, 4)+'-'+time.substring(4, 6);

	//var form_no=$("#form_no").val();
	//,"form_status":"'+dimension+'","form_no":"'+form_no+'"
	//,"form_no":"'+form_no+'"
	var parameterConfig ='{"time":"'+time+'","city":"'+cityName+'"}';
	return parameterConfig;
}
function LoadTableLayout(tableTitle,datasetname,divname,reportId){
 var parameterConfig =getParameterConfig();
 //获取表格配置
 var searchPara = {
		reportId:reportId,
		tableTitle:tableTitle
	}; 
					 
	$.ajax({
			type: 'post',
			url: reportTableLayout,
			data:  searchPara,
			dataType: 'jsonp',
			jsonp: 'jsonpCallback',
			success: function (data, _textStatus) {
				 var sData = data;  
				 sData.showTitle = "false";
				 var columnDetail = getTableDetail(sData.tableColumns);
				 sData.columns = columnDetail.columns;
				 	
				 $(divname).Table('init', sData);
				 
				 LoadTableData(parameterConfig,datasetname,divname,reportId);
			},
			error: function (XMLHttpRequest, textStatus, errorThrown) { 
				alert("error");
			} 
		});
}

function LoadTableData(parameterConfig,datasetname,divname,reportId){
	 var initParam = {
			reportId: reportId,
			datasetName: datasetname,
			parameterConfig:parameterConfig,
			start:0,
			limit:30
		}
		
	$(divname).Table('setInitParam', initParam);	
	$(divname).Table('loadData');
}






</script>
</head>
<body>
<div style="box-shadow: 0 2px 5px #ebeff1;margin-top: 10px;">
	<div class="panle panlenotitle" style="line-height: 24px;min-height:28px;">
		<div class="search-group">
			 <div class="datePick" id="stime" style="display: inline; margin-left: 10px; float: right;"></div>
		</div>
		<!--<div id="user" class="search-group search-group-pos" style="top: -3px;">
				<span>工单号查询</span>
				<input type="text" width="20px;" id="form_no">
		</div>-->
		<div class="search-group" id="div_sel_city">
				<dl class="select" id="sel_city" style="z-index: 200">
					<dt value="">
						地市
					</dt>
					<dd>
						<ul>
						</ul>
					</dd>
				</dl>
	   	   </div>
		 
		<div class="search-group search-group-pos" style="top:-7px;">
			<a id="searchBtn" href="javascript:void(0);" class="btn btn-primary"> 查 询 </a>
		</div>
		<div class="search-group search-group-pos" style="top:-7px;">
			<a id="btn_import" href="javascript:void(0);" class="btn btn-primary"> 导 入 </a>
		</div>
		<div class="none">
				<input type="file" name="_f" id="_f" />
		</div>
		<div class="search-group search-group-pos" style="top:-7px;">
			<a id="btn_export" href="javascript:void(0);" class="btn btn-primary"> 导 出 </a>
		</div>
    </div>
</div>
<!-- 主体-s -->
	<div class="row-fluid">
		<div class="span12">
			<div class="panel">
				<div class="panel-heading">
				

				</div>
				<div class="panel-body clearfix borderb">

					<div class="a-g-bd1 clearfix">
						<div class="table-wrap">
							<div class="table-wrap" id="table1"
								style="height: 500px; display: block;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>