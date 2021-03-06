<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반 회원정보 상세보기</title>
<style>
#mdetail{
	/* width: 1300px; */
	width : 60%;
	height : 300px;
	float: right;
	margin-right: 10%;
	margin-top : 4%;
}

.memberList_de {
	border-collapse: collapse;
	margin-top: 60px;
	width : 102%;
}

.memberList_de th, td {
	border: 1px solid lightgray;
	text-align: center;
	font-size: 13px;
	padding: 8px;
}

.memberList_de th{
	background-color: gray;
	color : white;
}

#caption{
	font-weight: 600;
}

.black {
	width: 250px;
	margin: auto;
	padding-top: 65px;
}

.mbtn{
	font-size: 13px;
	padding: 6px 15px;
	margin: 6px 0;
}

.genmem{
	background-color: lightgray;
	font-weight: bold;
}

</style>

</head>
<body>
	<!--상단페이지-->
	<jsp:include page="top.jsp" />

	<!--상단네비-->
	<jsp:include page="navi_manager.jsp" />

	<!-- 사이드 네비&검색필터 -->
	<jsp:include page="side_manager.jsp" />


	<div id="mdetail">
		<table class="memberList_de">
			<h5>일반 회원</h5>
			  <h3 id="caption">[${dto.id}] 님의 상세 정보</h3>
			  <hr/>
	           <tr>
                <th>가입일</th>
                <th>아이디</th>
                <th>이름</th>
                <th>핸드폰</th>
                <th>이메일</th>
                <th>탈퇴여부</th>
                <th>수정일</th>
                <th>글,댓글 신고수</th>
                <th>블랙리스트로 등록된 횟수</th>
                <th>블랙리스트 상태</th>
            </tr>
            <tr>
                <td>${dto.reg_date}</td>
                <td>${dto.id}</td>
                <td>${dto.name}</td>
                <td>${dto.phone}</td>
                <td>${dto.email}</td>
                <td>${dto.withdraw}</td>
                <td>${dto.update_date}</td>
                <td>${dto.reportcnt}</td>
                <td>${dto.blackcnt}</td>
                <td>${dto.blackstatus}</td>
            </tr>
		</table>
		<div class="black">
			<button class="mbtn" onclick="location.href='./memberBlackAddForm?id=${dto.id}'">블랙리스트 추가</button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button class="mbtn" onclick="location.href='./memberList'">닫기</button>
		</div>
	</div>
</body>
<script>
	var msg = "${msg}";
	if (msg != "") {
		alert(msg);
	}
	
	
</script>
</html>