<link rel="stylesheet" href="../resources/css/common.css">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../common/header.jsp" />
<div class="mainWrap">
	<div id="titleBox">
    	<h1>회원정보 관리</h1>
		<hr/>
	</div>
<section class="wrap">
	<table class="info" id="userInfo">
		<tr>
			<th class='th'>회원번호</th>
			<td>
				<span class="math-inline">${member.idn}</span>
			</td>
		</tr>
		<tr>
			<th class='th'>아이디</th>
			<td>${member.id}</td>
		</tr>
		<tr>
			<th class='th'>이름</th>
			<td>${member.name}</td>
		</tr>
		<tr>
			<th class='th'>닉네임</th>
			<td>${member.nname}</td>
		</tr>
		<tr>
			<th class='th'>성별</th>
			<td>${member.gender}</td>
		</tr>
		<tr>
			<th class='th'>생년월일</th>
			<td>${member.birthdate}</td>
		</tr>
		<tr>
			<th class='th'>이메일</th>
			<td>${member.email}</td>
		</tr>
		<tr>
			<td colspan=2>
				<input type="button" value="수정하기" onclick="location.href='${pageContext.request.contextPath}/management/modify?id=${member.id}'"/>
				<input type="button" onclick="withdraw('${member.id}');" value="회원강퇴" />
			</td>
		</tr>
	</table>
</section>
</div>

<script>
	function withdraw(id) {
		if (id == 'admin') {
			alert('관리자 계정은 삭제할 수 없습니다.');
			return;
		}
		if (confirm('정말로 탈퇴 하시겠습니까?')) {
			location.href = '<c:url value="/user/withdraw"/>?id='+ id;
		}
	}
</script>
<jsp:include page="../common/footer.jsp" />