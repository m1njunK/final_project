<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="${path}/resources/game/css/newsPaper.css">
<h1 id="endTitle">축하합니다 ! 게임이 끝났습니다 !</h1>
<div id="endBox">
	<div id="endClose"></div>
		<div id="endHome">홈으로 돌아가시겠습니까?
			<div id="endBtn">예</div> / 
			<div id="endXBtn">아니오</div>
		</div>
	<div id="newsPaper">
		<div id="newsTitle">속보 ! 마이크가 빛나는 별의 도둑들을 잡다</div>
		<div id="newsProfile">
			<div id="newsMike"></div>
			<div id="newsWigoAndEmily"></div>
		</div>
	</div>
</div>
<script>
	var contextPath = location.pathname.split('/')[1];
	
	document.querySelector("#endClose").addEventListener("click",()=>{
		if(document.querySelector("#endHome").style.display == 'block'){
			document.querySelector("#endHome").style.display = 'none';
		}else{
			document.querySelector("#endHome").style.display = 'block';		
		}
	});
	
	document.querySelector("#endBtn").addEventListener("click",()=>{
		location.href = '/'+contextPath;
	});
	
	document.querySelector("#endXBtn").addEventListener("click",()=>{
		document.querySelector("#endHome").style.display = 'none';
	});
</script>