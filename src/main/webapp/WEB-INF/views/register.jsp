<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    let isIdChecked = false;
    let lastCheckedId = "";
    let isNickChecked = false;
    let lastCheckedNick = "";

    function checkId() {
        const userId = $("#user_id").val().trim();
        const msgEl = $("#idCheckMsg");

        if (userId === "") {
            msgEl.text("아이디를 입력해주세요.").css("color", "red");
            isIdChecked = false;
            return;
        }

        fetch("idCheck?user_id=" + encodeURIComponent(userId))
            .then(res => res.text())
            .then(data => {
                if (data === "usable") {
                    msgEl.text("사용 가능한 아이디입니다.").css("color", "green");
                    isIdChecked = true;
                    lastCheckedId = userId;
                } else {
                    msgEl.text("이미 사용되고 있는 아이디입니다.").css("color", "red");
                    isIdChecked = false;
                }
            })
            .catch(() => msgEl.text("오류가 발생했습니다.").css("color", "red"));
    }

    function checkNick() {
        const nickname = $("#nickname").val().trim();
        const msgEl = $("#nickCheckMsg");

        if (nickname === "") {
            msgEl.text("닉네임을 입력해주세요.").css("color", "red");
            isNickChecked = false;
            return;
        }

        fetch("nickCheck?nickname=" + encodeURIComponent(nickname))
            .then(res => res.text())
            .then(data => {
                if (data === "usable") {
                    msgEl.text("사용 가능한 닉네임입니다.").css("color", "green");
                    isNickChecked = true;
                    lastCheckedNick = nickname;
                } else {
                    msgEl.text("이미 사용되고 있는 닉네임입니다.").css("color", "red");
                    isNickChecked = false;
                }
            })
            .catch(() => msgEl.text("오류가 발생했습니다.").css("color", "red"));
    }

    function validateForm() {
        const userId = $("#user_id").val().trim();
        const nick = $("#nickname").val().trim();
        const password = $("#password").val().trim();
        const passwordCheck = $("#passwordCheck").val().trim();
        const phone = $("#phone_number").val().trim();
        const email = $("#email").val().trim();
		
		const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]).{8,15}$/;
		const phoneRegex = /^010-\d{4}-\d{4}$/;
		const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (password.length < 4 || password.length > 20) {
            alert("비밀번호는 4~20자 사이로 입력해주세요.");
            $("#password").focus();
            return false;
        }

        if (password !== passwordCheck) {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            $("#passwordCheck").focus();
            return false;
        }

		if (!passwordRegex.test(password)) {
	        alert("비밀번호는 8~15자리이며, 영문자, 숫자, 특수문자를 각각 최소 1개 이상 포함해야 합니다.");
	        document.getElementById("password").focus();
	        return false;
	    }

	    if (password !== passwordCheck) {
	        alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
	        document.getElementById("passwordCheck").focus();
	        return false;
	    }

	    if (!phoneRegex.test(phone)) {
	        alert("전화번호는 '010-1234-5678' 형식으로 입력해주세요.");
	        document.getElementById("phone_number").focus();
	        return false;
	    }

	    if (!emailRegex.test(email)) {
	        alert("올바른 이메일 형식을 입력해주세요.");
	        document.getElementById("email").focus();
	        return false;
	    }

        return true;
    }

    $(document).ready(function() {
        $('.toggle-pw').on('click', function() {
            const input = $(this).prev('input');
            const type = input.attr('type') === 'password' ? 'text' : 'password';
            input.attr('type', type);
            $(this).toggleClass('fa-eye fa-eye-slash');
        });
    });
</script>
<!--<style>-->
<!--    .form-row { margin-bottom: 10px; }-->
<!--    .check-btn { margin-left: 10px; padding: 5px 10px; cursor: pointer; }-->
<!--    .pw-wrap { position: relative; display: flex; align-items: center; }-->
<!--    .pw-wrap input { padding-right: 30px; }-->
<!--    .pw-wrap i { position: absolute; right: 5px; top: 50%; transform: translateY(-50%); cursor: pointer; }-->
<!--    #idCheckMsg, #nickCheckMsg { font-size: 0.9em; margin-top: 5px; display: block; }-->
<!--</style>-->
</head>
<body>
    <h1>회원 가입</h1>
    <div class="register-card">
        <form method="post" action="registerOk" onsubmit="return validateForm()">
            <div class="form-row" style="position: relative;">
                <div style="display: flex; align-items: center; gap: 8px;">
                    <label for="user_id">아이디</label>
<!--                    <button type="button" onclick="checkId()" class="check-btn">중복 확인</button>-->
                </div>
                <input type="text" name="user_id" id="user_id" required>
                <span id="idCheckMsg"></span>
            </div>

            <div class="form-row">
                <label for="password">암호</label>
                <div class="pw-wrap">
                    <input type="password" name="password" id="password" required>
                    <i class="fa fa-eye toggle-pw"></i>
                </div>
            </div>

            <div class="form-row">
                <label for="passwordCheck">암호 확인</label>
                <div class="pw-wrap">
                    <input type="password" name="passwordCheck" id="passwordCheck" required>
                    <i class="fa fa-eye toggle-pw"></i>
                </div>
            </div>

            <div class="form-row" style="position: relative;">
                <div style="display: flex; align-items: center; gap: 8px;">
                    <label for="nickname">닉네임</label>
<!--                    <button type="button" onclick="checkNick()" class="check-btn">중복 확인</button>-->
                </div>
                <input type="text" name="nickname" id="nickname" required>
                <span id="nickCheckMsg"></span>
            </div>

            <div class="form-row">
                <label for="phone_number">전화번호</label>
                <input type="text" name="phone_number" id="phone_number" placeholder="010-1234-5678" required>
            </div>

            <div class="form-row">
                <label for="email">이메일</label>
                <input type="text" name="email" id="email" required>
            </div>

            <div class="form-row">
                <label for="address">주소</label>
                <input type="text" name="address" id="address">
            </div>

            <div class="form-row">
                <input type="submit" value="등록">
            </div>
        </form>
    </div>
</body>
</html>