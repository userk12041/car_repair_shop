<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.review-box {
    margin-bottom: 15px;
    padding: 10px;
    border-bottom: 1px solid #ccc;
}
.review-header {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 16px;
}
.stars {
    color: gold;
    font-size: 16px;
}
.review-date {
    font-size: 12px;
    color: gray;
}
.review-content {
    margin-top: 5px;
    font-size: 14px;
}
</style>

<h2>리뷰 목록</h2>




<c:forEach var="review" items="${reviewList}">
    <div class="review-box">
        <div class="review-header">
            <strong>${review.userId}</strong>
            <span class="stars">
                <c:forEach begin="1" end="5" var="i">
                    <c:choose>
                        <c:when test="${i <= review.rating}">★</c:when>
                        <c:otherwise>☆</c:otherwise>
                    </c:choose>
                </c:forEach>
            </span>
            <span class="review-date">
                (<fmt:formatDate value="${review.createdAt}" pattern="yyyy-MM-dd" />)
            </span>
        </div>
        <div class="review-content">
            ${review.content}
        </div>
    </div>
</c:forEach>