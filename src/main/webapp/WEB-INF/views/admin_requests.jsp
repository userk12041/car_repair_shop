<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>정비소 신청 목록</title>
</head>
<body>
<h2>신규 정비소 신청 목록</h2>

<table border="1">
	<tr>
		<th>신청자 ID</th>
		<th>정비소명</th>
		<th>도로명 주소</th>
		<th>지번 주소</th>
		<th>등록일자</th>
		<th>전화번호</th>
		<th>처리</th>
	</tr>
	<c:forEach var="req" items="${requestList}">
		<tr>
			<td>${req.request_user_id}</td>
			<td>${req.name}</td>
			<td>${req.road_address}</td>
			<td>${req.lot_address}</td>
			<td>${req.registration_date}</td>
			<td>${req.tel_number}</td>
			<td>
				<form action="/admin/repairShop/approve" method="post" style="display:inline;">
					<input type="hidden" name="id" value="${req.id}">
					<button type="submit">승인</button>
				</form>
				<form action="/admin/repairShop/reject" method="post" style="display:inline;">
					<input type="hidden" name="id" value="${req.id}">
					<button type="submit">거절</button>
				</form>
			</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>
