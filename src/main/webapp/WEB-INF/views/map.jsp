<!--<%@ page contentType="text/html;charset=UTF-8" language="java" %>-->
<html>
<head>
	<%@ include file="/WEB-INF/views/header/header.jsp" %>
	
    <title>정비업체 지도</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>	
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=253dd4f3250d0399b6c6cd73a5596951&libraries=clusterer"></script>
</head>
<body>
	<h1>정비업체 지도</h1>
	<div id="map" style="width:100%; height:800px;"></div>
	
	<script>
	var map;
	var clusterer;
	var markers = [];
	var currentInfoWindow = null;
		
	window.onload = function() {
	    var mapContainer = document.getElementById('map');
	    var mapOption = {
	        center: new kakao.maps.LatLng(36.5, 127.5), // 대한민국 중심
	        level: 13
	    };

	    map = new kakao.maps.Map(mapContainer, mapOption);
		
		clusterer = new kakao.maps.MarkerClusterer({
		    map: map,
		    averageCenter: true, // 클러스터 중심좌표 설정
		    minLevel: 10 // 클러스터 할 최소 지도 레벨
		});

		    // ⭐ 지도 이  동하거나 확대/축소할 때마다 호출
		kakao.maps.event.addListener( map, 'idle', function() {
		        loadMarkers();
		    });

		    loadMarkers(); // 처음에도 마커 불러오기
		}
		
		function escapeHtml(text) {
		    if (!text) return "";
		    return text
		        .replace(/&/g, "&amp;")
		        .replace(/</g, "&lt;")
		        .replace(/>/g, "&gt;");
		}
		
		function loadMarkers() {
		    var bounds = map.getBounds();
		    var sw = bounds.getSouthWest();
		    var ne = bounds.getNorthEast();

		    var swLat = sw.getLat();
		    var swLng = sw.getLng();
		    var neLat = ne.getLat();
		    var neLng = ne.getLng();

		    // 기존 마커 지우기
		    clusterer.clear();

		    // AJAX 호출
		    $.ajax({
		        url: `/api/repairShops?swLat=${swLat}&swLng=${swLng}&neLat=${neLat}&neLng=${neLng}`,
		        method: 'GET',
		        success: function(data) {
					console.log("받은 데이터:", data);
		            var limitedData = data.slice(0, 2000); // 최대 500개 제한

					var newMarkers = limitedData.map(function(shop) {
						var content = '<div style="display:inline-block; padding:8px; font-size:13px; max-width:300px; background:#fff; border:1px solid #888; white-space:normal; word-break:break-word;">' +
						              '<strong>' + escapeHtml(shop.name) + '</strong><br/>' +
						              escapeHtml(shop.road_address) + '<br/>' +
									  '<a href="/repairShop/view?id=' +shop.id+' " style="float:right; display:inline-block; margin-top:5px; padding:5px 10px; background:#4CAF50; color:#fff; text-decoration:none; border-radius:4px; font-size:12px;">상세보기</a>'
									  +
						              '</div>';

						var infowindow = new kakao.maps.InfoWindow({
						    content: content
						});

						var marker = new kakao.maps.Marker({
						    position: new kakao.maps.LatLng(shop.latitude, shop.longitude),
						    title: shop.name
						});

						kakao.maps.event.addListener(marker, 'click', function() {
						    if (currentInfoWindow) {
						        currentInfoWindow.close();
						    }
						    infowindow.open(map, marker);
						    currentInfoWindow = infowindow;
						});

					    return marker;
					});
		            clusterer.addMarkers(newMarkers);
		        },
		        error: function(xhr, status, error) {
		            console.error('업체 정보 불러오기 실패', error);
		        }
		    });
		}
		</script>
</body>
</html>
