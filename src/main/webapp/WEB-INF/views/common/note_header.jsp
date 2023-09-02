<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/style.css">
<style>
	body {
		background-image: url("${path}/resources/back.png");
		background-size: cover;
	}
</style>
<title>note header</title>
<head>

	<div id="memberBox">
	<c:choose>
	    <c:when test="${not empty sessionScope.userInfo}">
	       <h1>안녕하세요, ${userInfo.nname} 님</h1>
	       <c:choose>
	            <c:when test="${userInfo.nname eq 'ADMIN'}">
	                <a href="<c:url value='/note/note?id=${userInfo.id}'/>" target="_blank" 
	                				onclick="window.open(this.href, 'popupWindow',
	                				'width=800,height=600'); return false;">메세지 |</a>
              	     <a href="<c:url value='/note/noteWrite?id=${userInfo.id}'/>"
	                				onclick="window.open(this.href, 'popupWindow',
	                				'width=800,height=600'); return false;">작성하기 </a>
	            </c:when>
	            <c:otherwise>
	                <a href="<c:url value='/note/note?id=${userInfo.id}'/>" target="_blank" 
	                				onclick="window.open(this.href, 'popupWindow',
	                				'width=800,height=600'); return false;">메세지 |</a>
             		<a href="<c:url value='/note/noteWrite?id=${userInfo.id}'/>"
	                				onclick="window.open(this.href, 'popupWindow',
	                				'width=800,height=600'); return false;">작성하기 </a>
	            </c:otherwise>
	         </c:choose>
	    </c:when>
	 </c:choose>
	</div>
	
    <!-- logo image -->
    <div id="logoBox">
		<a>
		    <img src="${path}/resources/images/headerIMG/logo_black.png" id="logo_image">
		</a>
	</div>

 <script>
	const invalidate = "${requestScope.invalidate}";
	if(invalidate != ''){
		alert('로그아웃 되었습니다.');
		location.href='<c:url value="/login/login"/>';
	}
</script>