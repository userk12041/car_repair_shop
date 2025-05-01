<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>관리자 인증</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
</head>
<body>
	<div class="container mt-5" style="max-width: 500px;">
		<h3 class="text-center mb-4">관리자 인증</h3>

		<c:if test="${not empty errorMsg}">
			<div class="alert alert-danger">${errorMsg}</div>
		</c:if>

		<form action="/admin/auth/verify" method="post">
			<div class="mb-3">
				<label for="adminPassword" class="form-label">관리자 비밀번호</label>
				<input type="password" class="form-control" id="adminPassword" name="adminPassword" required>
			</div>
			<div class="text-center">
				<button type="submit" class="btn btn-primary">인증</button>
				<a href="/main" class="btn btn-outline-secondary">취소</a>
			</div>
		</form>
	</div>
</body>
</html>
