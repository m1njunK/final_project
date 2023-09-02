<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&family=Shadows+Into+Light&display=swap');
  .mainWrap{
			background-image: url('resources/images/back-3.png');
			background-size: cover;
			filter:brightness(0.9);
  }
  .main_button{
  	text-shadow: -1px 0px black, 0px 1px black, 1px 0px black, 0px -1px black;
 	font-family: 'Shadows Into Light', ursive;width: 70%;height: 40%;background: #ffffff00;font-size: 200px;color: #b22828;margin-top: 15%;
	background: #ffffff42;
    border-radius: 10px;
    box-shadow: 2px 2px 2px 2px #060606a8;
  	transition: transform 0.2s ease-in-out;
  }
  .main_button:hover {
    transform: scale(1.05);
}
</style>
<!-- css파일은 header에서 불러옵니다!! -->
<jsp:include page="common/header.jsp" />

<div class="mainWrap" style=
 					"background-image: url('resources/images/back-3.png');
 					background-size: cover;
 					filter:brightness(0.9);" >
	<form action="game/start" method="post" >
		<button type="submit" class="main_button">GAME START</button>
	</form>
</div>
<jsp:include page="common/footer.jsp" />