<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테마별</title>
<script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<style>
div.areaList {
	position: absolute;
	top: 20%;
}

div.area {
	padding: 0px 15px;
	border: 1px solid black;
	width: 120px;
	height: 30px;
	text-align: center;
}

div.clear {
	clear: left;
	border: 1px solid black;
}

div.cityList>div {
	float: left;
	border: 1px solid black;
	padding: 5px 5px;
	width: 140px;
}

div.cityList {
	position: absolute;
	left: 25%;
	top: 15%;
}

.mainUl>li {
	position: relative;
	font-weight: 600;
	font-size: 24;
	left: 50%;
	float: left;
	border: 1px solid black;
	padding: 10px 15px;
	list-style-type: none;
}

.mainUl>li:hover {
	background-color: darkkhaki;
}

a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}
</style>
</head>
<body>
	<jsp:include page="top.jsp" />
	<jsp:include page="navi.jsp" />

	<div class="areaList">
		<c:forEach items="${areaList}" var="area">
			<div class="area" id="${area.areaCode}">
				<a href="./areaContentList?nav=${area.areaCode}">${area.name}</a>
			</div>
		</c:forEach>
	</div>

	<form action="resultList" method="GET">
		<div class="cityList">
			<c:forEach items="${cityList}" var="city" varStatus="status">
				<c:if test="${status.index % 5 == 0}">
					<div class="clear">
						<input type="checkbox" name="local" value="${city.cityCode}">${city.name}
					</div>
				</c:if>
				<c:if test="${status.index % 5 != 0}">
					<div>
						<input type="checkbox" name="local" value="${city.cityCode}">${city.name}
					</div>
				</c:if>
			</c:forEach>
		</div>
		<input type="hidden" name="nav" value="${nav}" /> <input type="hidden"
			name="type" value="area" /> <input type="button"
			onclick="maxChkBox()" value="검색" />
	</form>

</body>
<script>
	$(document).ready(function() {
		$("div#"+${nav}).css({"background-color" : "lightgray"});
	});
	
	function maxChkBox(){
		var cnt = 0;
		$('input[type="checkbox"]').each(function(idx, item){
			
			if($(this)[0].checked){
					cnt++;
				}
		});
		if(cnt > 3) {
			alert('최대 3개까지 선택 가능합니다.');
		} else{
			$('form').submit();
		}
	}
</script>
</html>