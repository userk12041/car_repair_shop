<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
  <title>회원 가입</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <style>
    :root {
      --bg-main: #ffffff;
      --text-main: #222222;
      --card-bg: #f9f9f9;
      --card-border: #dddddd;
    }

    body {
      margin: 0;
      padding-top: 100px; /* 헤더 높이 고려 */
      font-family: 'Noto Sans KR', sans-serif;
      background: var(--bg-main);
      color: var(--text-main);
      display: flex;
      flex-direction: column;
      align-items: center;
      min-height: 100vh;
    }
    /* 헤더 */
    #header {
      width: 100%;
      padding: 10px 20px;
      background-color: #ffffff;
      border-bottom: 1px solid #ddd;
      position: fixed;
      top: 0;
      left: 0;
      z-index: 10;

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

    h1 {
      text-align: center;
      margin-bottom: 30px;
      color: var(--text-main);
      font-size: 26px;
    }

    .register-card {
      background: var(--card-bg);
      border: 1px solid var(--card-border);
      border-radius: 12px;
      padding: 30px;
      width: 400px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    }

    .form-row {
      margin-bottom: 18px;
      display: flex;
      flex-direction: column;
      position: relative;
    }

    .form-row label {
      margin-bottom: 6px;
      font-weight: bold;
      color: var(--text-main);
    }

    input[type="text"],
    input[type="password"],
    input[type="submit"] {
      padding: 10px;
      border-radius: 8px;
      border: 1px solid var(--card-border);
      background-color: var(--bg-main);
      color: var(--text-main);
      outline: none;
      box-sizing: border-box;
      transition: border-color 0.2s, box-shadow 0.2s;
    }

    input[type="text"]:focus,
    input[type="password"]:focus {
      border-color: #4CAF50;
      box-shadow: 0 0 5px rgba(76, 175, 80, 0.4);
    }

    input[type="submit"] {
      background-color: #4CAF50;
      color: white;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.2s;
    }

    input[type="submit"]:hover {
      background-color: #43a047;
    }

    .pw-wrap {
      position: relative;
    }

    .pw-wrap i {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
      cursor: pointer;
      color: #aaa;
    }

    .check-btn {
      margin-top: 6px;
      width: 100%;
      padding: 8px;
      font-size: 0.9em;
      background-color: #4CAF50;
      border: none;
      color: white;
      border-radius: 6px;
      cursor: pointer;
    }

    #idCheckMsg, #nickCheckMsg {
      font-size: 0.85em;
      margin-top: 4px;
      height: 16px;
    }

    ::placeholder { color: #aaa; }
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
<h1>회원 가입</h1>
<div class="register-card">
  <form method="post" action="registerOk" onsubmit="return validateForm()">
    <div class="form-row">
      <label for="user_id">아이디</label>
      <input type="text" name="user_id" id="user_id" required>
      <button type="button" onclick="checkId()" class="check-btn">중복 확인</button>
      <span id="idCheckMsg"></span>
    </div>

    <div class="form-row">
      <label for="password">비밀번호</label>
      <div class="pw-wrap">
        <input type="password" name="password" id="password" required>
        <i class="fa fa-eye toggle-pw"></i>
      </div>
    </div>

    <div class="form-row">
      <label for="passwordCheck">비밀번호 확인</label>
      <div class="pw-wrap">
        <input type="password" name="passwordCheck" id="passwordCheck" required>
        <i class="fa fa-eye toggle-pw"></i>
      </div>
    </div>

    <div class="form-row">
      <label for="nickname">닉네임</label>
      <input type="text" name="nickname" id="nickname" required>
      <button type="button" onclick="checkNick()" class="check-btn">중복 확인</button>
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

<!--   <div class="form-row">
     <label for="address">주소</label>
     <div style="display: flex; align-items: center;">
       <input type="text" name="address" id="address" readonly placeholder="주소 검색 후 자동 입력">
       <button type="button" onclick="openKakaoPostcode()" class="check-btn" style="margin-left: 10px;">주소 검색</button>
     </div>
   </div>-->
   <!--test-->
   <div class="form-row">
      <label for="address">주소</label>
        <div class="col-sm-6 mb-3 mb-sm-0">
            <input type="text" class="form-control form-control-user"
                   id="zipCode" name="zipCode" placeholder="우편번호" readonly onclick="sample4_execDaumPostcode()">
        </div>
       <div class="form-group">
           <input type="text" class="form-control form-control-user" id="address" name="address" placeholder="도로명 주소" readonly>
       </div>
       <div class="form-group">
           <input type="text" class="form-control form-control-user" id="detailaddress" name="detailaddress" placeholder="상세 주소" onclick="addrCheck()">
       </div>
   </div>
    <div class="form-row">
      <input type="submit" value="등록">
    </div>
  </form>
</div>

<script>
  let isIdChecked = false;
  let lastCheckedId = "";
  let isNickChecked = false;
  let lastCheckedNick = "";

  function checkId() {
    const userId = $("#user_id").val().trim();
    const msgEl = $("#idCheckMsg");

    if (!userId) {
      msgEl.text("아이디를 입력하세요.").css("color", "red");
      isIdChecked = false;
      return;
    }

    $.ajax({
      url: "/idCheck",
      method: "GET",
      data: { user_id: userId },
      success: function (res) {
        if (res === "usable") {
          msgEl.text("사용 가능한 아이디입니다.").css("color", "green");
          isIdChecked = true;
          lastCheckedId = userId;
        } else {
          msgEl.text("이미 사용 중인 아이디입니다.").css("color", "red");
          isIdChecked = false;
        }
      },
      error: function () {
        msgEl.text("서버 오류 발생").css("color", "red");
        isIdChecked = false;
      }
    });
  }

  function checkNick() {
    const nickname = $("#nickname").val().trim();
    const msgEl = $("#nickCheckMsg");

    if (!nickname) {
      msgEl.text("닉네임을 입력하세요.").css("color", "red");
      isNickChecked = false;
      return;
    }

    $.ajax({
      url: "/nickCheck",
      method: "GET",
      data: { nickname: nickname },
      success: function (res) {
        if (res === "usable") {
          msgEl.text("사용 가능한 닉네임입니다.").css("color", "green");
          isNickChecked = true;
          lastCheckedNick = nickname;
        } else {
          msgEl.text("이미 사용 중인 닉네임입니다.").css("color", "red");
          isNickChecked = false;
        }
      },
      error: function () {
        msgEl.text("서버 오류 발생").css("color", "red");
        isNickChecked = false;
      }
    });
  }

  // 비밀번호 보기 toggle
  $(document).ready(function () {
    $('.toggle-pw').on('click', function () {
      const input = $(this).prev('input');
      const type = input.attr('type') === 'password' ? 'text' : 'password';
      input.attr('type', type);
      $(this).toggleClass('fa-eye fa-eye-slash');
    });
  });

  // 선택 사항: 폼 제출 시 중복 체크 여부 확인
  function validateForm() {
    const userId = $("#user_id").val().trim();
    const nickname = $("#nickname").val().trim();

    if (!isIdChecked || userId !== lastCheckedId) {
      alert("아이디 중복 확인을 완료해주세요.");
      return false;
    }

    if (!isNickChecked || nickname !== lastCheckedNick) {
      alert("닉네임 중복 확인을 완료해주세요.");
      return false;
    }

    return true;
  } 
</script>

<script>
    function sample4_execDaumPostcode(){
        new daum.Postcode({
            oncomplete: function(data) {
               // 우편번호
                $("#zipCode").val(data.zonecode);
                // 도로명 및 지번주소
                $("#address").val(data.roadAddress);
            }
        }).open();
    }
</script>
<script type="text/javascript">
    function addrCheck() {
        if($("#zipCode").val() == '' && $("#streetAdr").val() == ''){
            alert("우편번호를 클릭하여 주소를 검색해주세요.");
            $("#zipCode").focus();
        }
    }
</script>


</body>
</html>
