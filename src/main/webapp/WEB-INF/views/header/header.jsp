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

    #nav-links {
        display: flex;
        gap: 20px;
    }

    #nav-links a, span {
        text-decoration: none;
        color: #333;
        font-weight: 500;
        font-size: 16px;
        padding: 6px 12px;
        transition: background-color 0.2s;
    }

    #nav-links a:hover {
        background-color: #f0f0f0;
        border-radius: 4px;
    }
	#hiddenAdmin{
		text-decoration: none;
		color: #ffffff;
	}
    </style>

</head>
<body>
    <div id="header">
        <div id="logo">
            <img alt="logo_img" src="/resources/images/logo2.png" onclick="location.href='/main'">
        </div>
       	<a href="/admin/repairShop/list" id="hiddenAdmin">관리자페이지</a>
		<div id="nav-links">
		    <c:choose>
		        <c:when test="${not empty sessionScope.loginId}">
		            <span>${sessionScope.loginNickname}님</span>
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
