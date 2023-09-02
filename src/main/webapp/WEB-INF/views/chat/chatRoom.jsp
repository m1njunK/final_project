<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="../resources/css/chat.css">
    <div class="mainWrap">
        <div id="titleBox">
            <h1>채팅</h1>
            <hr/>
        </div>
        <c:choose>
            <c:when test="${!empty chatRoom}">
	            <div id="chatList" class="centered">
	                <c:forEach items="${chatRoom}" var="room">
	                    <div class="chatRoomBox">
	                        <a href="joinChat?roomNum=${room.roomNum}">
	                            ${room.roomNum}번방
	                        </a>
	                        <h4>방장 : ${room.owner}</h4>
	                        <h4>접속인원 : ${room.participant.size()}명</h4>
	                    </div>
	                </c:forEach>
	            </div>
            </c:when>
            <c:otherwise>
                <h1>아직 생성된 방이 없군요! 방을 만들어서 채팅을 나눠보세요!</h1>
            </c:otherwise>
        </c:choose>
        <hr/>
        <button class="createButton" onclick='create()'>방만들기</button>
    </div>
<script>
	let id = '${userInfo}' == '';
	function create(){
		if(id){
			alert('로그인 후 이용해 주세요!');
			return;
		}
		location.href="/project/chat/create";
	}
	$(".chatRoomBox").on("click",function(){
		if(id){
			alert('로그인 후 이용해 주세요!');
			return;		
		}
		location.href = $(this).find('a').attr('href');
	});
</script>
<jsp:include page="../common/footer.jsp" />