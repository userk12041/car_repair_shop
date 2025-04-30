<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>리뷰 작성</title>
</head>
<body>
    <h3>리뷰 작성</h3>
    <form action="/review/save" method="post">
        <input type="hidden" name="repairShopId" value="${param.shopId}" />
        <div>
            평점:
            <select name="rating">
                <option value="5">★★★★★</option>
                <option value="4">★★★★</option>
                <option value="3">★★★</option>
                <option value="2">★★</option>
                <option value="1">★</option>
            </select>
        </div>
        <div>
            내용:<br/>
            <textarea name="content" rows="5" cols="40" required></textarea>
        </div>
        <div style="margin-top: 10px;">
            <button type="submit">등록</button>
        </div>
    </form>
</body>
</html>
