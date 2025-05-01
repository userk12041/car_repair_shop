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
</style>
</head>

<body>

	<!-- 임시용 버튼 3개 구현했습니다. main.jsp 작업하시는 분이 원하시는대로 디자인 작업해주시면 됩니다.  -->

  <!-- 1. 메인 페이지 내 관리자 이동 버튼 -->
  <c:choose>
  <c:when test="${sessionScope.loginRole == 'ADMIN'}">
    <button type="button" class="btn btn-danger" onclick="location.href='/admin/repairShop/list'">
    	관리자 페이지
    </button>
  </c:when>
  <c:otherwise>
    <button type="button" class="btn btn-outline-danger" onclick="location.href='/admin/auth'">
    	관리자 페이지
    </button>
  </c:otherwise>
  </c:choose>
  
  <!-- 2. 정비소 추가 버튼 -->
  <c:choose>
  <c:when test="${not empty sessionScope.loginId}">
  	<button type="button" class="btn btn-success" onclick="location.href='/repairShop/request'">정비소 추가</button>
  </c:when>
  <c:otherwise>
  	<button type="button" class="btn btn-secondary" onclick="alert('로그인 상태에서 이용 가능한 서비스 입니다.')">정비소 추가</button>
  </c:otherwise>
  </c:choose>

  <!-- 3. 테스트용 세션 초기화 버튼. 실제로 파일 제출시에는 주석처리 하기. -->
  <button type="button" class="btn btn-sm btn-outline-warning" onclick="location.href='/session/reset'">
  	세션 초기화 (완성 버전에서는 없애야함)
  </button>
  
  <div class="container">
    <div class="list-panel" id="shopList">
      <h2 style="text-align: center;">전국 자동차 정비업체</h2>
      <div class="search-bar">
        <input type="text" id="searchKeyword" placeholder="검색어를 입력하세요">
        <button id="searchBtn" type="button">🔍</button>
        <button id="refreshBtn" type="button">🔄</button>
      </div>
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
      $('#searchBtn').off().on('click', searchShops);
      $('#searchKeyword').off().on('keydown', function (e) {
        if (e.key === 'Enter') searchShops();
      });
      $('#refreshBtn').off().on('click', function () {
        isSearchMode = false;
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
      const sw = bounds.getSouthWest();
      const ne = bounds.getNorthEast();
      const swLat = sw.getLat();
      const swLng = sw.getLng();
      const neLat = ne.getLat();
      const neLng = ne.getLng();
      clusterer.clear();
      $('#shopList').html(`
        <h2 style="text-align:center;">전국 자동차 정비업체</h2>
        <div class="search-bar">
          <input type="text" id="searchKeyword" placeholder="검색어를 입력하세요">
          <button id="searchBtn" type="button">🔍</button>
          <button id="refreshBtn" type="button">🔄</button>
        </div>
      `);
      bindSearchEvents();
      $.ajax({
        url: `/api/repairShops?swLat=${swLat}&swLng=${swLng}&neLat=${neLat}&neLng=${neLng}`,
        method: 'GET',
        success: function (data) {
          const newMarkers = [];
          const limitedData = data.slice(0, 2000);
          limitedData.forEach((shop, index) => {
            if (index < 100) {
              $('#shopList').append(
                '<div class="shop-card" data-index="' + index + '">' +
                '<h3>' + escapeHtml(shop.name) + '</h3>' +
                '<p>' + escapeHtml(shop.road_address) + '</p>' +
                '</div>'
              );
            }
            const content =
              '<div style="padding: 12px; max-width: 280px; font-family: Arial, sans-serif; box-shadow: 0 2px 8px rgba(0,0,0,0.1); border-radius: 8px; background: #fff; border: none;">' +
              '<div style="font-size: 15px; font-weight: bold; color: #333; margin-bottom: 5px;">' + escapeHtml(shop.name) + '</div>' +
              '<div style="font-size: 13px; color: #666; margin-bottom: 10px; line-height: 1.4;">' + escapeHtml(shop.road_address) + '</div>' +
              '<div style="display: flex; justify-content: space-between; align-items: center;">' +
              '<a href="/repairShop/view?id=' + shop.id + '" ' +
              'style="display: inline-block; padding: 8px 12px; background: #4CAF50; color: white; font-size: 12px; border-radius: 20px; text-decoration: none; transition: background 0.3s;">' +
              '상세보기' +
              '</a>' +
              '<a href="javascript:void(0)" onclick="closeInfoWindow()" ' +
              'style="display: inline-block; padding: 8px 12px; background: #e74c3c; color: white; font-size: 12px; border-radius: 20px; text-decoration: none; margin-left: 8px; transition: background 0.3s;">' +
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
        }
      });
    }
    function searchShops() {
      const keyword = $('#searchKeyword').val().trim();
      if (!keyword) {
        isSearchMode = false;
        loadMarkers();
        return;
      }
      isSearchMode = true;
      clusterer.clear();
      $('#shopList').html(`
						<h2 style="text-align:center;">전국 자동차 정비업체</h2>
						<div class="search-bar">
						  <input type="text" id="searchKeyword" value="${keyword}" placeholder="검색어를 입력하세요">
						  <button id="searchBtn" type="button">🔍</button>
						  <button id="refreshBtn" type="button">🔄</button>
						</div>
						`);
        bindSearchEvents();
        $.ajax({
          url: "/api/repairShops/search?keyword=" + encodeURIComponent(keyword),
          method: 'GET',
          success: function (data) {
            const newMarkers = [];
            const limitedData = data.slice(0, 500);
            limitedData.forEach((shop, index) => {
              $('#shopList').append(
                '<div class="shop-card" data-index="' + index + '">' +
                '<h3>' + escapeHtml(shop.name) + '</h3>' +
                '<p>' + escapeHtml(shop.road_address) + '</p>' +
                '</div>'
              );
              const content =
                '<div style="padding: 12px; max-width: 280px; font-family: Arial, sans-serif; box-shadow: 0 2px 8px rgba(0,0,0,0.1); border-radius: 8px; background: #fff; border: none;">' +
                '<div style="font-size: 15px; font-weight: bold; color: #333; margin-bottom: 5px;">' + escapeHtml(shop.name) + '</div>' +
                '<div style="font-size: 13px; color: #666; margin-bottom: 10px; line-height: 1.4;">' + escapeHtml(shop.road_address) + '</div>' +
                '<div style="display: flex; justify-content: space-between; align-items: center;">' +
                '<a href="/repairShop/view?id=' + shop.id + '" ' +
                'style="display: inline-block; padding: 8px 12px; background: #4CAF50; color: white; font-size: 12px; border-radius: 20px; text-decoration: none; transition: background 0.3s;">' +
                '상세보기' +
                '</a>' +
                '<a href="javascript:void(0)" onclick="closeInfoWindow()" ' +
                'style="display: inline-block; padding: 8px 12px; background: #e74c3c; color: white; font-size: 12px; border-radius: 20px; text-decoration: none; margin-left: 8px; transition: background 0.3s;">' +
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
          }
        });
      }
    </script>
  </body>
  </html>