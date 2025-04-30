<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>정비소 신청 목록</title>
	<link crossorigin="anonymous" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
		integrity="sha384-...sha384..." rel="stylesheet" />

	<style>
		th {
			text-align: center;
			white-space: nowrap;
			padding: 10px 20px;
		}
		td.action-cell {
			text-align: center;
			white-space: nowrap;
			width: 160px;
		}
	</style>
</head>
<body>
	<div class="container my-5">
		<h2 class="my-4 text-center">신규 정비소 신청 목록</h2>
		<table border="1" class="table table-bordered table-hover">
			<thead class="table-light">
				<tr>
					<th>신청자 ID</th>
					<th>정비소명</th>
					<th>도로명 주소</th>
					<th>지번 주소</th>
					<th>등록일자</th>
					<th>전화번호</th>
					<th>처리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="req" items="${requestList}">
					<tr>
						<td align="center">${req.request_user_id}</td>
						<td>${req.name}</td>
						<td>${req.road_address}</td>
						<td>${req.lot_address}</td>
						<td>${req.registration_date}</td>
						<td>${req.tel_number}</td>
						<td class="action-cell">
							<form action="/admin/repairShop/approve" method="post" style="display:inline;">
								<input type="hidden" name="id" value="${req.id}">
								<button class="btn btn-sm btn-primary" type="submit">승인</button>
							</form>
							<form action="/admin/repairShop/reject" method="post" style="display:inline;">
								<input type="hidden" name="id" value="${req.id}">
								<button class="btn btn-sm btn-primary" type="submit">거절</button>
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<!-- 하단 버튼 -->
		<div class="text-center">
			<a href="/admin/repairShop/list" class="btn btn-outline-primary btn-sm me-2">정비소 목록</a>
		</div>
	</div>
</body>
</html>
