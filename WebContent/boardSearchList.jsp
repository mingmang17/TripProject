<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
    	<meta name="viewport" content="width=device",initial-scale="1">
        <meta charset="utf-8">
        <title>커뮤니티</title>
        <script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
        <link rel="icon" href="south-korea.png">
        <style>
            table,th,td{
                border:1px solid black;
                border-collapse: collapse;
                text-align: center;
            }
            th,td{
            	padding:5px 10px;
            }
            table{
				margin-top:10px;
				margin-left:40px;
				width:1000px
              
            }
            #comm_select{
                width: 100px;
                height: 50px;
                font-size: 14px;
                font-weight: 600;
                font-size: 18px;
            }
            #boardkeyword{
                width: 400px;
                height: 45px;
                font-size: 18px;
                font-weight: 600;
            }
            #boardSearch{
                width: 100px;
                height: 50px;
                
                font-size: 18px;
                font-weight: 600;
            }
            #write{
                width: 100px;
                height: 50px;
                position:relative;
                left:26%;             
                font-size: 18px;
                font-weight: 600;
            }
            .pageArea{
            	margin-top:10px;
            	text-align:center;
            
            }
            .pageArea span{
				font-size : 16px;
				border:1px solid lightgray;
				padding: 2px 10px;
				margin:2px
			}
			#field{
				margin-left:15%;
				text-align:center;
				width:1200px;			
			}
			.mouse_over:hover{
				font-weight: 600;
			}
        </style>

    </head>
    <body>
    <jsp:include page="top.jsp" />
	<jsp:include page="navi.jsp" />
	
    <div id="field">
    <select id="comm_select" name="comm_select">
        <option value="subject">제목</option>
        <option value="id">작성자</option>
        <option value="content">내용</option>
    </select>
    <input type="text" id="boardkeyword"/>
    <button id="boardSearch">검색</button>
    <table>
		<tr>
			<th style="width:60px">글 번호</th>
			<th>제목</th>
			<th style="width:120px">작성자</th>
			<th style="width:60px">조회수</th>
			<th style="width:100px">작성날짜</th>
		</tr>
		<c:if test="${managerbbsList ne null}">
		<c:forEach items="${managerbbsList}" var="managerbbs">
			<tr style="background-color: lightgray">
				<td>${managerbbs.boardIdx}</td>
				<td><a class="mouse_over" href="boardDetail?boardIdx=${managerbbs.boardIdx}&page=${currPage}">${managerbbs.subject}</a></td>
				<td>${managerbbs.id}</td>
				<td>${managerbbs.bHit}</td>
				<td>${managerbbs.reg_date}</td>
			</tr>
		</c:forEach>
		</c:if>
		<c:forEach items="${list}" var="bbs">
			<tr>
				<td>${bbs.boardIdx}</td>
				<td><a class="mouse_over" href="boardDetail?${url}&boardIdx=${bbs.boardIdx}&page=${currPage}">${bbs.subject}</a></td>
				<td>${bbs.id}</td>
				<td>${bbs.bHit}</td>
				<td>${bbs.reg_date}</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pageArea">
		<span>
			<c:if test="${currPage==1}">이전</c:if>
			<c:if test="${currPage>1}">
				<a class="mouse_over" href='./boardSearch?${url}&page=${currPage-1}'>이전</a>
			</c:if>
		</span>
		<span id="page">${currPage}</span>
		<span>
			<c:if test="${currPage == maxPage}">다음</c:if>
         	<c:if test="${currPage < maxPage}">
         		<a class="mouse_over" href="./boardSearch?${url}&page=${currPage+1}">다음</a></c:if>
		</span>
   	<button id="write" onclick="location.href='./boardwriteForm.jsp'">글쓰기</button>   
	</div>
	</div>
</body>
<script>
	$('#boardSearch').click(function(){
		var searchType = $('#comm_select').val()
		var keyword = $('#boardkeyword').val()
		location.href="./boardSearch?searchType="+searchType+"&boardkeyword="+keyword;
	});
	var msg="${msg}";
	if(msg!=""){
		alert(msg);
	}
</script>
</html>