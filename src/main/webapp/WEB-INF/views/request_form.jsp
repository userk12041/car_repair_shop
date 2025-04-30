<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>정비소 신청</title>
</head>
<body>

<h2>정비소 등록 신청</h2>

<form action="/repairShop/request" method="post">
	<p>정비소 이름: <input type="text" name="name" required></p>
	<p>도로명 주소: <input type="text" name="road_address" required></p>
	<p>지번 주소: <input type="text" name="lot_address"></p>
	<p>전화번호: <input type="text" name="tel_number"></p>
	<p>영업 시작시간: <input type="text" name="open_time" placeholder="예: 09:00"></p>
	<p>영업 종료시간: <input type="text" name="close_time" placeholder="예: 18:00"></p>

	<button type="submit">신청 제출</button>
</form>

</body>
</html>
