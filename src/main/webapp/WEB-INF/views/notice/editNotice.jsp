<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../common/header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="../resources/css/notice.css">
<c:set var="path" value="${pageContext.request.contextPath}"/>
<div class="mainWrap">
    <h1>글 수정</h1>
    <hr/>
    <form action="editNotice" method="post" id="editform">
   		<%-- <input type="hidden" name="uno" value="${userInfo.uno}"/> --%>
    	<input type="hidden" id="bno" name="bno" value="${vo.bno}" required><br>
        <label for="title">제 &nbsp; 목</label>
        <input type="text" id="title" name="title" value="${vo.title}" required><br>
		<label for="auth">작성자</label>
        <input type="text" id="auth" name="auth" value="${vo.auth}" required readonly><br>
        <label for=fixedNotice>공지 상단 고정</label><br> 
        <input type="radio" name="fixedNotice" id ="fixedNoticeT" value="true" ${vo.fixedNotice eq true ? 'checked="checked"' : ''}/> &nbsp;
        <label for="fixedNoticeT" class="fixBtn"> 고정  </label> &nbsp;
        <input type="radio" name="fixedNotice" id ="fixedNoticeF" value="false" ${vo.fixedNotice eq false ? 'checked="checked"' : ''}/> &nbsp;
        <label for="fixedNoticeF" class="fixBtn"> 미고정  </label><br> 
        <textarea id="content" name="content">${vo.content}</textarea><br>
        <input type="button" value="작성" id="addBtn">
		<div>
			<label>FILE DROP HERE</label>
			<div class="fileDrop">
			
			</div>
			<div>
				<!-- 첨부파일 목록 추가 -->
				<ul class="uploadList">
					<c:if test="${!empty vo.files}">
						<c:forEach var="file" items="${vo.files}">
							<li data-src='${file}'>
								<c:choose>
									<c:when test="${fn:contains(file,'s_')}">
										<!-- 이미지 파일 -->
										<img class="attachmentImg" src='${path}/displayFile?fileName=${file}'/>
										<div>
											<a href='${path}/displayFile?fileName=${fn:replace(file,"s_","")}' target='blank'>
												${fn:substringAfter(fn:replace(file,"s_",""),'_')}
											</a>
										</div>
									</c:when>
									<c:otherwise>
										<!-- 일반 파일 -->
										<img class="attachmentImg" src='${path}/resources/images/img/file.png'/>
										<div>
											<a href='${path}/displayFile?fileName=${file}'>
												${fn:substringAfter(file,'_')}
											</a>
										</div>
									</c:otherwise>
								</c:choose>
								<div>
									<a href="${file}" class='delBtn'>[X]</a>
								</div>
							</li>
						</c:forEach>
					</c:if>
				</ul>
			</div>
		</div>
		</div>
	</form>
</div> 
<div class="separate"> </div>

	<script src="https://cdn.tiny.cloud/1/txisexjqogc2o5hq1mpsl5obcf0exfbgxj0f053sshq2xiu1/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
	<script>
	let plugins = ["link" ,"image"];
	let edit_toolbar = "blocks fontfamily fontsize | link image forecolor backcolor"
	tinymce.init({
		language : "ko_KR",
		selector: '#content',
		width : 600,
		height: 500,
		menubar : false,
		plugins: plugins,
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
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script>
  	var contextPath = '${pageContext.request.contextPath}';
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/upload.js"></script>
  <script>
  	// file drop 파일 첨부
  	$(".fileDrop").on("dragenter dragover" , function(e){
  		e.preventDefault();
  	});
  	
  	$(".fileDrop").on("drop", function(event){
  		event.preventDefault();
  		
  		let files = event.originalEvent.dataTransfer.files;
  		console.log(files);
  		
  		let maxSize = 10485760; // 10MB
  		
  		let formData = new FormData();
  		
  		for(let i = 0; i < files.length; i++){
  			if(files[i].size > maxSize){
  				alert("파일 용량이 너무 큽니다.");
  				return;
  			}
  			formData.append("file",files[i]);
  		}
  		
  		$.ajax({
  			type : "POST",
  			data : formData,
  			processData : false,
  			contentType : false,
  			url : contextPath+"/uploadFile",
  			dataType : "json",
  			success : function(data){
  				// upload 된 파일 이름 목록을 list로 전달
  				console.log(data);
  				
  				for(let i = 0; i < data.length; i++){
  					console.log(data[i]);
  					let fileInfo = getFileInfo(data[i]);
  					console.log(fileInfo);
  					// upload 된 파일 게시글 작성 페이지에 출력
  					let html = "<li>";
  					html += "<img class='attachmentImg' src='"+fileInfo.imgSrc+"' alert='attachment'/>";
  					html += "<div>";
  					html += "<a href='"+fileInfo.getLink+"' target='_blank'>";
  					html += fileInfo.fileName
  					html += "<a/>";
  					html += "</div>"
					html += "<div>";
					// fullName
					html += "<a href='"+data[i]+"' class='delBtn'>[X]</a>";
					html += "</div>"
  					html +=	"</li>";
  					$(".uploadList").append(html);
  				}
  			}
  		});
  	}); // file drop upload end
  	
  	var arr = [];
  	
  	// 첨부파일 삭제
  	$(".uploadList").on("click",".delBtn",function(event){
  		event.preventDefault();
  		// event가 발생한 a tag 요소
  		let target = $(this);
  		// target 요소의 속성값 href == fullName
  		let fullName = target.attr("href");
  		arr.push(fullName);
	  	// 선택자로 지정된 가장 가까운 부모요소를 검색
  		target.closest("li").remove();
  	});
  	
  	$("#addBtn").on("click",function(){
  		
  		let str = "";
  		let title = $('#title').val();
		let content = tinymce.activeEditor.getContent();
		if(title.trim() == ''){
			alert('제목을 입력하세요!');
			return;
		}
		if(content.length < 1){
			alert('내용을 입력하세요!');
			return;
		}
  		console.log("click");
  		let fileList = $(".uploadList .delBtn");
  		
  		console.log(fileList);
  		
  		$(fileList).each(function(){
  			str += "<input type='hidden' name='files' value='"+$(this).attr("href")+"'/>";
  		});
  		$("#editform").append(str);
  		
  		$.post(contextPath+"/deleteAllFiles",{files : arr}, function(data){
  			alert(data);
  		})
  		
  		$("#editform").submit();
  	});
  	
  </script>	

<jsp:include page="../common/footer.jsp" />