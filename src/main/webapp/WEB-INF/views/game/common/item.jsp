<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<!-- start item box -->
  	<div id="itemBox">
       	<ul id="item"><div onclick="itemListOpen();">단 서</div>
          	<li class="items"><img id="inv1" src="${path}/resources/game/subGame/image/key.png" onclick="keyItem();"></li>
            <li class="items"><img id="inv2" src="${path}/resources/game/subGame/image/box.png" onclick="boxItem();"></li>
            <li class="items"><img id="inv3" src="${path}/resources/game/subGame/image/paper.png" onclick="paperItem()"></li>
            <li class="items"><img id="inv4" src="${path}/resources/game/subGame/image/lamp.png" onclick="lampItem()"></li>
            <li class="items"><img id="inv5" src="${path}/resources/game/subGame/image/letter.png" onclick="letterItem()"></li>
            <li class="items"><img id="inv6" src="${path}/resources/game/subGame/image/doc.png" onclick="docItem()"></li>
       	</ul>
    </div> 
<!-- end item box -->