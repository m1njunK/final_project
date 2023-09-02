<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="../common/header.jsp" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="../resources/css/board.css">
<script>
	window.onload = ()=>{
		let msg = '${msg}';
		if(msg != ''){
			alert(msg);
		}
		$("input[name='writeBtn']").on("click",function(){
			let loginCheck = '${userInfo.id}' != '';
			if(!loginCheck){
				alert('로그인 후 이용해주세요!');
				return;
			}else{
				location.href = "imgBoard_form";
				console.log("???");
			}
		})
		$("#searchBtn").on("click",function(){
			let option = $('select').val();
			let value = $('#searchValue').val();
			if(value.trim() == ''){
				alert('검색어를 입력하세요!');
				return;
			}
			location.href = "imgBoard_list?searchValue="+value+"&searchType="+option;
		});
	    $("input[name='searchValue']").on('keydown', function(e) {
	        if (e.keyCode === 13) {
	            e.preventDefault(); 
	            $("#searchBtn").click();
	        }
	    });
	}
    function triggerLinkClick(bno) {
        var link = document.querySelector('#click'+bno);
        if (link) {
            link.click();
        }
	}
</script>
<div class="mainWrap">
	<div id="titleBox">
	    <h1>갤러리</h1>
	    <hr/>
    </div>
    <div class="imgBoardContainer">
        <c:choose>
            <c:when test="${!empty imgBoardList}">
                <div class="imgBoardGrid">
                    <c:forEach items="${imgBoardList}" var="img">
                        <div class="imgBoardContent" onclick="triggerLinkClick(${img.bno})" style="background-image: url(${img.imageURL});">
                            <div class="contentList">
                                <div class="imageBoard">
                                	<div class="title">
                                		<span>${img.title}</span>
	                                    <a href="imgBoard_detail?bno=${img.bno}" id="click${img.bno}"></a>
	                                    <span class="commentCount">
                                        	<c:if test="${img.commentCount > 0}">
                                            	[${img.commentCount}]
                                       		</c:if>
                                   		</span>
	                                	<div class="author">작성자 : ${img.auth}</div>
                                    </div>
                                </div>
                                <div class="boardInfo">
                                    <span class="info"><img src="../resources/images/boardImg/board-time.png"> : <fmt:formatDate value="${img.date}" pattern="yyyy-MM-dd HH:mm" /></span>
                                    <br/>
                                    <span class="info"><img src="../resources/images/boardImg/board-eye.png"> : ${img.vcnt}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <h2>게시글이 존재하지 않습니다.</h2>
            </c:otherwise>
        </c:choose>
    </div>
    
    <c:if test="${!empty pm and pm.maxPage > 1}">
        <div class="pagination">
               <tr>
                   <th colspan="3">
                       <c:if test="${pm.first}">
                           <a href="imgBoard_list?page=1">&laquo;</a>
                       </c:if>
                       <c:if test="${pm.prev}">
                           <a href="imgBoard_list?page=${pm.startPage-1}">&lt;이전</a>
                       </c:if>
                       <c:forEach var="i" begin="${pm.startPage}" end ="${pm.endPage}">
                           <a href="imgBoard_list${pm.mkQueryStr(i)}">${i}</a>
                       </c:forEach>
                       <c:if test="${pm.next}">
                           <a href="imgBoard_list?page=${pm.endPage+1}">다음&gt;</a>
                       </c:if>
                       <c:if test="${pm.last}">
                           <a href="imgBoard_list?page=${pm.maxPage}">&raquo;</a>
                       </c:if>
                   </th>
               </tr>
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
<jsp:include page="../common/footer.jsp" />