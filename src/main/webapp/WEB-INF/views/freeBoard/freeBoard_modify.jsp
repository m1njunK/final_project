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
    <form id="createForm" action="modify_submit" method="post">
    	<input type="hidden" name="bno" value="${post.bno}"/>
    	<ul>
	        <li>
	        	제목:<input type="text" id="title" name="title" value="${post.title}" required>
        	</li>
			<li>
				작성자:<input type="text" value='${userInfo.nname}' disabled>
				<input type="hidden" id="auth" name="auth" value='${userInfo.nname}'>
			</li>
	        <li id="content">
	        	내용:<textarea id="editor" name="content">${post.content}</textarea>
        	</li>
        	<li id="btn">
	        	<input type="submit" value="작성">
	        </li>
        </ul>
    </form>   
</div>
<script src="https://cdn.tiny.cloud/1/txisexjqogc2o5hq1mpsl5obcf0exfbgxj0f053sshq2xiu1/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
<script>
let plugins = ["link" ,"image"];
let edit_toolbar = "blocks fontfamily fontsize | link image forecolor backcolor"

tinymce.init({
	language : "ko_KR",
	selector: '#editor',
	menubar : false,
	plugins: plugins,
	height: 600,
	  toolbar: edit_toolbar,
	  image_title: true,
	  automatic_uploads: true,
	  file_picker_types: 'image',
	  file_picker_callback: (cb, value, meta) => {
	    const input = document.createElement('input');
	    input.setAttribute('type', 'file');
	    input.setAttribute('accept', 'image/*');

	    input.addEventListener('change', (e) => {
	      const file = e.target.files[0];

	      const reader = new FileReader();
	      reader.addEventListener('load', () => {
	        const id = 'blobid' + (new Date()).getTime();
	        const blobCache =  tinymce.activeEditor.editorUpload.blobCache;
	        const base64 = reader.result.split(',')[1];
	        const blobInfo = blobCache.create(id, file, base64);
	        blobCache.add(blobInfo);
	        cb(blobInfo.blobUri(), { title: file.name });
	      });
	      reader.readAsDataURL(file);
	    });
	    input.click();
	  },
	  content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:16px }'
	});
</script>
<jsp:include page="../common/footer.jsp" />