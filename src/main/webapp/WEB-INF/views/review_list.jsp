<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>리뷰 목록</h2>

<c:forEach var="review" items="${reviews}">
    <div style="border-bottom:1px solid #ccc; margin-bottom:10px;">
        <strong>작성자:</strong> ${review.userId} <br/>
        <strong>평점:</strong> ${review.rating}점 <br/>
        <strong>내용:</strong> ${review.content} <br/>
        <small>작성일: ${review.createdAt}</small>
    </div>
</c:forEach>

<!-- 페이징 -->
<div>
    <c:forEach var="i" begin="1" end="${totalPages}">
        <c:choose>
            <c:when test="${i == currentPage}">
                <strong>[${i}]</strong>
            </c:when>
            <c:otherwise>
                <a href="/review/list?repairShopId=${repairShopId}&page=${i}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</div>

