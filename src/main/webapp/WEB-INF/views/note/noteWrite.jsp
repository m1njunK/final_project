<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../common/note_header.jsp" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="../resources/css/note.css">

<div id="mainWrap">
	
	<div id=createForm>
	
    <h1>쪽지 보내기</h1>
    
    <form action="${pageContext.request.contextPath}/note/noteWrite" method="post">
        <label for="fromId">보내는 회원</label>
        <input type="text" id="from_Id" name="from_Id" class="height" value="${sessionScope.userInfo.id}" readonly /> <br/>
        <label for="toId">받는 사람</label>
        <input type="text" name="to_Id" class="height" placeholder="받는 사람" /> <br/>
        <label for="title">제목</label>
        <input type="text" name="title" class="height" placeholder="제목" /> <br/>
        <label for="content">내용</label>
      	<textarea id="editor" name="content" class="height" placeholder="내용"></textarea> <br/>
        <input type="submit" value="보내기" />
    </form>
	</div>
</div>

<script src="https://cdn.tiny.cloud/1/txisexjqogc2o5hq1mpsl5obcf0exfbgxj0f053sshq2xiu1/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>

<script>
let plugins = ["link" ,"image"];
let edit_toolbar = "blocks fontfamily fontsize"

tinymce.init({
	language : "ko_KR",
	selector: '#editor',
	height: 500,
	toolbar: edit_toolbar,
	menubar :false,
	  content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:16px }'
	});
</script>

<c:if test="${not empty errorMessage}">
    <p class="error">${errorMessage}</p>
</c:if>
<c:if test="${not empty message}">
    <p class="success">${message}</p>
</c:if>

<jsp:include page="../common/footer.jsp" />