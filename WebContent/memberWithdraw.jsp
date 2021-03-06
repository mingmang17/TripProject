<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- c태그 사용위해 불러옴 -->
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>마이 페이지- 회원탈퇴 안내</title>
<link rel="icon" href="south-korea.png">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
body {
	min-width: 1300px;
	font-family: "NanumGothic"; 
}


/*콘텐츠*/
#content {
	height: 600px;

	text-align: center;
	float: left;
	width: 80%;
}

table, tr, td {
	/* border: 1px solid lightgray; */
	border-collapse: collapse;
	text-align: center;
	padding: 20px;
}

span {
	position: relative;
	top: 50px;
	font-weight: 600;
	color: dimgrey;
}

table#pwChk {
	background-color: white;
	position: relative;
	top: 80px;
	margin: 0 auto;
	width: 600px;
}

input[type="password"] {
	width: 80%;
	height: 30px;
}

</style>

</head>

<body>

	 <jsp:include page="top.jsp" />
	<jsp:include page="navi.jsp" />
<jsp:include page="myLeft.jsp" />

	<div id="content">
		<span>탈퇴안내</span> <br />
		
				<form action="memberWithdraw" method="post">
			<table id="pwChk">
				<tr  style="border-top:1px solid #D8D8D8;">
					<th>비밀번호 확인</th>
					<td><input type="password" name="userPw" id="confirmPw"></td>
				</tr>
				<tr >
					<th colspan="2" >
					<br/>
						✓ 사용하고 계신 아이디는 탈퇴 할 경우 재사용이 불가능합니다.<br/><br/>
						✓ 게시판형 서비스에 남아있는 글은 탈퇴 후 삭제가 불가능합니다.<br/>
						<br/> 
					</th>
				</tr>
				<tr  style="border-top:1px solid #D8D8D8;">
					<td colspan="2" style="border: none">
					<input type="button" value="탈퇴하기" id="withdraw"></td>
					
				</tr>
			</table>
			</form>
	</div>

</body>
<script>
var msg = "${msg}"; 
if (msg != "") {  
	alert(msg); 
}
/*카테고리 이벤트*/
$("li").hover(function () {
    $(this).toggleClass("li");
});
$("li").click(function(){
    $(this).css({"background-color":"#E6E6E6","font-weight": "600"});
});

$(".menu").hover(function () {
    $(this).toggleClass("menuHover");
});
$(".menu").click(function () {
    $(this).css({ "background-color": "#F5D0A9", "font-weight": "600" });
})

	 var $confirmPw = $("#confirmPw");

 
/*비밀번호 유효성 검사+ y/n confirm*/

 $("#withdraw").click(function(){
	 if($confirmPw.val()==""){
	 	alert("비밀번호를 입력해주세요");
	 }else{
		 if(confirm("정말로 탈퇴하시겠습니까?")){
		 $("form").submit();
			}else{
				location.href="/profile";
			}
	 }
	 
 });
</script>

</html>