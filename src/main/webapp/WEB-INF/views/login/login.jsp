<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="../resources/css/login.css">
<%
String message = (String) request.getAttribute("message");
if (message != null) {
  out.println("<script>");
  out.println("alert('" + message + "');");
  out.println("</script>");
}
%>
  <section id="side_logo"></section>
  
    <section class="login-form">
      <br><br><br>
        <img alt="form_logo" src="../resources/images/headerIMG/logo_black.png" class="form_logo">
        <form action="login" id="login" method="post">
            <div class="int-area">
                <input type="text" name="id" id="id" autocomplete="off" required>
                <label for="id">ID</label>
            </div>
            <div class="int-area">
                <input type="password" name="pass" id="pass" autocomplete="off" required>
                <label for="pw">PASSWORD</label>
            </div>
            <div class="login_btn">
                <input type="checkbox" name="autoLogin" id="autoLogin">
      			<label for="autoLogin">자동 로그인</label>
                <button id="btn" type="submit">로그인</button>
            </div>
        </form>
        <div class="caption">
            <a href="${pageContext.request.contextPath}/">홈으로</a>
            <a href="${pageContext.request.contextPath}/join/join">회원가입</a>
        </div>
    </section>