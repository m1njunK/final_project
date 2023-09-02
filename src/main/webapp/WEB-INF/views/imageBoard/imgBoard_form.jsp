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
    	<h1>게시글작성</h1>
		<hr/>
	</div>
    <form id="createForm" action="create" method="post">
    	<ul>
	        <li>
	        	제목:<input type="text" id="title" name="title" required>
        	</li>
			<li>
				작성자:<input type="text" value='${userInfo.nname}' disabled>
				<input type="hidden" id="auth" name="auth" value='${userInfo.nname}'>
			</li>
	        <li id="content">
	        	<textarea id="editor" name="content"></textarea>
        	</li>
        	<li id="btn">
	        	<input id="submitBtn" type="submit" value="작성완료"/>
	        </li>
        </ul>
    <input type="hidden" name="imageURL" id="path" value="">
    </form>  
	<div id="imageList" class="hidden">
	    <h3>잠깐! 썸네일 이미지를 선택해주세요!</h3>
	    <div id="selectImage">
	    
	    </div>
	    <button id="checkBtn">적용완료!</button>
	</div>
</div>
<script>
	var contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/resources/js/upload.js"></script>
<script src="https://cdn.tiny.cloud/1/txisexjqogc2o5hq1mpsl5obcf0exfbgxj0f053sshq2xiu1/tinymce/6/tinymce.min.js"></script>
<script>
let plugins = ["link" ,"image"];
let edit_toolbar = "blocks fontfamily fontsize | image forecolor backcolor"

tinymce.init({
	language : "ko_KR",
	selector: '#editor',
	height: 600,
	menubar : false,
	plugins: plugins,
	toolbar: edit_toolbar,
	image_title: true,
	automatic_uploads: true,
	images_upload_url: "/project/boardUpload",
	file_picker_types: 'image',
	file_picker_callback: (cb, value, meta) => {
	    const input = document.createElement('input');
	    input.setAttribute('type', 'file');
	    input.setAttribute('accept', 'image/*');
	    input.addEventListener('change', (e) => {
	    	const file = e.target.files[0];
	  		const maxSize = 10485760; // 10MB
	  		if (!file.type.startsWith("image/")) {
	        	alert("이미지 파일만 업로드해주세요!");
	        	return;
	        }
	  		if(file.size > maxSize){
				alert("파일 용량이 너무 큽니다.");
	  			return;
	  		}
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
	  language: 'ko_KR',
	  setup: function (editor) {
	    editor.on('change', function (e) {
	      editor.save();
	    });
	  },
	  content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:16px }'
	});
</script>
<script>
function displayImageList(images) {
    const imageListDiv = document.getElementById('selectImage');
    
    imageListDiv.innerHTML = '';
    
    images.forEach(image => {
        const imgSrc = image.getAttribute('src');
        const imgTitle = image.getAttribute('alt');
        
        const thumbnailBox = document.createElement('div');
        thumbnailBox.className = 'thumbnailBox';
        thumbnailBox.style.margin = '20px';
        
        const thumbnailImage = document.createElement('img');
        thumbnailImage.src = imgSrc;
        thumbnailImage.alt = imgTitle;
        thumbnailImage.style.maxWidth = '100%';
        thumbnailImage.style.height = 'auto';
        
        thumbnailBox.appendChild(thumbnailImage);
        imageListDiv.appendChild(thumbnailBox);
    });
}
</script>
<script>
	let selectedThumbnailInfo = null;
	
	$("#checkBtn").on("click",function(event){
		$("#imageList").toggle("slow");	
		$("#submitBtn").prop("disabled",false);
	});
	
	$("#submitBtn").on("click",function(event){
		let form = $("#createForm");
		event.preventDefault();
		if($("#path").val() == ''){
			$("#imageList").toggle("slow");
		    const imagesInEditor = tinymce.activeEditor.contentDocument.querySelectorAll('img');
		    displayImageList(imagesInEditor);
		    $(this).prop("disabled",true);
		}else{
			form.submit();
		}
	});
	$(document).on("click", ".thumbnailBox", function() {
	    $(".thumbnailBox").css("border", "none");
	    $(this).css("border", "5px solid #b4d7ff");
		selectedThumbnailInfo = $(this).find("img").attr("src");
		$("#path").val(selectedThumbnailInfo);
	});
</script>

<jsp:include page="../common/footer.jsp" />