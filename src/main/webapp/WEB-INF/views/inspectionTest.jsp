<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Inspection Center List</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h2>검사소 리스트</h2>

<button id="syncBtn">동기화</button>

<table border="1" style="margin-top: 10px;">
    <thead>
    <tr>
        <th>ID</th>
        <th>이름</th>
        <th>주소(도로명)</th>
        <th>전화번호</th>
        <th>등록일</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="item" items="${inspectionCenters}">
        <tr>
            <td>${item.id}</td>
            <td>${item.name}</td>
            <td>${item.road_address}</td>
            <td>${item.tel}</td>
            <td>${item.registration_date}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<script>
    $('#syncBtn').click(function() {
        $.ajax({
            url: '/inspection',
            type: 'GET',
            success: function(response) {
                alert('동기화 완료!');
                location.reload(); // 동기화 후 페이지 새로고침하여 최신 데이터 표시
            },
            error: function() {
                alert('동기화 중 오류가 발생했습니다.');
            }
        });
    });
</script>

</body>
</html>
