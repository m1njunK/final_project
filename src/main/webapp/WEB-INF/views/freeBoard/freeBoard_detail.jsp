<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<jsp:include page="../common/header.jsp" />
<link rel="stylesheet" href="../resources/css/board.css">
<script>
	let msg = '${msg}';
	if(msg !== ''){
		alert(msg);
	}
</script>
	<div id="boardWrap">
		<div id="contentWrap">
			<a href="${path}/freeBoard/freeBoard_list">뒤로가기</a>
		    <h1>${post.title}</h1>
		    <hr/>
		    <p><span>작성자 : ${post.auth}</span></p>
		    <p><span>작성일 : <fmt:formatDate value="${post.date}" pattern="yyyy-MM-dd HH:mm" /></span></p>
		    <p>${post.content}</p>
		    <div id="viewAndMod">
		    	<div id="viewWrap">
				    <span>조회수 : ${post.vcnt}</span>
			    </div>
	   		    <c:if test="${post.auth == userInfo.nname}">
				<div id="modifyWrap">
					<button id="modify_btn">수정</button>
					<button id="delete_btn">삭제</button>
				</div>
				<form id="modifyForm" action="modify" method="post">
					<input type="hidden" name="bno" value="${post.bno}">
				</form>
				</c:if>
			</div>
		</div>	
		<c:if test="${!empty userInfo}">
    		<div id="commentWriteBox">
    			<ul>
    				<li>${userInfo.nname}</li>
    				<li>
    					<input id="commentWriteArea" type="text" name="commentContent" placeholder="댓글을 남겨보세요">
						<input type="hidden" id="commenterID" name="commenterID" value="${userInfo.nname}">
						<input type="hidden" id="bno" name="freeBoardBNO" value="${post.bno}">
   					</li>
    				<li>
    					<button id="commentWrite">등록</button>
    				</li>
    			</ul>
    		</div>
   		</c:if>
	    <div id="commentWrap">
	    	<h4>댓글 목록 : </h4>
			<c:if test="${!empty comments}">
 				<c:forEach var="comment" items="${comments}">
					<div class="commentBox">
						<div id="show${comment.commentID}">
							<ul>
								<li>작성자 : ${comment.commenterID}</li>
								<li>작성일 : <fmt:formatDate value="${comment.commentDate}" pattern="yyyy-MM-dd HH:mm" /></li>
						        <li id="commentContent${comment.commentID}">
						            내 용 : ${comment.commentContent}
						        </li>
							</ul>
							<c:if test="${comment.commenterID == userInfo.nname}">
								<button class="commentModify" data-cno='${comment.commentID}'>
									수정
								</button>
								<button class="commentDelete" data-cno='${comment.commentID}'>
									삭제
								</button>
							</c:if>
						</div>
						<div id="hide${comment.commentID}" style="display: none">
							<ul>
								<li>작성자 : ${comment.commenterID}</li>
								<li>작성일 : <fmt:formatDate value="${comment.commentDate}" pattern="yyyy-MM-dd HH:mm" /></li>
						        <li>
						            내 용 : <input type="text" id="modText${comment.commentID}" value="${comment.commentContent}">
						        </li>
							</ul>
							<button class="modSubmit" data-cno='${comment.commentID}'>
								수정완료
							</button>
							<button class="modCancle" data-cno='${comment.commentID}'>
								취소
							</button>
						</div>
					</div>
				</c:forEach>
	   	    		<c:if test="${!empty pm and pm.maxPage > 1}">
		   	    		<div class="pagination">
							<tr>
								<th colspan="5">
									<c:if test="${pm.first}">
										<a href="?bno=${post.bno}&page=1">&laquo;</a>
									</c:if>
									<c:if test="${pm.prev}">
										<a href="?bno=${post.bno}&page=${pm.startPage-1}">&lt;이전</a>
									</c:if>
									<c:forEach var="i" 
											   begin="${pm.startPage}" 
											   end ="${pm.endPage}">
										<a href="?bno=${post.bno}&page=${i}">${i}</a>
									</c:forEach>
									<c:if test="${pm.next}">
										<a href="?bno=${post.bno}&page=${pm.endPage+1}">다음&gt;</a>
									</c:if>
									<c:if test="${pm.last}">
										<a href="?bno=${post.bno}&page=${pm.maxPage}">&raquo;</a>
									</c:if>
								</th>
							</tr>
						</div>
					</c:if>
				</c:if>
    		</div>
    	</div>
<jsp:include page="../common/footer.jsp" />
<script>

	// 게시글 수정 (게시글작성자 == 로그인멤버)
	$("#modify_btn").on("click",function(e){
		$("#modifyForm").attr("action","modify");
		$("#modifyForm").submit();
	})
	// 게시글 삭제 (게시글작성자 == 로그인멤버)
	$("#delete_btn").on("click",function(e){
		if(confirm('정말로 삭제?')){
			$("#modifyForm").attr("action","remove");
			$("#modifyForm").submit();
		}
	})
	// 댓글 수정(진행중)
	$(".commentModify").on("click",function(){
		let cno = $(this).data('cno');
		console.log(cno);
		$(this).parent("div").hide();
		$("#hide"+cno).show();
	})
	$(".modCancle").on("click",function(){
		let cno = $(this).data('cno');
		$(this).parent("div").hide();
		$("#show"+cno).show();
	})
	$(".modSubmit").on("click",function(){
		let cno = $(this).data('cno');
		let text = $("#modText"+cno).val();
		$.ajax({
			type : "PATCH",
			url : "commentMod",
			data : JSON.stringify({
				commentID : cno,
				commentContent : text
			}),
			dataType : "text",
			contentType : "application/json",
			success : function(data){
				alert(data);
				location.reload();
			}
		});
	});
	// 댓글 삭제
	$(".commentDelete").on("click", function () {
	    let cno = $(this).attr('data-cno');
	    if(confirm("정말로 삭제?")){
	        $.ajax({
	            type: "DELETE",
	            url: "commentDel/"+cno,
	            dataType: "text",
	            contentType : "application/json",
	            success: function (result) {
	                alert(result);
	                location.reload();
	            }
	        });
	    }else{
	    	return;	
	    }
    });
	// 댓글 삽입 요청 처리
	$("#commentWrite").click(function(){
		let auth = $("#commenterID").val();
		let text = $("#commentWriteArea").val();
		let bno = $("#bno").val();
		
		if(text.trim() == ''){
			alert('댓글 내용을 입력하세요!');
			return;
		}
 		$.ajax({
			type : "POST",
			url : "commentWrite",
			data : {
				freeBoardBNO : bno,
				commentContent : text,
				commenterID : auth
			},
			dataType : "text",
			success : function(result){
				alert(result);
				location.reload();
			}
		}); 
	});
	
    $("#commentWriteArea").on('keydown', function(e) {
        if (e.keyCode === 13) { // 13 == enter
            e.preventDefault(); 
            $("#commentWrite").click();
        }
    });
    
</script>