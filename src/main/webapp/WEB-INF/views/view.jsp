<!--<%@ page contentType="text/html;charset=UTF-8" language="java" %>-->
<html>
<head>
	<%@ include file="/WEB-INF/views/header/header.jsp" %>
	
    <title>업체 상세정보</title>
	<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=253dd4f3250d0399b6c6cd73a5596951&libraries=clusterer"></script>
	
	<style>
		body {
		    font-family: 'Noto Sans KR', sans-serif;
		    margin: 20px;
		    background-color: #fafafa;
		}
	    table {

	    }
		#shopMap {
		    width: 100%;
		    height: 500px;
		    border: 1px solid #ccc;
		    border-radius: 8px;
		    margin-top: 20px;
		}
		
		<!--.info-review-box {
		    display: flex;
		    flex-direction: row;
		    justify-content: flex-start;
		    align-items: flex-start;
		}-->
		.info-box {
			width: 45%;
			border-collapse: collapse;
			margin-top: 20px;
		    flex: 1;
		    display: flex;
		    flex-flow: row wrap;
		    justify-content: flex-start;
		    background: #f1f5f9;
		    padding: 16px;
		    border-radius: 20px;
		}
		.info-box tr {
		    flex-direction: row;
		    justify-content: center;
		    align-items: center;
		    min-width: 520px;
		    padding: 10px 0;
		}
		.info-box th {
			background-color: #f7f7f7;
	        text-align: center;
	        padding: 10px;
	        width: 25%;
		}
		.info-box td {
		    padding: 10px;
		}
		.info-box caption{
			caption-side: top;          
			width: 100%;                /* 테이블 전체 너비로 확장 */
			text-align: center;         /* 가운데 정렬 */
			font-size: 24px;            
			font-weight: bold;          
			padding: 10px 0;            
		}
		
	</style>
	
</head>
<body>
	<div id="shopMap"></div>
	
    <table class="info-box">
    <caption>업체 상세 정보</caption>
        <tr><th>업체명</th><td>${shop.name}</td></tr>
        <tr><th>도로주소</th><td>${shop.road_address}</td></tr>
        <tr><th>지번주소</th><td>${shop.lot_address}</td></tr>
        <tr><th>등록일자</th><td>${shop.registration_date}</td></tr>
        <tr><th>오픈시간</th><td>${shop.open_time}</td></tr>
        <tr><th>마감시간</th><td>${shop.close_time}</td></tr>
        <tr><th>전화번호</th><td>${shop.tel_number}</td></tr>
    </table>


	<script>
	    var container = document.getElementById('shopMap');
	    var options = {
	        center: new kakao.maps.LatLng(${shop.latitude}, ${shop.longitude}),
	        level: 3
	    };

	    var map = new kakao.maps.Map(container, options);

	    var marker = new kakao.maps.Marker({
	        position: new kakao.maps.LatLng(${shop.latitude}, ${shop.longitude}),
	        map: map,
	        title: '${shop.name}'
	    });
	</script>
	
    <br/>
</body>
</html>