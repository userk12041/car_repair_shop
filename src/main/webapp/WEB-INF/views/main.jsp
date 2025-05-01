<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<%@ include file="/WEB-INF/views/header/header.jsp" %>
<meta charset="UTF-8">
<title>KH 전국 자동차 정비업체정보</title>

<!-- Kakao Maps API & jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=253dd4f3250d0399b6c6cd73a5596951&libraries=clusterer"></script>

<style>
body, html {
  margin: 0; padding: 0; height: 100%;
  font-family: 'Orbitron', 'Noto Sans KR', sans-serif;
  background: var(--bg-main);
  color: var(--text-main);
  overflow: hidden;
  position: relative;
}
.container { display: flex; height: 100vh; z-index: 4; }
.list-panel { width: 30%; overflow-y: auto; background: var(--card-bg); padding: 20px; box-sizing: border-box; border-right: 1px solid var(--card-border); }
.map-panel { width: 70%; background: transparent; position: relative; }
.shop-card { 
  background: var(--card-bg); border: 1px solid var(--card-border); border-radius: 10px;
  padding: 15px; margin-bottom: 15px; transition: 0.3s; cursor: pointer;
}
.shop-card:hover { background-color: var(--card-border); color: var(--bg-main); transform: translateY(-5px) scale(1.02); }
.shop-card h3, .shop-card p { margin: 0; font-size: 16px; }
</style>
</head>

<body>
<div class="container">
  <div class="list-panel" id="shopList">
    <h2>전국 자동차 정비업체</h2>
	<input type="text" id="searchKeyword" placeholder="업체명을 입력하세요" style="width:100%; padding:8px; margin-bottom:10px;">
	<button onclick="searchShops()" style="width:100%; padding:8px;">검색</button>
  </div>

  <div class="map-panel">
    <div id="map" style="width:100%; height:100%;"></div>
  </div>
</div>

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

	    // ⭐ 지도 이동하거나 확대/축소할 때마다 호출
	kakao.maps.event.addListener(map, 'idle', function() {
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
	function searchShops() {
	    var keyword = $('#searchKeyword').val().trim();
	    if (!keyword) {
	        loadMarkers(); // 검색어 없으면 전체 로딩
	        return;
	    }

	    // 기존 마커/리스트 초기화
	    clusterer.clear();
	    $('#shopList').html(
	        '<h2 style="text-align:center;">전국 자동차 정비업체</h2>' +
	        '<input type="text" id="searchKeyword" placeholder="업체명을 입력하세요" style="width:100%; padding:8px; margin-bottom:10px;">' +
	        '<button onclick="searchShops()" style="width:100%; padding:8px;">검색</button>'
	    );

	    // AJAX 검색
	    $.ajax({
	        url: "/api/repairShops/search?keyword=" + encodeURIComponent(keyword),
	        method: 'GET',
	        success: function(data) {
	            const limitedData = data.slice(0, 500); // 검색 결과 제한

	            const newMarkers = limitedData.map(shop => {
	                // 리스트에 추가 (템플릿 리터럴 X, JSP 충돌 방지)
	                $('#shopList').append(
	                    '<div class="shop-card">' +
	                        '<h3>' + escapeHtml(shop.name) + '</h3>' +
	                        '<p>' + escapeHtml(shop.road_address) + '</p>' +
	                    '</div>'
	                );

	                // 마커/인포윈도우 생성
	                const content =
	                    '<div style="display:inline-block; padding:8px; font-size:13px; max-width:300px; background:#fff; border:1px solid #888;">' +
	                        '<strong>' + escapeHtml(shop.name) + '</strong><br/>' +
	                        escapeHtml(shop.road_address) + '<br/>' +
	                        '<a href="/repairShop/view?id=' + shop.id + '" style="float:right; margin-top:5px; padding:5px 10px; background:#4CAF50; color:#fff; text-decoration:none; border-radius:4px; font-size:12px;">상세보기</a>' +
	                    '</div>';

	                const infowindow = new kakao.maps.InfoWindow({ content });

	                const marker = new kakao.maps.Marker({
	                    position: new kakao.maps.LatLng(shop.latitude, shop.longitude),
	                    title: shop.name
	                });

	                kakao.maps.event.addListener(marker, 'click', function () {
	                    if (currentInfoWindow) currentInfoWindow.close();
	                    infowindow.open(map, marker);
	                    currentInfoWindow = infowindow;
	                });

	                return marker;
	            });

	            // 지도에 마커 추가
	            clusterer.addMarkers(newMarkers);
	        },
	        error: function() {
	            alert('검색 실패');
	        }
	    });
	}
	</script>

</body>
</html>
