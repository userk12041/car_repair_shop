<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>정비소 수정</title>
	<link crossorigin="anonymous" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
		  integrity="sha384-..." rel="stylesheet" />
</head>
<body>

<!-- 왼쪽 상단: 목록으로 -->
<a href="/admin/repairShop/list?page=${currentPage}" class="btn btn-outline-dark position-absolute"
   style="top: 20px; left: 20px; z-index: 1000;">
	← 목록으로
</a>

<div class="container my-5">
	<h2 class="mb-4 text-center">자동차 정비소 수정 (관리자용)</h2>

	<form action="/admin/repairShop/update" method="post">
		<input type="hidden" name="id" value="${repairShop.id}" />
		<input type="hidden" name="page" value="${currentPage}" />

		<table class="table table-bordered">
			<tr>
				<th class="table-light">정비소 이름</th>
				<td><input type="text" name="name" class="form-control" value="${repairShop.name}" required></td>
			</tr>
			<tr>
				<th class="table-light">도로명 주소</th>
				<td><input type="text" name="roadaddress" class="form-control" value="${repairShop.road_address}"></td>
			</tr>
			<tr>
				<th class="table-light">지번 주소</th>
				<td><input type="text" name="lotaddress" class="form-control" value="${repairShop.lot_address}"></td>
			</tr>
			<tr>
				<th class="table-light">등록일자</th>
				<td><input type="text" name="registration_date" class="form-control" value="${repairShop.registration_date}"></td>
			</tr>
			<tr>
				<th class="table-light">운영 시작시간</th>
				<td><input type="text" name="opentime" class="form-control" value="${repairShop.open_time}"></td>
			</tr>
			<tr>
				<th class="table-light">운영 종료시간</th>
				<td><input type="text" name="closetime" class="form-control" value="${repairShop.close_time}"></td>
			</tr>
			<tr>
				<th class="table-light">전화번호</th>
				<td><input type="text" name="telnumber" class="form-control" value="${repairShop.tel_number}"></td>
			</tr>
		</table>

		<div class="text-center mt-4">
			<button type="submit" class="btn btn-primary me-2">수정 완료</button>
			<a href="/admin/repairShop/list?page=${currentPage}" class="btn btn-secondary">취소</a>
		</div>
	</form>
</div>

</body>
</html>
