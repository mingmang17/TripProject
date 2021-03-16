<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반 회원정보 리스트</title>

<style>
table, th,td {
	border: 1px solid lightgray;
	border-collapse: collapse;
	text-align: center;
	padding: 20px;
}

#page{
     margin-top:10px;
     text-align:center;           
}

#page span{
	font-size : 16px;
	border:1px solid lightgray;
	padding: 2px 10px;
	margin:2px
}
p{
	position: relative;
	left:18%;
}
</style>

</head>
<body>
	<!--상단페이지-->
	<jsp:include page="top.jsp" />

	<!--상단네비-->
	<jsp:include page="navi_manager.jsp" />

	<!-- 사이드 네비 -->
	<jsp:include page="side_manager.jsp" />
	
	<!-- 검색필터 -->
	<jsp:include page="search_member.jsp"/>


		<div class="memberList_main">
			<c:if test="${not empty memberSearchList}">
			<table>
				<tr>
					<th>가입일</th>
					<th>아이디</th>
					<th>이름</th>
					<th>핸드폰 번호</th>
					<th>이메일</th>
					<th></th>
				</tr>
				<c:forEach items="${memberSearchList}" var="member">
					<tr>
						<td>${member.reg_date}</td>
						<td>${member.id}</td>
						<td>${member.name}</td>
						<td>${member.phone}</td>
						<td>${member.email}</td>
						<td><a href="memberDetail?id=${member.id}">상세보기</a></td>
					</tr>
				</c:forEach>
			</table>
			</c:if>
			<c:if test="${empty memberSearchList}">
				<p>해당 회원이 없습니다.</p>
			</c:if>
		</div>
		
		<div id="page">
			<span>
				<c:if test="${currPage==1}">이전</c:if>
				<c:if test="${currPage>1}">
					<a href='./memberSearch?${url}&page=${currPage-1}'>이전</a>
				</c:if>
			</span>
			<span>${currPage}</span>
			<span>
				<c:if test="${currPage == maxPage}">다음</c:if>
         		<c:if test="${currPage < maxPage}">
         			<a href="./memberSearch?${url}&page=${currPage+1}">다음</a></c:if>
			</span>		
		</div>
</body>
<script>
	var msg = "${msg}";
	if(msg!=""){
		alert(msg);
	}	
</script>
</html>