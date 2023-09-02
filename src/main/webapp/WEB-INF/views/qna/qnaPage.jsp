<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="../common/header.jsp" />
<link rel="stylesheet" href="../resources/css/qna.css">
<div class="mainWrap">
	<div class="title">
		<h1>자주 들어오는 질문</h1>
	</div>
	<div class="newQnaBtn">
		<c:choose>
			<c:when test="${userInfo.id eq 'admin'}">
				<form action="newQna" method="Get" >
					<input type="submit" value="새로운 QnA 작성하기" class="newBtn">
				</form>
			</c:when>
		</c:choose>
	</div>
	<hr/>
	<div class="qnaList">
		<c:choose>
			<c:when test="${!empty qnaList}">
				<table>
			        <c:forEach items="${qnaList}" var="con">
			        	<tr class="qnaTitle">
			            	<th>
			            	<div class="editQnaBtn">
								<c:choose>
									<c:when test="${userInfo.id eq 'admin'}">
										<form action="editQna" method="GET" >
										 	<input type="hidden" name="qnaId" value="${con.qnaId}">
											<input type="submit" value="QnA 수정" class="editBtn">
										</form>
									</c:when>
								</c:choose>
							</div>
			            	Q. ${con.questionTitle}
			            	</th>
			        	</tr>
			            <tr class="qnaContent" style="display:none;">
			                <td>A. ${con.questionContent}</td>
			            </tr>
			            <tr class="blank_tr">
			            	<td class="blank_td"></td>
			            </tr>
			        </c:forEach>
			    </table>
			</c:when>
			<c:otherwise>
				<h3>자주 물어보는 질문과 답변을 준비 중입니다 ...</h3>
			</c:otherwise>
		</c:choose>
	
		
	</div>
</div>

<script>
/* mainWrap사이즈 조절 */
 var mainWrap = document.querySelector('.mainWrap');

// 내부 컨텐츠 크기를 측정
var contentHeight = mainWrap.scrollHeight;

// 요소의 크기를 내부 컨텐츠 크기에 맞게 조절
mainWrap.style.height = contentHeight + 'px';
 
 
$(document).ready(function() {
    $(".qnaList table tr th").click(function() {
        var contentRow = $(this).closest("tr").next(".qnaContent");
        contentRow.slideToggle("fast", function() {
            if (contentRow.is(":visible")) {
                adjustBodyHeight(contentRow.outerHeight());
            } else {
                resetBodyHeight(contentRow.outerHeight());
            }
        });
    });

    function adjustBodyHeight(newHeight) {
        $(".mainWrap").css("height", "+=" + newHeight);
    }

    function resetBodyHeight(newHeight) {
        $(".mainWrap").css("height", "-=" + newHeight);
    }
});
/* 작업 수행 결과 출력 */
var resultMessage = "${result}"; // 서버에서 전달된 메시지
if (resultMessage !== "") {
    alert(resultMessage); // 메시지 팝업표시
}
</script>

<jsp:include page="../common/footer.jsp" />