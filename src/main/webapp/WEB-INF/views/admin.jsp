<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>관리자 - 자동차 정비소 관리</title>
	<link crossorigin="anonymous" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
		integrity="sha384-...sha384..." rel="stylesheet" />

	<style>
		th {
			text-align: center;
			white-space: nowrap;
			padding: 10px 20px;
		}
		
		td {
			vertical-align: middle;
			padding-top: 10px;
			padding-bottom: 10px;
		}
		
		th.date-col, td.date-col {
			white-space: nowrap;
			min-width: 110px;
		}

		th.time-col, td.time-col {
			width: 70px;
			text-align: center;
		}		
	</style>
</head>
<body>
	<!-- 메인 페이지 이동 버튼 (왼쪽 상단)-->
	<a href="http://localhost:8485/main" class="btn btn-outline-dark position-absolute" style="top: 20px; left: 20px; z-index: 1000;">
		← 메인 페이지
	</a>
	
	<!-- API 동기화 버튼 (오른쪽 상단) -->
	<form action="/admin/repairShop/sync" method="post"
		  onsubmit="return confirm('시간이 소요되는 작업입니다. 정말 동기화 하시겠습니까?');"
		  class="position-absolute"
		  style="top: 20px; right: 20px; z-index: 1000;">
		<input type="submit" value="API 동기화" class="btn btn-primary">
	</form>
	
<div class="container my-5">
	<h1 class="mb-4 text-center">자동차 정비소 리스트 (관리자용)</h1>
	
	<!-- 검색 폼 -->
	<form action="/admin/repairShop/search" method="get" class="mb-3">
		<div class="input-group">
			<input type="text" name="name" class="form-control" placeholder="정비소 이름 검색">
			<button class="btn btn-primary" type="submit">검색</button>
		</div>
	</form>

	<!-- 정렬 버튼 -->
	<div class="btn-group mb-4" role="group">
		<a href="/admin/repairShop/list?sortField=registration_date&order=desc" class="btn btn-outline-secondary btn-sm">등록일 ↓</a>
		<a href="/admin/repairShop/list?sortField=registration_date&order=asc" class="btn btn-outline-secondary btn-sm">등록일 ↑</a>
		<a href="/admin/repairShop/list?sortField=name&order=asc" class="btn btn-outline-secondary btn-sm">정비소명 ↑</a>
		<a href="/admin/repairShop/list?sortField=name&order=desc" class="btn btn-outline-secondary btn-sm">정비소명 ↓</a>
	</div>

	<!-- 정비소 리스트 테이블 -->
	<table class="table table-bordered table-hover">
		<tr class="table-light">
			<th>번호</th>
			<th>정비소 이름</th>
			<th>도로명 주소</th>
			<th>지번 주소</th>
			<th class="date-col">등록일자</th>
			<th class="time-col">운영 시작시간</th>
			<th class="time-col">운영 종료시간</th>
			<th>전화번호</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<c:forEach var="shop" items="${list}">
			<tr>
				<td align="center">${shop.id}</td>
				<td>${shop.name}</td>
				<td>${shop.road_address}</td>
				<td>${shop.lot_address}</td>
				<td>${shop.registration_date}</td>
				<td>${shop.open_time}</td>
				<td>${shop.close_time}</td>
				<td>${shop.tel_number}</td>
				<td>
					<a href="/admin/repairShop/edit?id=${shop.id}&page=${currentPage}" class="btn btn-sm btn-outline-primary">수정</a>
				</td>
				<td>
					<a href="/admin/repairShop/delete?id=${shop.id}&page=${currentPage}" class="btn btn-sm btn-outline-danger"
					   onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
				</td>
			</tr>
		</c:forEach>
	</table>

	<!-- 페이징 -->
	<div class="text-center my-4">
		<c:if test="${hasPrev}">
			<a href="?page=${startPage - 1}">&lt;</a>
		</c:if>
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
		<c:if test="${hasNext}">
			<a href="?page=${endPage + 1}">&gt;</a>
		</c:if>
	</div>

	<!-- 하단 버튼 -->
	<div class="text-center">
		<a href="/admin/repairShop/list" class="btn btn-outline-primary btn-sm me-2">처음 목록으로 새로고침</a>
		<a href="/repairShop/request" class="btn btn-outline-secondary btn-sm me-2">정비소 등록 요청</a>
		<a href="/admin/repairShop/requests" class="btn btn-outline-danger btn-sm">정비소 신청 관리</a>
	</div>

	<!-- alert 처리 -->
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
	
	<!--	API 동기화-->
	<c:if test="${not empty sessionScope.syncResult}">
		<script>
			alert('동기화 완료: ${sessionScope.syncResult.insertedCount}건 추가, ${sessionScope.syncResult.updatedCount}건 수정, ${sessionScope.syncResult.skippedCount}건 그대로');
		</script>
		<c:remove var="syncResult" scope="session"/>
	</c:if>
		
</div>
</body>
</html>
