<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background: #f8f8f8;
    color: #333;
    margin: 0;
    padding: 0;
}

#header {
    padding: 10px 20px;
    background-color: #ffffff;
    border-bottom: 1px solid #ddd;
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

.container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: calc(100vh - 100px); /* 헤더 높이 고려 */
}

h1 {
    margin-bottom: 30px;
}

form {
    background: #fff;
    padding: 30px;
    border: 1px solid #ddd;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    width: 300px;
    display: flex;
    flex-direction: column;
    gap: 15px;
}

label {
    font-weight: bold;
}

input[type="text"],
input[type="password"] {
    padding: 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
    width: 100%;
}

input[type="submit"] {
    background: #4CAF50;
    color: white;
    border: none;
    padding: 10px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
}

input[type="submit"]:hover {
    background: #43a047;
}

.social-login {
    margin-top: 20px;
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.social-login button {
    border: none;
    padding: 10px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    font-size: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.naver-btn {
    background-color: #1EC800;
    color: white;
}

.kakao-btn {
    background-color: #FEE500;
    color: #3c1e1e;
}

.link-section {
    text-align: center;
    margin-top: 20px;
}

.link-section a {
    color: #4CAF50;
    font-weight: bold;
    text-decoration: none;
    margin: 0 5px;
}

.link-section a:hover {
    text-decoration: underline;
}

.error-msg {
    color: red;
    font-size: 0.9em;
    text-align: center;
}
</style>
</head>
<body>

<!-- ✅ 헤더 영역 -->
<div id="header">
    <div id="logo">
        <img alt="logo_img" src="/resources/images/logo2.png" onclick="location.href='/main'">
    </div>
</div>

<!-- ✅ 본문 영역 -->
<div class="container">
    <h1>로그인</h1>

    <c:if test="${param.error eq 'true'}">
        <p class="error-msg">아이디 또는 비밀번호가 올바르지 않습니다.</p>
    </c:if>

    <form method="post" action="login_yn">
        <div>
            <label for="user_id">아이디</label>
            <input type="text" name="user_id" id="user_id" required>
        </div>
        <div>
            <label for="password">비밀번호</label>
            <input type="password" name="password" id="password" required>
        </div>
        <input type="submit" value="로그인">

       
    </form>

    <div class="link-section">
        <p>계정이 없으신가요? <a href="/register">회원가입</a></p>
        <p>
            <a href="/find-id">아이디 찾기</a> |
            <a href="/find-password">비밀번호 찾기</a>
        </p>
    </div>
</div>

</body>
</html>
