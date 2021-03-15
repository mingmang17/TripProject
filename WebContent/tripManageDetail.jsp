<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<style>
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	padding: 10px 20px;
	text-align: center;
	margin-left: auto;
	margin-right: auto;
	margin-top: 30px;
}

.regDate {
	width:80px;
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
#tripSearchBar{
	text-align: center;
}
.button {
	text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="top.jsp" />
	<jsp:include page="admin_navbar.jsp" />
	<div>
		<form name="form">
			<table>
				<tr>
					<th>관리자 아이디</th>
					<td>${tripDTO.managerId}</td>
				</tr>
				<tr>
					<th>contentId</th>
					<td>${tripDTO.contentId}</td>
				</tr>
				<tr>
					<th>이미지 경로</th>
					<td>${tripDTO.firstImage}</td>
				</tr>
				<tr>
					<th>위도</th>
					<td>${tripDTO.latitude}</td>
				</tr>
				<tr>
					<th>경도</th>
					<td>${tripDTO.longitude}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>${tripDTO.address}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${tripDTO.title}</td>
				</tr>
				<tr>
					<th>콘텐츠 타입</th>
					<td>${tripDTO.contentName }</td>
				</tr>
				<tr>
					<th>대분류</th>
					<td>${tripDTO.largeName}</td>
				</tr>
				<tr>
					<th>중분류</th>
					<td>${tripDTO.mediumName}</td>
				</tr>
				<tr>
					<th>소분류</th>
					<td>${tripDTO.smallName}</td>
				</tr>
				<tr>
					<th>지역</th>
					<td>${tripDTO.areaName }</td>
				</tr>
				<tr>
					<th>시군구</th>
					<td>${tripDTO.cityName}</td>
				</tr>
				<tr>
					<th>상세설명</th>
					<td>${tripDTO.overview}</td>
				</tr>
			</table>
		</form>
		<div class="button">
			<button onclick="location.href='./tripManageUpdateForm?contentId=${tripDTO.contentId}'">수정</button>
			<button onclick="location.href='./tripManageList'">닫기</button>
		</div>
	</div>
</body>
<script>
</script>
</html>