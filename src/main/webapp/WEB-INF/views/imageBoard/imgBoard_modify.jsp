<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../common/header.jsp" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="../resources/css/board.css">
<script>
	let check = '${userInfo.nname}' == '';
	if(check){
		alert('잘못된 접근입니다.');
		location.href = "/project";
	}
</script>
<div id="mainWrap">
	<div id="titleBox">
    	<h1>게시글 수정</h1>
    	<hr/>
   	</div>
    <form id="createForm" action="modify_submit" method="post" enctype="multipart/form-data">
    	<input type="hidden" name="bno" value="${vo.bno}"/>
    	<ul>
	        <li>
	        	제목:<input type="text" id="title" name="title" value="${vo.title}" required>
        	</li>
			<li>
				작성자:<input type="text" value='${userInfo.nname}' disabled>
				<input type="hidden" id="auth" name="auth" value='${userInfo.nname}'>
			</li>
	        <li id="content">
	        	내용:<textarea id="editor" name="content">${vo.content}</textarea>
        	</li>
        	<li id="btn">
	        	<input type="submit" value="작성">
	        </li>
        </ul>
    </form>   
</div>
<script src="https://cdn.tiny.cloud/1/txisexjqogc2o5hq1mpsl5obcf0exfbgxj0f053sshq2xiu1/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
<script>
let plugins = ["link"];
let edit_toolbar = "blocks fontfamily fontsize | forecolor backcolor"

tinymce.init({
	language : "ko_KR",
	selector: '#editor',
	height: 600,
	menubar : false,
	plugins: plugins,
	toolbar: edit_toolbar,
	content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:16px }'
});
</script>
<jsp:include page="../common/footer.jsp" />