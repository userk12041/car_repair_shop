<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>정비소 신청</title>
	<link crossorigin="anonymous" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
		  integrity="sha384-..." rel="stylesheet" />
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>

	<!-- 상단 홈으로 돌아가기 버튼 -->
	<a href="/main" class="btn btn-outline-dark position-absolute" style="top: 20px; left: 20px; z-index: 1000;">
		← 메인으로
	</a>
	
	<div class="container my-5" style="max-width: 600px;">
		<h2 class="mb-4 text-center">정비소 등록 신청</h2>
	
		<form action="/repairShop/request" method="post">
			<div class="mb-3">
				<label for="name" class="form-label">정비소 이름</label>
				<input type="text" class="form-control" name="name" id="name" required>
			</div>
	
			<div class="mb-3">
			    <label for="road_address" class="form-label">도로명 주소</label>
			    <input type="text" class="form-control" name="road_address" id="road_address" placeholder="클릭하여 주소 검색" readonly onclick="sample4_execDaumPostcode()">
			</div>

			<div class="mb-3">
			    <label for="lot_address" class="form-label">지번 주소</label>
			    <input type="text" class="form-control" name="lot_address" id="lot_address" readonly>
			</div>
	
			<div class="mb-3">
				<label for="tel_number" class="form-label">전화번호</label>
				<input type="text" class="form-control" name="tel_number" id="tel_number">
			</div>
	
			<div class="mb-3">
				<label for="open_time" class="form-label">영업 시작시간</label>
				<input type="text" class="form-control" name="open_time" id="open_time" placeholder="예: 09:00">
			</div>
	
			<div class="mb-4">
				<label for="close_time" class="form-label">영업 종료시간</label>
				<input type="text" class="form-control" name="close_time" id="close_time" placeholder="예: 18:00">
			</div>
	
			<div class="text-center">
				<button type="submit" class="btn btn-primary">신청 제출</button>
			</div>
		</form>
	</div>
	<script>
	    function sample4_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                document.getElementById('road_address').value = data.roadAddress;
	                document.getElementById('lot_address').value = data.jibunAddress;
	            }
	        }).open();
	    }
	</script>
</body>
</html>
