<link rel="stylesheet" href="../resources/css/common.css">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../common/header.jsp" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="../resources/css/modify.css">
<div class="mainWrap">
	
    <h1>수정 페이지</h1>
    
    <section class="wrap">
		<form action="modify" method="post">	
			<table class="modify">
				<tr>
					<td>회원번호</td>
					<td>
					<input type="text" name="idn" value ="${member.idn}" readonly/>
					</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td>
					<input type="text" name="id" value ="${member.id}" readonly/>
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td>
					<input type="text" name="idn" value ="${member.name}" readonly/>
					</td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td>
					<input type="text" name="nname" value ="${member.nname}" required />
					</td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
					<input type="text" name="gender" value ="${member.gender}" required/>
				</tr>
				<tr>
					<td>이메일</td>
					<td>
					<input type="text" name="email" value ="${member.email}" required />
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<c:url value="/index.jsp" var="index"/>
						<input type="button" onclick="location.href='${pageContext.request.contextPath}/user/user?id=${member.id}';" value="수정하기" />
				</tr>
			</table>
		</form>
		
		
		</section>
</div>
<jsp:include page="../common/footer.jsp" />