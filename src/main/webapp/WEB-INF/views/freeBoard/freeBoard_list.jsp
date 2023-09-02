<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="../resources/css/board.css">
<script>
	let msg = '${msg}';
	if(msg !== ''){
		alert(msg);
	}
</script>
<div class="mainWrap">
    <div id="titleBox">
        <h1>자유게시판</h1>
        <hr/>
    </div>
    <div id="freeBoardWrap">
	    <c:choose>
		    <c:when test="${!empty freeBoardList}">
		    	<table border="1">
		    		<tr>
		    			<th>글번호</th>
    					<th>제목</th>
    					<th>작성자</th>
		    			<th>작성일</th>
		    			<th>조회수</th>
		    		</tr>
		    	<c:forEach items="${freeBoardList}" var="freeBoard">
		    		<tr>
		    			<td>${freeBoard.bno}</td>
		    			<td class="boardTitle">
		    				<a href="freeBoard_detail?bno=${freeBoard.bno}">
		    					${freeBoard.title}
		    					<c:if test="${freeBoard.commentCount > 0}">
		    						[${freeBoard.commentCount}]
		    					</c:if>
		    				</a>
		    			</td>
						<td>${freeBoard.auth}</td>
		    			<td class="date"><fmt:formatDate value="${freeBoard.date}" pattern="yyyy-MM-dd" /></td>
		    			<td>${freeBoard.vcnt}</td>
		    		</tr>
			    </c:forEach>
			    </table>
			    <br/>
		    </c:when>
		    <c:otherwise>
		    	<h2>게시글이 존재하지 않습니다.</h2>
		    </c:otherwise>
	    </c:choose>
   	</div>
	<c:if test="${!empty pm and pm.maxPage > 1}">
		<div class="pagination">
   			<table>
				<tr>
					<td colspan="5">
						<c:if test="${pm.first}">
							<a href="freeBoard_list?page=1">&laquo;</a>
						</c:if>
						<c:if test="${pm.prev}">
							<a href="freeBoard_list?page=${pm.startPage-1}">&lt;</a>
						</c:if>
						<c:forEach var="i" 
								   begin="${pm.startPage}" 
								   end ="${pm.endPage}">
							<a href="freeBoard_list?page=${i}">${i}</a>
						</c:forEach>
						<c:if test="${pm.next}">
							<a href="freeBoard_list?page=${pm.endPage+1}">&gt;</a>
						</c:if>
						<c:if test="${pm.last}">
							<a href="freeBoard_list?page=${pm.maxPage}">&raquo;</a>
						</c:if>
						</td>
					</tr>
			</table>
		</div>
	</c:if>
	<div id="content_bot">
		<hr/>
	    <div class="searchBar">
	        <table>
	            <tr>
	                <td>
	                    <select id="option" name="searchType">
	                        <option value="title">제목</option>
	                        <option value="content">내용</option>
	                        <option value="auth">작성자</option>
	                    </select>
	                    <input type="text" name="searchValue" id='searchValue'><button type="button" id="searchBtn" name="search">검색</button>
	                </td>
	            </tr>
	        </table>
	        <div class="writeButton">
	        	<input type="button" value="글작성하기" name="writeBtn"/>
	    	</div>
	    </div>
    </div>
</div>
<script>
	window.onload = ()=>{
		$(".writeButton").on("click",function(){
			let loginCheck = '${userInfo.id}' != '';
			if(!loginCheck){
				alert('로그인 후 이용해주세요!');
				return;
			}else{
				location.href = "create";
			}
		});
		
		$("#searchBtn").on("click",function(){
			let option = $('select').val();
			let value = $('#searchValue').val();
			if(value.trim() == ''){
				alert('검색어를 입력하세요!');
				return;
			}
			location.href = "freeBoard_list?searchValue="+value+"&searchType="+option;
		});
		
	    $("input[name='searchValue']").on('keydown', function(e) {
	        if (e.keyCode === 13) {
	            e.preventDefault(); 
	            $("#searchBtn").click();
	        }
	    });
	    
	}
</script>
<jsp:include page="../common/footer.jsp" />