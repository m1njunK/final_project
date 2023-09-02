<link rel="stylesheet" href="../resources/css/common.css">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../common/header.jsp" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="../resources/css/modify.css">

<div class="mainWrap">
	<div id="titleBox">
    <h1>관리자 수정 페이지</h1>
    <hr/>
    </div>
    <section class="wrap">
		<form action="modify" method="post" id="modifyForm">	
			<table class="modify">
				<tr>
					<td>회원번호</td>
					<td>
						${member.idn}
					</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td>
						${member.id}
						<input type="hidden" name="id" value="${member.id}">
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td>
						<input type="text" name="name" value ="${member.name}" required/>
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
						<button id="modSubmit">수정하기</button>
					</td>
				</tr>
			</table>
		</form>
		</section>
</div>
<jsp:include page="../common/footer.jsp" />