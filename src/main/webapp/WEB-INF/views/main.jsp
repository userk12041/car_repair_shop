<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>KH 전국 자동차 정비업체정보</title>

<!-- Kakao Maps API & jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=253dd4f3250d0399b6c6cd73a5596951&libraries=clusterer"></script>

<style>
:root {
  --bg-main: linear-gradient(to top, #ff0033 20%, #1b1b2f 70%, #0a0a1a 100%);
  --text-main: #ffffff;
  --card-bg: rgba(60, 60, 90, 0.7);
  --card-border: #4caf50;
  --beam-color: linear-gradient(to bottom, #ff0033, transparent);
}

/* .top-button {
  position: absolute;
  top: 20px;
  font-size: 16px;
  padding: 10px 20px;
  border-radius: 10px;
  border: none;
  z-index: 9999;
  cursor: pointer;
  color: white;
  background-color: rgba(70, 70, 200, 0.7);
  text-decoration: none;
  transition: 0.3s;
}
.top-button:hover {
  background-color: #4455ee;
} */

.bottom-button {
  position: absolute;
  bottom: 20px;
  font-size: 16px;
  padding: 10px 20px;
  border-radius: 10px;
  border: none;
  z-index: 9999;
  cursor: pointer;
  color: white;
  text-decoration: none;
  transition: 0.3s;
}

.top-right {
  position: absolute;
  top: 20px;
  right: 20px;
  z-index: 9999;
}
.top-right a, .top-right span {
  margin-left: 10px;
  color: white;
  text-decoration: none;
  font-weight: bold;
}
.top-right a:hover {
  text-decoration: underline;
}

body.light-mode {
  --bg-main: linear-gradient(to top, #e0f7fa 0%, #d0e9f5 100%);
  --text-main: #1b3a57;
  --card-bg: rgba(255, 255, 255, 0.8);
  --card-border: #5c9ead;
  --beam-color: linear-gradient(to bottom, #5c9ead, transparent);
}
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
/* #playMusic, #toggleMode {
  position: absolute; top: 20px; padding: 10px 20px; font-size: 16px; cursor: pointer;
  border-radius: 10px; border: none; z-index: 9999; transition: 0.3s;
} */
#playMusic { right: 20px; background-color: rgba(255,0,50,0.7); color: white; }
#toggleMode { right: 160px; background-color: rgba(155,89,182,0.7); color: white; }
#playMusic:hover, #toggleMode:hover { background-color: #ff0033; }
.shop-card { 
  background: var(--card-bg); border: 1px solid var(--card-border); border-radius: 10px;
  padding: 15px; margin-bottom: 15px; transition: 0.3s; cursor: pointer;
}
.shop-card:hover { background-color: var(--card-border); color: var(--bg-main); transform: translateY(-5px) scale(1.02); }
.shop-card h3, .shop-card p { margin: 0; font-size: 16px; }


</style>
</head>

<body>
	<div class="top-right">
	  <c:choose>
	    <c:when test="${empty sessionScope.loginId}">
	      <a href="/login">로그인</a>
	      <a href="/register">회원가입</a>
	    </c:when>
	    <c:otherwise>
	      <span>${sessionScope.loginId}님</span>
	      <a href="/logout">로그아웃</a>
	    </c:otherwise>
	  </c:choose>
	</div>

<button id="playMusic" class="bottom-button">🎵 음악 재생</button>
<button id="toggleMode" class="bottom-button">🌗 모드 변경</button>


<div class="container">
  <div class="list-panel" id="shopList">
    <h2>전국 자동차 정비업체</h2>
  </div>

  <div class="map-panel">
    <div id="map" style="width:100%; height:100%;"></div>
  </div>
</div>

<audio id="bgm" loop>
  <source src="https://vgmsite.com/soundtracks/the-end-of-evangelion/lsdvlkqn/18.%20Komm%2C%20s%C3%BCsser%20Tod.mp3" type="audio/mp3">
</audio>

<script>
const playButton = document.getElementById('playMusic');
const toggleButton = document.getElementById('toggleMode');
const audio = document.getElementById('bgm');
let map, clusterer, currentInfoWindow;

playButton.addEventListener('click', function() {
  audio.play();
  this.style.display = 'none';
});
toggleButton.addEventListener('click', function() {
  document.body.classList.toggle('light-mode');
});

document.addEventListener("DOMContentLoaded", function() {
  map = new kakao.maps.Map(document.getElementById('map'), {
    center: new kakao.maps.LatLng(36.5, 127.5),
    level: 13
  });

  clusterer = new kakao.maps.MarkerClusterer({
    map: map,
    averageCenter: true,
    minLevel: 10
  });

  loadMarkers();

  document.getElementById('shopList').addEventListener('click', function(e) {
    const card = e.target.closest('.shop-card');
    if (card) {
      const lat = parseFloat(card.dataset.lat);
      const lng = parseFloat(card.dataset.lng);
      map.panTo(new kakao.maps.LatLng(lat, lng));
    }
  });
});

function loadMarkers() {
  $.ajax({
    url: '/api/repairShops',
    method: 'GET',
    success: function(data) {
      const shopListElement = document.getElementById("shopList");

      data.forEach(function(shop) {
        const card = document.createElement('div');
        card.className = 'shop-card';
        card.dataset.lat = shop.latitude;
        card.dataset.lng = shop.longitude;
        card.innerHTML = `<h3>${shop.name}</h3><p>${shop.road_address}</p>`;
        shopListElement.appendChild(card);

        const marker = new kakao.maps.Marker({
          position: new kakao.maps.LatLng(shop.latitude, shop.longitude),
          title: shop.name
        });

        const infowindow = new kakao.maps.InfoWindow({
          content: `<div style="padding:5px;">${shop.name}</div>`
        });

        kakao.maps.event.addListener(marker, 'click', function() {
          if (currentInfoWindow) currentInfoWindow.close();
          infowindow.open(map, marker);
          currentInfoWindow = infowindow;
        });

        clusterer.addMarker(marker);
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
