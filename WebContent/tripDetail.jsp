<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

	<!-- e91061f69df1685996656f06dcd9860e  -->

<html>
    <head>
        <meta charset='utf-8'>
        <title>상세보기</title>
        <script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e91061f69df1685996656f06dcd9860e"></script>
        <style>
            table,td,th{
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px 10px;
                text-align: center;
            }
            table{
                width: 100%;
               
            }
            #page{                
                width: 800px;
                border: 0px;
                text-align: center;
            }
            button{
                margin: 5px;
            }
            img{
	            width: 100%;
	            height: 300px
            }
            .color{
            	background-color: lightcoral;
            }
            #fav,#vis{
            	cursor: pointer;
            	font-size: 10pt;
            }
            #fav:hover,#vis:hover {
				font-size: 12pt;
			}
        </style>
    </head>
    <body>
    <c:if test="${detail.deactivate ne 'FALSE' }">
    <script>alert("삭제되거나 없는 페이지 입니다."); location.href="./index.jsp";</script>
    </c:if>
    <c:if test="${detail.deactivate eq 'FALSE' }">
        <fieldset id="page">
            <table>
                <tr>
                    <th rowspan="2">${detail.title }</th>
                    <th class="color">등록일</th>
                    <th class="color">즐겨찾기</th>
                    <th class="color">즐겨찾기수</th>
                    <th class="color">가봤어요</th>
                </tr>
                <tr>
                    <td>${detail.reg_date }</td>
                    <td>
	                    <span id="fav">
		                    <c:if test="${book.deactivate eq null }">
								♡
		                    </c:if>
		                    <c:if test="${book.deactivate eq 'TRUE' }">
								♡
		                    </c:if>
		                    <c:if test="${book.deactivate eq 'FALSE' }">
								♥
		                    </c:if>
	                    </span>
                    </td>                    
                    <td id="favN">${detail.bookmark }</td>
                    
                    <td>
	                    <span id="vis">
		                    <c:if test="${visit.deactivate eq null }">
								☆
		                    </c:if>
		                    <c:if test="${visit.deactivate eq 'TRUE' }">
								☆
		                    </c:if>
		                    <c:if test="${visit.deactivate eq 'FALSE' }">
								★ 
		                    </c:if>
	                    </span>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <div style="text-align: left;">
                            <span>지역</span><h3>${detail.area }</h3>
                        </div>
                        <img src="${detail.firstImage }"/>
                        <br/><br/><br/><br/>
                        <div style="text-align: left;">
                        	${detail.overview }
                        </div>
                        <br/><br/><br/>
                        <div id="map" style="width:100%;height:350px;"></div>

                    </td>
                </tr>
            </table>
            <button onclick=top.window.close()>창닫기</button>
        </fieldset>
    </c:if>
    </body>
    <script>
        $('#fav').click(function(){
        	if( ${sessionScope.loginId !=null }){
        		var deact = "${book.deactivate}";
        		if(deact=="FALSE"){
        			deact="TRUE";
        		}else{
        			deact="FALSE";
        		}
				location.href='./bookmarkUpdate?myidx=${book.myidx }&deact='+deact+'&conIdx=${conIdx }&type=1';        		
        	}else{
        		alert("로그인 후 가능한 서비스입니다.");
        		opener.location.href="./login.jsp";
        	}
        });
        
        $('#vis').click(function(){
        	if( ${sessionScope.loginId !=null }){
        		var deact = "${visit.deactivate}";
        		if(deact=="FALSE"){
        			deact="TRUE";
        		}else{
        			deact="FALSE";
        		}
				location.href='./bookmarkUpdate?myidx=${visit.myidx }&deact='+deact+'&conIdx=${conIdx }&type=2';
        	}else{
        		alert("로그인 후 가능한 서비스입니다.");
        		opener.location.href="./login.jsp";
        	}
        	});
        
        
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(${detail.latitude}, ${detail.longitude}  ), // 지도의 중심좌표
	        level: 2 // 지도의 확대 레벨
	    };
	
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(${detail.latitude}, ${detail.longitude}); 
		
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
		// marker.setMap(null);    
    </script>
</html>