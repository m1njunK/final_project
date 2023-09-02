<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../common/note_header.jsp" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="../resources/css/note.css">
<div class="contentWarp" id ="mainWarp">
<h1>쪽지 상세 보기</h1>
<hr/>

<div class="noteDetail">
    <h2>제목 : ${note.title}</h2> <br/>
    <div class="fromId">
    <p>보낸 사람: ${note.from_Id}</p> <br/>
    </div>
    <div class="main">
    <p>${note.content}</p> <br/>
    </div>
    <div class="toId">
    <p>받은 사람: ${note.to_Id}</p>
    </div>
</div>

<div id="modifyWarp">
<button class="link-button"><a href="<c:url value='/note/note?id=${userInfo.id}'/>">메세지함으로 돌아가기</a></button> <br/>
<button><a href="<c:url value='/note/noteReply?id=${userInfo.id}&from=${note.from_Id}'/>">답장하기</a></button>
</div>

</div>

<jsp:include page="../common/footer.jsp" />
