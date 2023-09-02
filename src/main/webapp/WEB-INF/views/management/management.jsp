<link rel="stylesheet" href="../resources/css/common.css">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<jsp:include page="../common/header.jsp" />

<div class="mainWrap">
	<div id="titleBox">
    	<h1>관리자 페이지</h1>
		<hr/>
	</div>
    <table>
        <thead>
            <tr>
                <th>회원번호</th>
                <th>아이디</th>
                <th>이름</th>
                <th>닉네임</th>
                <th>성별</th>
                <th>생년월일</th>
                <th>이메일</th>
                <th>멤버관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${members}" var="member">
                <tr class="memberInfo">
                    <td>${member.idn}</td>
                    <td>${member.id}</td>
                    <td>${member.name}</td>
                    <td>${member.nname}</td>
                    <td>${member.gender}</td>
                    <td>${member.birthdate}</td>
                    <td>${member.email}</td>
                    <td>
                        <a href="detail?id=${member.id}">상세보기</a>
                    </td>
                 </tr>
            </c:forEach>
        </tbody>
    </table>    
	
</div>

<jsp:include page="../common/footer.jsp" />
<script>
	$(".memberInfo").on("click",function(){
		location.href = $(this).find('a').attr('href');
	})
</script>
