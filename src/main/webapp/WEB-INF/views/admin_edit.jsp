<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>정비소 수정</title>
</head>
<body>

<h1>자동차 정비소 수정 (관리자용)</h1>

<form action="/admin/repairShop/update" method="post">
	<input type="hidden" name="id" value="${repairShop.id}" />
	
	<table border="1">
		<tr>
			<th>정비소 이름</th>
			<td><input type="text" name="name" value="${repairShop.name}" required></td>
		</tr>
		<tr>
			<th>도로명 주소</th>
			<td><input type="text" name="roadaddress" value="${repairShop.roadaddress}"></td>
		</tr>
		<tr>
			<th>지번 주소</th>
			<td><input type="text" name="lotaddress" value="${repairShop.lotaddress}"></td>
		</tr>
		<tr>
			<th>등록일자</th>
			<td><input type="text" name="registration_date" value="${repairShop.registration_date}"></td>
		</tr>
		<tr>
			<th>운영 시작시간</th>
			<td><input type="text" name="opentime" value="${repairShop.opentime}"></td>
		</tr>
		<tr>
			<th>운영 종료시간</th>
			<td><input type="text" name="closetime" value="${repairShop.closetime}"></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="text" name="telnumber" value="${repairShop.telnumber}"></td>
		</tr>
	</table>

	<br/>
	<button type="submit">수정 완료</button>
	<a href="/admin/repairShop/list"><button type="button">취소</button></a>

</form>

</body>
</html>
