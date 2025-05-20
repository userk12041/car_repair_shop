<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
	<%@ include file="/WEB-INF/views/header/header.jsp" %>
	
    <title>업체 상세정보</title>
	<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=253dd4f3250d0399b6c6cd73a5596951&libraries=clusterer"></script>
	<script>
	  const isLoggedIn = <%= session.getAttribute("loginId") != null %>;
	</script>
	<style>
		body {
		    font-family: 'Noto Sans KR', sans-serif;
		    margin: 20px;
		    background-color: #fafafa;
		}

		#shopMap {
		    width: 100%;
		    height: 500px;
		    border: 1px solid #ccc;
		    border-radius: 8px;
		    margin-top: 20px;
		}
		
		.container {
            display: flex;
            gap: 30px;
            margin-top: 20px;
        }

        table.info-box {
            width: 40%;
            border-collapse: collapse;
            background: #f1f5f9;
            padding: 16px;
            border-radius: 20px;
            height: 500px;
            overflow-y: auto;
        }
		caption{
			caption-side: top;          
			width: 100%;                /* 테이블 전체 너비로 확장 */
			text-align: center;         /* 가운데 정렬 */
			font-size: 24px;            
			font-weight: bold;          
			padding: 10px 0;            
		}
	    th {
	        background-color: #f7f7f7;
	        text-align: left;
	        padding: 10px;
	        width: 25%;
	    }
	    td {
	        padding: 10px;
	    }
		.review-box {
		    flex: 1;
		    background: #fff;
		    padding: 20px;
		    border-radius: 12px;
		    border: 1px solid #ccc;
		    height: 500px;
		    overflow-y: auto;
		}
		.review {
		    margin-bottom: 15px;
		    padding: 10px;
		    border-bottom: 1px solid #ddd;
		}

		.review-header {
		    font-weight: bold;
		}

		.review-date {
		    font-size: 0.8em;
		    color: #666;
		}

		.stars {
		    color: gold;
		}
		.review-edit-form {
		    display: none;
		    margin-top: 10px;
		}
		
	</style>
	
</head>
<body>
	<div id="shopMap"></div>
	<div class="container">
        <!-- 업체 정보 -->
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

        <!-- 리뷰 -->
        <div class="review-box">
			<div style="display: flex; justify-content: space-between; align-items: center;">
			    <h3 style="margin: 0;">리뷰</h3>
				<button id="writeReviewBtn" onclick="toggleReviewForm()" style="${hasReview ? 'display:none;' : 'display:inline;'}">리뷰 쓰기</button>
			</div>
			
			<!-- 리뷰 작성 폼 (초기에는 숨김) -->
		    <div id="reviewForm" style="display: none; margin-top: 10px; border-top: 1px solid #ccc; padding-top: 10px;">
		        <!-- <form id="reviewSubmitForm" method="post" action="/review/insert"> -->
		        <form id="reviewSubmitForm" method="post" onsubmit="return submitReview(event)">
		            <input type="hidden" name="repairShopId" value="${shop.id}" />

		            <label>별점:
		                <select name="rating" class="stars" required>
		                    <!--<option value="">선택</option>-->
		                    <option value="5">★★★★★</option>
		                    <option value="4">★★★★☆</option>
		                    <option value="3">★★★☆☆</option>
		                    <option value="2">★★☆☆☆</option>
		                    <option value="1">★☆☆☆☆</option>
		                </select>
		            </label><br><br>

		            <label>내용:<br>
		                <textarea name="content" rows="4" cols="50" required></textarea>
		            </label><br><br>

		            <button type="submit">등록</button>
		        </form>
		    </div>
			
			<!-- 리뷰들 출력 -->
            <c:forEach var="review" items="${reviews}">
                <div class="review">
                    <div class="review-header">
                        ${review.userId}
                        <span class="stars">
                            <c:forEach begin="1" end="5" var="i">
                                <c:choose>
                                    <c:when test="${i <= review.rating}">★</c:when>
                                    <c:otherwise>☆</c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </span>
						<span class="review-date">
						    (<fmt:formatDate value="${review.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />)
						</span>
						<c:if test="${review.userId == sessionScope.loginId}">
							<!-- 수정 버튼 -->
							<button 
							    data-id="${review.id}" 
							    data-content="${fn:escapeXml(review.content)}" 
							    data-rating="${review.rating}" 
							    onclick="editReviewFromButton(this)">수정
							</button>
						    <!-- 삭제 버튼 -->
							<form method="post" onsubmit="return deleteReview(event, this);" style="display: inline">
							    <input type="hidden" name="id" value="${review.id}" />
							    <input type="hidden" name="repairShopId" value="${shop.id}" />
							    <button type="submit">삭제</button>
							</form>
						</c:if>
                    </div>
					<div id="review_content_${review.id}">${review.content}</div>
					<!-- 수정 폼 미완-->
					<div id="editForm_${review.id}" class="review-edit-form">
					    <form method="post" onsubmit="return submitReviewEdit(event, this, ${review.id});">
					        <input type="hidden" name="id" value="${review.id}" />
					        <input type="hidden" name="userId" value="${review.userId}" />
					        <input type="hidden" name="repairShopId" value="${shop.id}" />

					        <label>별점:
					            <select name="rating" class="stars" required>
					                <c:forEach begin="1" end="5" var="i">
					                    <option value="${i}" <c:if test="${i == review.rating}">selected</c:if>>
					                        <c:forEach begin="1" end="${i}" var="s">★</c:forEach>
					                    </option>
					                </c:forEach>
					            </select>
					        </label><br/>

					        <label>내용:<br/>
					            <textarea name="content" rows="3" cols="40">${fn:escapeXml(review.content)}</textarea>
					        </label><br/>

					        <button type="submit">수정완료</button>
					        <button type="button" onclick="cancelEdit(${review.id})">취소</button>
					    </form>
					</div>
                </div>
            </c:forEach>
        </div>
    </div>

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
	<script>
		// 리뷰 작성 버튼
		function toggleReviewForm() {
			if(!isLoggedIn){
				alert("로그인 후 이용하실 수 있습니다.")
				return;
			}
		    const form = document.getElementById('reviewForm');
		    form.style.display = (form.style.display === 'none') ? 'block' : 'none';
		}
		// 리뷰 수정 버튼
		function editReviewFromButton(button) {
		    const reviewId = button.getAttribute("data-id");
	
		    // 숨기기 전 모든 수정 폼 닫기
		    document.querySelectorAll(".review-edit-form").forEach(el => el.style.display = "none");
			// 모든 기존 리뷰 다시 보이게
			document.querySelectorAll("[id^='review_content_']").forEach(el => el.style.display = "block");
			// 모든 review-header 다시 보이게
			document.querySelectorAll(".review-header").forEach(el => el.style.display = "block");
			
			const header = button.closest(".review-header");
			const content = document.getElementById("review_content_" + reviewId);
		    const form = document.getElementById("editForm_" + reviewId);
			
			if (header) header.style.display = "none";
			if (content) content.style.display = "none";
		    if (form) form.style.display = "block";
		}
		// 수정 취소 버튼
		function cancelEdit(reviewId) {
			// 수정 폼 숨기기
		    const form = document.getElementById("editForm_" + reviewId);
		    if (form) form.style.display = "none";
			
			// 원래 리뷰 내용 다시 보이게
			const content = document.getElementById("review_content_" + reviewId);
			if (content) content.style.display = "block";
			
			// 리뷰 상단 다시 보이게
			const reviewDiv = form.closest(".review");
			const header = reviewDiv.querySelector(".review-header");
			if (header) header.style.display = "block";
		}
	</script>
	<script>
		// 리뷰 작성 Ajax
		function submitReview(event) {
		    event.preventDefault(); // 폼의 기본 제출 막기
		    if (!isLoggedIn) {
		        alert("로그인 후 작성할 수 있습니다.");
		        return false;
		    }
		    const form = document.getElementById("reviewSubmitForm");
		    const formData = new FormData(form);
			// 콘솔에 FormData의 key-value 쌍 출력 test
			for (let [key, value] of formData.entries()) {
			    console.log("review delete formData => key:", JSON.stringify(key), ", value:", JSON.stringify(value));
			}
			
		    fetch("/review/insert", {
		        method: "POST",
		        body: formData
		    })
		    .then(response => {
		        if (!response.ok) throw new Error("서버 오류");
		        return response.text(); // JSON 응답이면 .json()으로
		    })
		    .then(data => {
		        alert("리뷰가 등록되었습니다.");
		        location.reload(); // 새로고침해서 반영
		    })
		    .catch(error => {
		        console.error("등록 오류:", error);
		        alert("리뷰 등록에 실패했습니다.");
		    });

		   	return false; // 혹시 몰라 한 번 더 기본 제출 방지
			}
		// 리뷰 수정 Ajax
		function submitReviewEdit(event, form, reviewId) {
		    event.preventDefault(); // 기본 제출 막기
		    const formData = new FormData(form);
			// 콘솔에 FormData의 key-value 쌍 출력 test
			for (let [key, value] of formData.entries()) {
			    console.log("review delete formData => key:", JSON.stringify(key), ", value:", JSON.stringify(value));
			}
			
		    fetch("/review/update", {
		        method: "POST",
		        body: formData
		    })
		    .then(res => {
		        if (!res.ok) throw new Error("서버 오류");
		        return res.text();
		    })
		    .then(data => {
		        alert("리뷰가 수정되었습니다.");
		        location.reload(); // 새로고침하여 반영
		    })
		    .catch(err => {
		        console.error("수정 실패:", err);
		        alert("리뷰 수정에 실패했습니다.");
		    });

		    return false;
		}
		// 리뷰 삭제 Ajax
		function deleteReview(event, form) {
		    event.preventDefault();
			// 값 테스트
			console.log("deleteReview 호출됨, form:", form);
		    console.log("form instanceof HTMLFormElement?", form instanceof HTMLFormElement);

		    if (!confirm("정말 삭제하시겠습니까?")) {
		        return false;  // 취소 시 폼 제출 안 함
		    }

		    const formData = new FormData(form);
			/*for (let [key, value] of formData.entries()) {
			    console.log(`review delete formData => ${key}: ${value}`);
			}*/
			for (let [key, value] of formData.entries()) {
			    console.log("review delete formData => key:", JSON.stringify(key), ", value:", JSON.stringify(value));
			}

		    fetch("/review/delete", {
		        method: "POST",
		        body: formData
		    })
		    .then(res => {
		        if (!res.ok) throw new Error("삭제 실패");
		        return res.text();
		    })
		    .then(data => {
		        // 삭제 성공 후 해당 리뷰 요소 제거
		        const reviewElement = form.closest(".review");
		        if (reviewElement) reviewElement.remove();
				
				if (isLoggedIn) {
				    const writeButton = document.querySelector("button[onclick='toggleReviewForm()']");
				    if (writeButton) {
				        writeButton.style.display = "inline";
				    } else {
					    console.log("리뷰 작성 버튼을 찾지 못함");
					}
				}
		    })
		    .catch(err => {
		        console.error(err);
		        alert("삭제 중 오류가 발생했습니다.");
		    });

		    return false; // 폼 기본 제출 막기
		}
	</script>
    <br/>
</body>
</html>