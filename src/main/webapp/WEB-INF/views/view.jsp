<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


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
			    <button onclick="toggleReviewForm()">리뷰 쓰기</button>
			</div>
			
			<!-- 리뷰 작성 폼 (초기에는 숨김) -->
		    <div id="reviewForm" style="display: none; margin-top: 10px; border-top: 1px solid #ccc; padding-top: 10px;">
		        <form id="reviewSubmitForm" method="post" action="/review/insert">
		            <input type="hidden" name="repairShopId" value="${shop.id}" />

		            <label>별점:
		                <select name="rating" required>
		                    <option value="">선택</option>
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
						    <form method="post" action="/view/delete" style="display: inline;">
						        <input type="hidden" name="id" value="${review.id}" />
						        <input type="hidden" name="repairShopId" value="${shop.id}" />
						        <button type="submit">삭제</button>
						    </form>
						</c:if>
                    </div>
					<div id="review_content_${review.id}">${review.content}</div>
					<!-- 수정 폼 미완-->
					<div id="editForm_${review.id}" class="review-edit-form">
					    <form method="post" action="/review/update">
					        <input type="hidden" name="id" value="${review.id}" />
					        <input type="hidden" name="userId" value="${review.userId}" />
					        <input type="hidden" name="repairShopId" value="${shop.id}" />

					        <label>별점:
					            <select name="rating" required>
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
		function toggleReviewForm() {
		    const form = document.getElementById('reviewForm');
		    form.style.display = (form.style.display === 'none') ? 'block' : 'none';
		}
	</script>
	<script>
		function editReviewFromButton(button) {
		    const reviewId = button.getAttribute("data-id");
	
		    // 숨기기 전 모든 수정 폼 닫기
		    document.querySelectorAll(".review-edit-form").forEach(el => el.style.display = "none");
	
		    const form = document.getElementById("editForm_" + reviewId);
		    if (form) form.style.display = "block";
		}
	
		function cancelEdit(reviewId) {
		    const form = document.getElementById("editForm_" + reviewId);
		    if (form) form.style.display = "none";
		}
	</script>
    <br/>
</body>
</html>