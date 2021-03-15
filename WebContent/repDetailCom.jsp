<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
			table,th,td{
				width : 100%;
				border: 1px solid black;
				border-collapse: collapse;
				
			}
			th,td{
				width: 150px;
			}
			fieldset,p{			
				margin : 10px;
				box-sizing : 100%;
				text-align: left;
			}
			div{			
				width:500px;
			}
			button {
				margin-top : 10px;
			}
			#btn{
				
			}
			#comment{
				margin-top : 20px;
				width: 600px;
			}	
			#comment th{
				width: 150px;
			}
			#body{
				width: 800px;
				border: 1px solid black;
			}
		</style>
	</head>
	<body>	
		<jsp:include page="top.jsp" />
		<jsp:include page="navi_manager.jsp"/>
		<div>
			<ol style="float: left; margin-right: 50px;">
				<ul><a href="./reportBBS">게시글 신고 내역</a></ul>
				<ul><a href="./reportComment">댓글 신고 내역</a></ul>
			</ol>
		</div>
		<div id="body">
			<table>
				<tr>
					<th>제목</th>
					<td>${dto.subject}</td>>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3">${dto.content}</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="3">
						<img src="photo/${dto.newFileName}" alt="${dto.oriFileName}" width="500px"/>
					</td>
				</tr>
			</table>
			<div id="comment">
				<c:forEach items="${list }" var="com">
					<table>
						<tr>
							<th>${com.id }</th>
							<td>${com.content }</td>
							<td>${com.reg_date }</td>
							<c:if test="${com.reIdx eq reIdx}">
								<td>신고수 / ${repCnt }</td>
								<td>
									블라인드 					
									<select id="YN">
										<option  value="TRUE" ${reason.deactivate eq 'TRUE' ? 'selected="selected"' : '' }>Y</option>
										<option value="FALSE" ${reason.deactivate eq 'FALSE' ? 'selected="selected"' : '' }>N</option>
									</select>
								</td>
						</tr>
						<tr>
							<td colspan="5" style="border: 1px solid white;">
								<fieldset>
									<p>
										신고 사유 
										<br/><br/>
									<b>${reason.reason }</b>
								</fieldset>
							</td>
						</tr>
						</c:if>
					</table>
				</c:forEach>
			</div>
			<div id=#btn>
				<input type="button"  onclick="location.href='./reportComment'" value="목록"/>		
				&nbsp;&nbsp;&nbsp;
				<button id="btn"> 적용 </button>
			</div>
		</div>
	</body>
	<script>
		$("#btn").click(function () {
			var reIdx ="${reIdx}";
			var commentRepIdx="${commentRepIdx }";
			console.log($("#YN").val());
			$.ajax({
				type:"get"
				,url:"updateYN"
				,data:{
					"updateYN":$("#YN").val()
					,"boardIdx":reIdx
					,"bbsRepIdx":commentRepIdx
					,"type":'2'
				}
				,dataType:"json"
				,success: function(data) {
					console.log(data.suc);
					if(data.suc>0){
						location.href="./reportComment";
					}
				}
				,error: function(e) {
					console.log(e);
				}
			});
		});	
	
	
	</script>
</html>