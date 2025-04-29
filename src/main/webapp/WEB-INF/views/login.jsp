<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
    <h1>로그인</h1>
    <div>
        <form method="post" action="login_yn">
            <div>
                <label for="user_id">아이디</label>
                <input type="text" name="user_id" id="user_id">
            </div>
            <div>
                <label for="password">비밀번호</label>
                <input type="password" name="password" id="password">
            </div>
            <input type="submit" value="로그인">
        </form>
    </div>
</body>
</html>
