<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>정비업체 지도</title>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=253dd4f3250d0399b6c6cd73a5596951"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<h1>정비업체 지도</h1>
	<div id="map" style="width:100%; height:800px;"></div>
	<script>
	window.onload = function() {
	    var mapContainer = document.getElementById('map');
	    var mapOption = {
	        center: new kakao.maps.LatLng(36.5, 127.5), // 대한민국 중심
	        level: 13
	    };

	    var map = new kakao.maps.Map(mapContainer, mapOption);

	    // ⭐ Ajax로 업체 데이터 불러오기
	    $.ajax({
	        url: '/api/repairShops', // API 주소
	        method: 'GET',
	        success: function(data) {
	            console.log(data); // 데이터 먼저 콘솔로 찍어보자

	            // ⭐ data 배열을 순회하면서 마커 찍기
	            data.forEach(function(shop) {
	                var marker = new kakao.maps.Marker({
	                    map: map,
	                    position: new kakao.maps.LatLng(shop.latitude, shop.longitude),
	                    title: shop.name  // 마커 타이틀
	                });
	            });
	        },
	        error: function(xhr, status, error) {
	            console.error('업체 정보 불러오기 실패', error);
	        }
	    });
	}
	</script>
</body>
</html>
