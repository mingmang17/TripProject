<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행지 추가</title>
<script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<style>
/* table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	padding: 10px 20px;
	text-align: center;
	margin-left: auto;
	margin-right: auto;
	margin-top: 30px;
}

.regDate {
	width: 80px;
}

.pageArea {
	width: 100%;
	text-align: center;
	margin: 10px;
}

.pageArea span {
	font-size: 16px;
	border: 1px solid lightgray;
	padding: 2px 10px;
	color: gray;
}

#page {
	font-weight: 600;
	color: red;
}

#tripSearchBar {
	text-align: center;
}

div.tripManageList {
	position: absolute;
	top: 20%;
}

div.tripManageName {
	padding: 5px 15px;
	border: 1px solid black;
	width: 120px;
	height: 30px;
	text-align: center;
}

*/

.tripAdd{
	background-color: lightgray;
}
</style>
</head>
<body>
	<jsp:include page="top.jsp" />
	<jsp:include page="navi_manager.jsp" />

	<jsp:include page="side_tripList.jsp"/>

	<div  class="tripBody">
		<form name="form">
			<table  class="midBody">
				<tr>
					<th>관리자 아이디</th>
					<td><input type="text" id="managerId"
						value="${sessionScope.loginId}" readonly /></td>
				</tr>
				<tr>
					<th>contentId</th>
					<td>
						<input type="number" id="contentId" min="1" placeholder="1 이상의 숫자" /> 
						<input type="button" id="overlay" value="contentId 체크" />
					</td>
				</tr>
				<tr>
					<th>이미지 URL</th>
					<td>
						<input type="text" id="firstImage" placeholder="이미지 URL" />
						</br>
						<img id="img" />
					</td>
				</tr>
				<tr>
					<th>위도</th>
					<td><input type="text" id="latitude"
						placeholder="37.123456789" /></td>
				</tr>
				<tr>
					<th>경도</th>
					<td><input type="text" id="longitude"
						placeholder="127.123456789" /></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" id="address" placeholder="상세주소" />
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" id="title" placeholder="여행지 이름" /></td>
				</tr>
				<tr>
					<th>콘텐츠 타입</th>
					<td><select class="select" id="contentType" name="contentType"
						onchange='largeList(value)'>
							<option value="">선택</option>
							<c:forEach items="${contentList}" var="content">
								<option value="${content.contentCode}">${content.name}(${content.contentCode})</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<th>대분류</th>
					<td><select class="select"  id="large" name="largeType"
						onchange='mediumList(value)'>
							<option value="">대분류</option>
					</select></td>
				</tr>
				<tr>
					<th>중분류</th>
					<td><select class="select" id="medium" name="mediumType"
						onchange='smallList(value)'>
							<option value="">중분류</option>
					</select></td>
				</tr>
				<tr>
					<th>소분류</th>
					<td><select class="select" id="small" name="smallType">
							<option value="">소분류</option>
					</select></td>
				</tr>
				<tr>
					<th>지역</th>
					<td><select class="select" id="area" name="areaType"
						onchange='cityList(value)'>
							<option value="">지역</option>
							<c:forEach items="${areaList}" var="area">
								<option value="${area.areaCode}">${area.name}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<th>시군구</th>
					<td><select class="select" id="city" name="cityType">
							<option value="">시/군/구</option>
					</select></td>
				</tr>
				<tr>
					<th>상세설명</th>
					<td><textarea id="overview"></textarea></td>
				</tr>
				<tr>
					<td colspan="2"class="button">
						<div>
							<input type="button" id="btn" value="저장"/>
							<input type="button"  onclick="location.href='./tripManageList'" value="목록보기"/>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
<script>
	$(document).ready(function() {
		$("div#"+${tripNav}).css({"background-color" : "lightgray","font-weight":'600'});
	});
	
	$('a').hover(function(){
		   $(this).css({'font-weight':'600'});
	},function(){
		    $(this).css({'font-weight':'1'});
	});
	
	$('#firstImage').keyup(function(){
			var imgSource = $(this).val();
			$('#img').attr('src',imgSource);
            $('#img').attr('width', "100px");
            $('#img').attr('height', "100px");
	});
	
	
	function largeList(type) {
		var text = [];
		var value = [];
		<c:forEach items="${largeList}" var="large">
		if ('${large.contentCode}' == type) {
			text.push('${large.name}');
			value.push('${large.largeIdx}');
		}
		</c:forEach>

		$('#large').find("option").remove();
		$('#medium').find("option").remove();
		$('#small').find("option").remove();
		form.largeType.options[0] = new Option("대분류", "");
		form.mediumType.options[0] = new Option("중분류", "");
		form.smallType.options[0] = new Option("소분류", "");
		for (var i = 0; i < text.length; i++) {
			form.largeType.options[i + 1] = new Option(text[i], value[i]);
		}
	};

	function mediumList(type) {
		var text = [];
		var value = [];
		
		<c:forEach items="${mediumList}" var="medium">
		if ('${medium.largeIdx}' == type) {
			text.push('${medium.name}');
			value.push('${medium.mediumCode}');
		}
		</c:forEach>

		$('#medium').find("option").remove();
		$('#small').find("option").remove();
		form.mediumType.options[0] = new Option("중분류", "");
		form.smallType.options[0] = new Option("소분류", "");
		for (var i = 0; i < text.length; i++) {
			form.mediumType.options[i + 1] = new Option(text[i], value[i]);
		}
	};
	function smallList(type) {
		var text = [];
		var value = [];

		<c:forEach items="${smallList}" var="small">
		if ('${small.mediumCode}' == type) {
			text.push('${small.name}');
			value.push('${small.smallCode}');
		}
		</c:forEach>

		$('#small').find("option").remove();
		form.smallType.options[0] = new Option("소분류", "");
		for (var i = 0; i < text.length; i++) {
			form.smallType.options[i+1] = new Option(text[i], value[i]);
		}
	};
	
	function cityList(type) {
		var text = [];
		var value = [];
		
		<c:forEach items="${cityList}" var="city">
		if ('${city.areaCode}' == type) {
			text.push('${city.name}');
			value.push('${city.cityCode}');
		}
		</c:forEach>
		$('#city').find("option").remove();
 		form.cityType.options[0] = new Option("시/군/구", "");
		for (var i = 0; i < text.length; i++) {
			form.cityType.options[i+1] = new Option(text[i], value[i]);
		}
	};
	
	var overChk = false;
	var contentId = "";
	$("#overlay").click(function() {
		var $contentId = $("#contentId");
		if($contentId.val() == '') {
			alert("contentId를 입력해 주세요.");
		} else if($contentId.val() >= 1000000000){
			alert("10억 미만의 숫자를 입력해 주세요.")
		} else {
		$.ajax({
			type : 'get',
			url : 'tripInsertOverlay',
			data : {
				"contentId" : $contentId.val()
			},
			dataType : 'JSON',
			success : function(obj) {
				console.log(obj);
				if (obj.use) {
					alert('추가할 수 있는 ContentId입니다.');
					overChk = true;
					contentId = obj.contentId;
				} else {
					alert('이미 존재하는 ContentId입니다.');
					$contentId.val('');
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
		}
	});

	$('#btn').click(function() {
		var $managerId = $("#managerId");
		var $contentId = $("#contentId");
		var $firstImage = $("#firstImage");
		var $latitude = $("#latitude");
		var $longitude = $("#longitude");
		var $address = $("#address");
		var $title = $("#title");
		var $contentType = $("#contentType");
		var $large = $("#large");
		var $medium = $("#medium");
		var $small = $("#small");
		var $area = $("#area");
		var $city = $("#city");
		var $overview = $("#overview");
	
		if($contentId.val() != contentId) {
			overChk = false;
		}
		
		if (overChk) {
			if ($contentId.val() == '') {
				alert('Content ID를 입력해 주세요.');
				$contentId.focus();
			} else if ($firstImage.val() == '') {
				alert('firstImage 를 입력해 주세요.');
				$firstImage.focus();
			} else if ($latitude.val() == '') {
				alert('latitude를 입력해 주세요.');
				$latitude.focus();
			} else if ($longitude.val() == '') {
				alert('longitude를 입력해 주세요.');
				$longitude.focus();
			} else if ($address.val() == '') {
				alert('주소를 입력해 주세요.');
				$address.focus();
			} else if ($title.val() == '') {
				alert('제목을 입력해 주세요.');
				$title.focus();
			} else if ($contentType.val() == '') {
				alert('콘텐츠 타입을 선택해 주세요.');
				$contentType.focus();
			} else if ($large.val() == '') {
				alert('대분류를 선택해 주세요.');
				$large.focus();
			} else if ($medium.val() == '') {
				alert('중분류를 선택해 주세요.');
				$medium.focus();
			} else if ($small.val() == '') {
				alert('소분류를 선택해 주세요.');
				$small.focus();
			} else if ($area.val() == '') {
				alert('지역을 선택해 주세요.');
				$area.focus();
			} else if ($city.val() == '') {
				alert('시/군/구를 선택해 주세요.');
				$city.focus();
			} else if ($overview.val() == '') {
				alert('상세설명을 입력해 주세요.');
				$overview.focus();
			} else {
				var params = {};
				params.managerId = $managerId.val();
				params.contentId = $contentId.val();
				params.firstImage = $firstImage.val();
				params.latitude = $latitude.val();
				params.longitude = $longitude.val();
				params.address = $address.val();
				params.title = $title.val();
				params.contentType = $contentType.val();
				params.large = $large.val();
				params.medium = $medium.val();
				params.small = $small.val();
				params.area = $area.val();
				params.city = $city.val();
				params.overview = $overview.val();

				$.ajax({
					type : 'GET',
					url : 'tripInsert',
					data : params,
					dataType : 'JSON',
					success : function(data) {
						if (data.contentId > 0) {
							alert('여행지를 추가했습니다.');
							location.href = "./tripManageDetail?contentId="+data.contentId+"&page=1";
						} else {
							alert('잠시 후 다시 시도해 주세요.');
						}
					},
					error : function(e) {
						console.log(e);
					}
				});
			}
		} else {
			alert('contentID 중복체크를 해주세요.');
			$contentId.focus();
		}

	});
</script>
</html>