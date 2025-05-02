<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
	
	<style>
	#header {
	    padding: 10px 20px;
	    background-color: #ffffff;
	    border-bottom: 1px solid #ddd;
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	}

	#logo {
	    text-decoration: none;
	    display: inline-flex;
	    align-items: center;
	}
	#logo img {
	    height: 80px;
	    width: 240px;
	    cursor: pointer;
	}
	#logo span {
	    font-size: 20px;
	    font-weight: bold;
	    color: #333;
	    margin-left: 8px;
	}

	#auth-links {
	    font-size: 16px;
	}
	#auth-links a {
	    margin-left: 15px;
	    text-decoration: none;
	    color: #007bff;
	}
	</style>
</head>
<body>
	<div id="header">
	    <div id="logo">
	        <img alt="logo_img" src="/resources/images/logo2.png" onclick="javascript:location='/main'">
	    </div>
	    <div id="auth-links">
	        <c:choose>
	            <c:when test="${not empty sessionScope.loginNickname}">
	                <span><strong>${sessionScope.loginNickname}</strong>님</span>
	                <a href="/repairShop/request">정비소 추가</a>
					<c:choose>
						<c:when test="${sessionScope.loginRole == 'ADMIN'}">
	                		<a href="/admin/repairShop/list">정비소 관리</a>
						</c:when>
						<c:otherwise>
							<a href="/admin/auth">관리자 인증</a>
						</c:otherwise>
					</c:choose>
	                <a href="/logout">로그아웃</a>
	            </c:when>
	            <c:otherwise>
	                <a href="/login">로그인</a>
	                <a href="/register">회원가입</a>
	            </c:otherwise>
	        </c:choose>
	    </div>
	</div>
</body>
</html>
