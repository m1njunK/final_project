<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="../common/header.jsp" />
<link rel="stylesheet" href="../resources/css/notice.css">
<c:set var="path" value="${pageContext.request.contextPath}"/>
<style>
	*{
		margin:0;
		padding:0;
	}
	/* 이미지 최대 크기 제한 */
	img{
		max-width:100%;
		height: auto;
	}
</style>

<div class="mainWrap">
	<div class="noticeTitle">
		<h1>공지사항</h1>
		
	</div>
	<div class="newNotice">
		<c:choose>
			<c:when test="${userInfo.id eq 'admin'}">
				<form action="newNotice" method="Get" >
					<input type="submit" value="공지사항 작성하기" class="newBtn">
				</form>
			</c:when>
		</c:choose>
	</div>
	<hr/>
	<div class="noticeDetail">
		<div class="backBtnDiv">
			<a href="${path}/notice/noticeList" class="backBtn">[목록으로]</a>
		</div>
		    <span class="nameSpace">제목</span> <span class="space">&nbsp;&nbsp;&nbsp;${vo.title}</span>
		    <span class="nameSpace">작성자</span>
			    <c:choose>
					<c:when test="${vo.auth eq 'admin'}">
						<span class="space">&nbsp;&nbsp;&nbsp;관리자</span>
					</c:when>
					<c:otherwise>
						<span class="space">&nbsp;&nbsp;&nbsp;${vo.auth}</span>
					</c:otherwise>
				</c:choose>
		    <span class="nameSpace">최종수정일</span> <span class="space">&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${vo.updatedate}" type="both" dateStyle="full"/></span>
		    <br/>${vo.content}
		    
		  

		    
		    <div class="countDiv">
			    <span class="nameSpace">조회수</span><br/><div class="viewDiv"><b>${vo.vcnt}</b></div>
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
					</li>
				</c:forEach>
			</c:if>
		</ul>	
	</div>
	<div class="separate"> </div>
			<div class="backBtnDiv">
				<a href="${path}/notice/noticeList" class="backBtn">[목록으로]</a>
			</div>
		    <c:choose>
			<c:when test="${userInfo.id eq 'admin'}">
				<form action="editNotice" method="Get"  id="editNoticeform">
					<input type="hidden" name="bno" value="${vo.bno}"/> 
					<input type="submit" value="편집하기" id="editBtn">
					<input type="button" value="삭제하기" id="delBtn">
					
				</form>
			</c:when>
		</c:choose>
	</div>
	<c:if test="${!empty userInfo}">
    		<div id="commentWriteBox">
    			<ul>
    				<li>${userInfo.nname}</li>
    				<li>
    					<input id="commentWriteArea" type="text" name="commentContent" placeholder="댓글을 남겨보세요">
						<input type="hidden" id="commenterID" name="commenterID" value="${userInfo.nname}">
						<input type="hidden" id="bno" name="noticeBNO" value="${vo.bno}">
   					</li>
    				<li>
    					<button id="commentWrite">등록</button>
    				</li>
    			</ul>
    		</div>
   		</c:if>
	    <div id="commentWrap">
	    	<h4>댓글 목록</h4>
			<c:if test="${!empty comments}">
 				<c:forEach var="comment" items="${comments}">
					<div class="commentBox">
						<div id="show${comment.commentNO}">
							<ul>
								<li>작성자 : ${comment.commenterID}</li>
								<li>작성일 : <fmt:formatDate value="${comment.commentDate}" pattern="yyyy-MM-dd HH:mm" /></li>
						        <li id="commentContent${comment.commentNO}">
						            내 용 : ${comment.commentContent}
						        </li>
							</ul>
							<c:if test="${comment.commenterID == userInfo.nname}">
								<button class="commentModify" data-cno='${comment.commentNO}'>
									수정
								</button>
								<button class="commentDelete" data-cno='${comment.commentNO}'>
									삭제
								</button>
							</c:if>
						</div>
						<div id="hide${comment.commentNO}" style="display: none">
							<ul>
								<li>작성자 : ${comment.commenterID}</li>
								<li>작성일 : <fmt:formatDate value="${comment.commentDate}" pattern="yyyy-MM-dd HH:mm" /></li>
						        <li>
						            내 용 : <input type="text" id="modText${comment.commentNO}" value="${comment.commentContent}">
						        </li>
							</ul>
							<button class="modSubmit" data-cno='${comment.commentNO}'>
								수정완료
							</button>
							<button class="modCancle" data-cno='${comment.commentNO}'>
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
								<a href="?bno=${vo.bno}&page=1">&laquo;</a>
							</c:if>
							<c:if test="${pm.prev}">
								<a href="?bno=${vo.bno}&page=${pm.startPage-1}">&lt;</a>
							</c:if>
							<c:forEach var="i" 
									   begin="${pm.startPage}" 
									   end ="${pm.endPage}">
								<a href="?bno=${vo.bno}&page=${i}">${i}</a>
							</c:forEach>
							<c:if test="${pm.next}">
								<a href="?bno=${vo.bno}&page=${pm.endPage+1}">&gt;</a>
							</c:if>
							<c:if test="${pm.last}">
								<a href="?bno=${vo.bno}&page=${pm.maxPage}">&raquo;</a>
							</c:if>
						</th>
					</tr>
				</div>
			</c:if>
			</c:if>
    	</div>
</div>

<script>
/* 작업 수행 결과 출력 */
var resultMessage = "${result}"; // 서버에서 전달된 메시지
if (resultMessage !== "") {
    alert(resultMessage); // 메시지 팝업 표시
}
function adjustMainWrapSize() {
    // 요소 가져오기
    var noticeDetail = document.querySelector('.noticeDetail');
    var mainWrap = document.querySelector('.mainWrap');
    var commentWrap = document.querySelector('#commentWrap');
    // 높이 가져오기
    var noticeDetailHeight = noticeDetail.offsetHeight;
    var commentWrapHeight = commentWrap.offsetHeight;
    // .mainWrap의 높이 설정
    mainWrap.style.height = (noticeDetailHeight + commentWrapHeight + 600) + 'px';
}

// 함수 호출
adjustMainWrapSize();

</script>
<script>
	// 게시글 삭제 (게시글작성자 == 로그인멤버)
	$("#delBtn").on("click",function(e){
		if(confirm('정말로 삭제하시겠습니까?')){
			$("#editNoticeform").attr("action","deleteNotice");
			$("#editNoticeform").submit();
		}
	})
	// 댓글 수정(진행중)
	$(".commentModify").on("click",function(){
		console.log("클릭!1");
		let cno = $(this).data('cno');
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
				commentNO : cno,
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
				noticeBNO : bno,
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

<jsp:include page="../common/footer.jsp" />