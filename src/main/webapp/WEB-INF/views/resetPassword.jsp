<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>비밀번호 재설정</title>
  <style>
	 <style>
	    body {
	      font-family: 'Noto Sans KR', sans-serif;
	      background-color: #f8f8f8;
	      margin: 0;
	      padding-top: 100px;
	      display: flex;
	      justify-content: center;
	      align-items: center;
	      height: 100vh;
	      flex-direction: column;
	    }

	    .form-card {
	      background: #fff;
	      border: 1px solid #ddd;
	      padding: 30px;
	      border-radius: 12px;
	      box-shadow: 0 4px 10px rgba(0,0,0,0.05);
	      width: 400px;
	    }

	    h2 {
	      text-align: center;
	      margin-bottom: 20px;
	    }

	    label {
	      display: block;
	      margin-bottom: 15px;
	    }

	    input[type="text"] {
	      width: 100%;
	      padding: 10px;
	      border-radius: 6px;
	      border: 1px solid #ccc;
	    }

	    button {
	      width: 100%;
	      padding: 10px;
	      background-color: #4CAF50;
	      color: white;
	      border: none;
	      border-radius: 6px;
	      cursor: pointer;
	      font-weight: bold;
	    }

	    button:hover {
	      background-color: #43a047;
	    }

	    .error-msg {
	      color: red;
	      text-align: center;
	      margin-top: 10px;
	    }

	    .link {
	      text-align: center;
	      margin-top: 15px;
	    }

	    .link a {
	      text-decoration: none;
	      color: #4CAF50;
	      font-weight: bold;
	    }
	  </style>
	</head>
  </style>
</head>
<body>

  <div class="form-card">
    <h2>비밀번호 재설정</h2>
    <form method="post" action="/reset-password">
      <input type="hidden" name="user_id" value="${userId}" />
      <label>
        새 비밀번호:
        <input type="password" name="newPassword" required />
      </label>
      <button type="submit">비밀번호 변경</button>
    </form>

    <div class="link">
      <a href="/login">로그인으로 돌아가기</a>
    </div>
  </div>

</body>
</html>
