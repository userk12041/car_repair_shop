<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<%@ include file="/WEB-INF/views/header/header.jsp" %> 
<meta charset="UTF-8">
<title>KH 전국 자동차 정비업체정보</title>
<!-- Kakao Maps API & jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
  src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=253dd4f3250d0399b6c6cd73a5596951&libraries=clusterer"></script>
<style>
  body,
  html {
    margin: 0;
    padding: 0;
    height: 100%;
    font-family: 'Orbitron', 'Noto Sans KR', sans-serif;
    background: var(--bg-main);
    color: var(--text-main);
    overflow: hidden;
    position: relative;
  }
  .container {
    display: flex;
    height: 100vh;
    z-index: 4;
  }
  .list-panel {
    width: 30%;
	min-width: 300px;  /* 최소 너비 */
	max-width: 500px;  /* 최대 너비 */
    overflow-y: auto;
    background: var(--card-bg);
    padding: 20px;
    box-sizing: border-box;
    border-right: 1px solid var(--card-border);
  }
  .search-bar {
    display: flex;
    align-items: center;
    background: #f4f7fa;
    border-radius: 30px;
    padding: 5px 10px;
    margin-bottom: 15px;
  }
  .search-bar input {
    border: none;
    background: transparent;
    flex: 1;
    padding: 10px;
    font-size: 14px;
    outline: none;
  }
  .search-bar button {
    background: transparent;
    border: none;
    cursor: pointer;
    font-size: 18px;
    color: #333;
  }
  .map-panel {
    width: 70%;
    background: transparent;
    position: relative;
  }
  .shop-card {
    background: #ffffff;
    border: 1px solid #e0e0e0;
    border-radius: 10px;
    padding: 15px;
    margin-bottom: 15px;
    transition: all 0.3s ease;
    cursor: pointer;
    box-shadow: 0 0 0 rgba(0, 0, 0, 0);
  }
  .shop-card:hover {
    background-color: var(--card-border);
    color: var(--bg-main);
    transform: translateY(-5px) scale(1.02);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
  }
  .shop-card h3,
  .shop-card p {
    margin: 0;
    font-size: 16px;
  }
  .shop-card .bottom {
    display: flex;
    justify-content: space-between;
    margin-top: 10px;
  }

  .shop-card .left {
    font-size: 14px;
    color: #555;
  }

  .shop-card .right {
    font-size: 14px;
  }
  .bookmark-btn.styled {
    background-color: #fffbe6;
    border: 1px solid #f0c420;
    color: #d48806;
    padding: 6px 12px;
    border-radius: 20px;
    font-weight: bold;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  }

  .bookmark-btn.styled:hover {
    background-color: #fff1b8;
    border-color: #faad14;
    color: #fa8c16;
    transform: scale(1.05);
  }
  
  #sortOption {
    width: 100px;
    padding: 8px 12px;
	margin-bottom:10px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 6px;
    background-color: #f9f9f9;
    color: #333;
    cursor: pointer;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
  }

  #sortOption:hover {
    border-color: #888;
    box-shadow: 0 0 5px rgba(0,0,0,0.1);
  }

  #sortOption:focus {
    outline: none;
    border-color: #007BFF;
    box-shadow: 0 0 5px rgba(0,123,255,0.5);
  }
</style>
</head>

<body>

  <div class="container">
    <div class="list-panel" id="shopList">
    <!--  <h2 style="text-align: center;">전국 자동차 정비업체</h2>-->
<!--      <div class="search-bar">
        <input type="text" id="searchKeyword" placeholder="검색어를 입력하세요">
        <button id="searchBtn" type="button">🔍</button>
        <button id="refreshBtn" type="button">🔄</button>
      </div>-->
    </div>
    <div class="map-panel">
      <div id="map" style="width:100%; height:100%;"></div>
    </div>
  </div>
  
  <script>
    let map;
    let clusterer;
    let currentInfoWindow = null;
    let isSearchMode = false;
    let isProgrammaticMove = false;
    window.onload = function () {
      const mapContainer = document.getElementById('map');
      const mapOption = {
        center: new kakao.maps.LatLng(36.5, 127.5),
        level: 13
      };
      map = new kakao.maps.Map(mapContainer, mapOption);
      clusterer = new kakao.maps.MarkerClusterer({
        map: map,
        averageCenter: true,
        minLevel: 10
      });
      kakao.maps.event.addListener(map, 'idle', function () {
        if (isProgrammaticMove) {
          isProgrammaticMove = false;
          return;
        }
        if (!isSearchMode) {
          loadMarkers();
        }
      });
      loadMarkers();
      bindSearchEvents();
    };
    function escapeHtml(text) {
      if (!text) return "";
      return text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
    }
    function bindSearchEvents() {
      $('#searchBtn').off().on('click', loadMarkers);
      $('#searchKeyword').off().on('keydown', function (e) {
        if (e.key === 'Enter') searchShops();
      });
      $('#refreshBtn').off().on('click', function () {
        /*isSearchMode = false;*/
		$('#searchKeyword').val('');
		$('#sortOption').val('');
        loadMarkers();
      });
	  $('#sortOption').off().on('change', function() {
	    loadMarkers();
	  });
    }
    function closeInfoWindow() {
      if (currentInfoWindow) {
        currentInfoWindow.close();
      }
    }
    function loadMarkers() {
      const bounds = map.getBounds();
	  console.log(bounds.toString());
      const sw = bounds.getSouthWest();
      const ne = bounds.getNorthEast();
      const swLat = sw.getLat();
      const swLng = sw.getLng();
      const neLat = ne.getLat();
      const neLng = ne.getLng();
	  const keyword = $('#searchKeyword').val();
	  const sort = $('#sortOption').val();
      clusterer.clear();
      $('#shopList').html(`
        <h2 style="text-align:center;">전국 자동차 정비업체</h2>
        <div class="search-bar">
		  <input type="text" id="searchKeyword" value="${keyword}" placeholder="검색어를 입력하세요">
          <button id="searchBtn" type="button">🔍</button>
          <button id="refreshBtn" type="button">🔄</button>
        </div>
	  <div style="margin-top: 10px;">
		  <select id="sortOption" style="margin-left: 10px; padding: 5px;">
	         <option value="">정렬 선택</option>
	         <option value="name">이름</option>
	         <option value="view_count">조회수</option>
	         <option value="rating">평점</option>
	       </select>
	   </div>
      `);
	  $('#sortOption').val(sort);
	  $('#searchKeyword').val(keyword);
      bindSearchEvents();
	  console.log("keyword : "+keyword+" sort : "+sort);
	  const requestData = {
		swLat: swLat,
		swLng: swLng,
		neLat: neLat,
		neLng: neLng,
		sort: sort,
		keyword: keyword
	  }
      $.ajax({
        url: "/api/repairShops",
        method: 'GET',
		data: requestData,
		dataType: "json",
        success: function (data) {
		/*console.log(data);*/
          const newMarkers = [];
          const limitedData = data.slice(0, 2000);
          limitedData.forEach((shop, index) => {
            if (index < 100) {
				const isBookmarked = shop.bookmarked === true;
              $('#shopList').append(
                '<div class="shop-card" data-index="' + index + '">' +
                '<h3>' + escapeHtml(shop.name) + '</h3>' +
                '<p>' + escapeHtml(shop.road_address) + '</p>' +
				'<div class="bottom">'
				    +  '<div class="left">'
				      +  '👁️'+ (shop.view_count != null ? shop.view_count : 0) + '&nbsp;'
				      +  '⭐'+ (shop.avg_rating != null ? shop.avg_rating.toFixed(1) : '평점 없음') 
				    +  '</div>'
				   +   '<div class="right">'
				      +  '<button class="bookmark-btn styled" data-id="' + shop.id + '"					' +
					      (isBookmarked ? 'style="background-color: #ffe58f; border-color: #faad14; color: #fa541c;"' : '') +
					      '>' + (isBookmarked ? '⭐' : '⭐') + '</button>'
				   + '</div>'+
                '</div>'
              );
            }
            const content =
              '<div style="padding: 12px; max-width: 280px; font-family: Arial, sans-serif; box-shadow: 0 2px 8px rgba(0,0,0,0.1); border-radius: 8px; background: #fff; border: none;">' +
              '<div style="font-size: 15px; font-weight: bold; color: #333; margin-bottom: 5px;">' + escapeHtml(shop.name) + '</div>' +
              '<div style="font-size: 13px; color: #666; margin-bottom: 10px; line-height: 1.4;">' + escapeHtml(shop.road_address) + '</div>' +
              '<div style="display: flex; justify-content: space-between; align-items: center;">' +
              '<a href="/repairShop/view?id=' + shop.id + '" ' +
              'style="display: inline-block; padding: 8px 12px; background: #4CAF50; color: white; font-size: 12px; border-radius: 20px; text-decoration: none;">' +
              '상세보기' +
              '</a> | ' +
			  '<a href="https://map.kakao.com/link/to/' + encodeURIComponent(shop.name) + ',' + shop.latitude + ',' + shop.longitude + '" target="_blank" '
			  +'style="display: inline-block; padding: 8px 12px; background: #3498db; color: white; font-size: 12px; border-radius: 20px; text-decoration: none;">'+
			  '길찾기' +
		  	  '</a> | ' +
              '<a href="javascript:void(0)" onclick="closeInfoWindow()" ' +
              'style="display: inline-block; padding: 8px 12px; background: #e74c3c; color: white; font-size: 12px; border-radius: 20px; text-decoration: none; margin-left: 8px;">' +
              '닫기' +
              '</a>' +
              '</div>' +
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
            newMarkers.push({ marker, infowindow });
          });
          clusterer.addMarkers(newMarkers.map(m => m.marker));
          $('#shopList').on('click', '.shop-card', function () {
            const index = $(this).data('index');
            const { marker, infowindow } = newMarkers[index];
            isProgrammaticMove = true;
            map.setCenter(marker.getPosition());
            if (currentInfoWindow) currentInfoWindow.close();
            infowindow.open(map, marker);
            currentInfoWindow = infowindow;
          });
		  
		  // ✅ 찜 버튼 바인딩도 여기로 옮기기
		  $('#shopList').off('click', '.bookmark-btn').on('click', '.bookmark-btn', function (e) {
		    e.stopPropagation(); // 카드 클릭 이벤트 중단
		    const shopId = $(this).data('id');
		    const $btn = $(this);

		    $.ajax({
		      url: '/bookmark/toggle',
		      method: 'POST',
		      data: { shopId },
		      success: function (res) {
		        if (res.success) {
		          if (res.bookmarked) {
		            $btn.text('⭐');
		            $btn.css({ backgroundColor: '#ffe58f', borderColor: '#faad14', color: '#fa541c' });
		          } else {
		            $btn.text('⭐');
		            $btn.removeAttr('style').addClass('styled');
		          }
		        } else {
		          alert(res.message || "오류 발생");
		        }
		      },
		      error: function () {
		        alert("서버 오류가 발생했습니다.");
		      }
		    });
		  });
        }

      });
    }

    </script>
  </body>
  </html>