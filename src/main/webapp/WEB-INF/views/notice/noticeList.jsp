<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="../common/header.jsp" />
<link rel="stylesheet" href="../resources/css/notice.css">

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
	<div class="noticeList">
		<c:choose>
			<c:when test="${!empty noticeList}">
				<table>
					<colgroup>
						<col style="width:55%"/>
						<col style="width:15%"/>
						<col style="width:15%"/>
						<col style="width:15%"/>
					</colgroup>
			        	<tr>
			            	<th>제목</th>
			            	<th>작성자</th>
			            	<th>최종수정일</th>
			            	<th>조회수</th>
			        	</tr>
			        <!-- 고정 공지 출력 for문 -->
			        <c:forEach items="${fixedNoticeList}" var="con">
			            <tr class="fixedContent">
			                <td><a href="noticeDetail?bno=${con.bno}" class="noticeHyper">[ 고정 ] ${con.title}</a></td>
			                <td>
								<c:choose>
									<c:when test="${con.auth eq 'admin'}">
										관리자
									</c:when>
									<c:otherwise>
										${con.auth}
									</c:otherwise>
								</c:choose>
							</td>
			                <td><fmt:formatDate value="${con.updatedate}" type="date" dateStyle="short"/></td>
			                <td>${con.vcnt}</td>
			            </tr>
			        </c:forEach>
			        <!-- 공지 전체 출력 for문 -->
			        <c:forEach items="${noticeList}" var="con">
			            <tr class="noticeContent">
			                <td><a href="noticeDetail?bno=${con.bno}" class="noticeHyper">${con.title}</a></td>
			                <td>
			               		 <c:choose>
									<c:when test="${con.auth eq 'admin'}">
										관리자
									</c:when>
									<c:otherwise>
										${con.auth}
									</c:otherwise>
								</c:choose>
			                </td>
			                <td><fmt:formatDate value="${con.updatedate}" type="date" dateStyle="short"/></td>
			                <td>${con.vcnt}</td>
			            </tr>
			        </c:forEach>
			    </table>
			    <br/>
   	    		 <c:if test="${!empty pm and pm.maxPage > 1}">
			        <div class="pagination">
			               
			               <tr>
			                   <th colspan="3">
			                       <c:if test="${pm.first}">
			                           <a href="noticeList?page=1">&laquo;</a>
			                       </c:if>
			                       <c:if test="${pm.prev}">
			                           <a href="noticeList?page=${pm.startPage-1}">&lt;이전</a>
			                       </c:if>
			                       <c:forEach var="i" begin="${pm.startPage}" end ="${pm.endPage}">
			                           <a href="noticeList${pm.mkQueryStr(i)}">${i}</a>
			                       </c:forEach>
			                       <c:if test="${pm.next}">
			                           <a href="noticeList?page=${pm.endPage+1}">다음&gt;</a>
			                       </c:if>
			                       <c:if test="${pm.last}">
			                           <a href="noticeList?page=${pm.maxPage}">&raquo;</a>
			                       </c:if>
			                   </th>
			               </tr>
			        </div>
		   		 </c:if>
			</c:when>
			<c:otherwise>
				<h3>공지가 작성되지 않았습니다.</h3>
			</c:otherwise>
		</c:choose>
	<hr/>  
	<div id="content_bot"> 
	    <div class="searchBar">
	        <table>
	            <tr>
	                <td>
	                    <select id="option" name="searchType">
	                        <option value="all">전체</option>
	                        <option value="title">제목</option>
	                        <option value="content">내용</option>
	                    </select>
	                    <input type="text" name="searchValue" id='searchValue'>
	                    <button type="button" id="searchBtn" name="search">검색</button>
	                    <button type="button" id="searchCancleBtn" name="searchCancle">검색 취소</button>
	                </td>
	            </tr>
	        </table>
	    </div>
    </div>
		
	</div>
</div>

<script>
/* 작업 수행 결과 출력 */
var resultMessage = "${result}"; // 서버에서 전달된 메시지
if (resultMessage !== "") {
    alert(resultMessage); // 메시지 팝업 표시
}
$("#searchBtn").on("click",function(){
	let option = $('select').val();
	let value = $('#searchValue').val();
	location.href = "noticeList?searchValue="+value+"&searchType="+option;
});
$("#searchCancleBtn").on("click",function(){
	location.href = "noticeList";
});

$("input[name='searchValue']").on('keydown', function(e) {
    if (e.keyCode === 13) {
        e.preventDefault(); 
        $("#searchBtn").click();
    }
});
</script>

<jsp:include page="../common/footer.jsp" />