<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>관리자 - 자동차 정비소 관리</title>
</head>
<body>

<h1>자동차 정비소 리스트 (관리자용)</h1>

<!-- 검색 폼 -->
<form action="/admin/repairShop/search" method="get">
	<input type="text" name="name" placeholder="정비소 이름 검색">
	<button type="submit">검색</button>
</form>

<br>

<!-- 정비소 리스트 테이블 -->
<table border="1" cellpadding="10" cellspacing="0">
	<tr>
		<th>번호</th>
		<th>정비소 이름</th>
		<th>도로명 주소</th>
		<th>지번 주소</th>
		<th>등록일자</th>
		<th>운영 시작시간</th>
		<th>운영 종료시간</th>
		<th>전화번호</th>
		<th>수정</th>
		<th>삭제</th>
	</tr>

	<c:forEach var="shop" items="${list}">
	<tr>
		<td>${shop.id}</td>
		<td>${shop.name}</td>
		<td>${shop.road_address}</td>
		<td>${shop.lot_address}</td>
		<td>${shop.registration_date}</td>
		<td>${shop.open_time}</td>
		<td>${shop.close_time}</td>
		<td>${shop.tel_number}</td>
		<td><a href="/admin/repairShop/edit?id=${shop.id}&page=${currentPage}">수정</a></td>
<!--		<td><a href="/admin/repairShop/delete?id=${shop.id}">삭제</a></td>-->
		<td><a href="/admin/repairShop/delete?id=${shop.id}&page=${currentPage}" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a></td>
	</tr>
	</c:forEach>

</table>

<br>

<!-- 이전 블럭 화살표 -->
<c:if test="${hasPrev}">
	<a href="?page=${startPage - 1}">&lt;</a>
</c:if>

<!-- 페이지 번호 -->
<c:forEach var="i" begin="${startPage}" end="${endPage}">
	<c:choose>
		<c:when test="${i == currentPage}">
			<strong>[${i}]</strong>
		</c:when>
		<c:otherwise>
			<a href="?page=${i}">${i}</a>
		</c:otherwise>
	</c:choose>
</c:forEach>

<!-- 다음 블럭 화살표 -->
<c:if test="${hasNext}">
	<a href="?page=${endPage + 1}">&gt;</a>
</c:if>


<!-- 페이징 버튼 -->
<!--<div>-->
<!--	<c:forEach var="i" begin="1" end="10">-->
<!--		<a href="/admin/repairShop/list?page=${i}">${i}</a>-->
<!--	</c:forEach>-->
<!--</div>-->


<c:if test="${param.updateSuccess == 'true'}">
	<script>
		alert('정비소 정보가 수정되었습니다.');
		history.replaceState({}, null, location.pathname);
	</script>
</c:if>

<c:if test="${param.deleteSuccess == 'true'}">
	<script>
		alert('정비소 정보가 삭제되었습니다.');
		history.replaceState({}, null, location.pathname);
	</script>
</c:if>

</body>
</html>
