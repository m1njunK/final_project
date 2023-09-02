<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../common/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<style>
body {
		background-image: url("${path}/resources/images/test/back.png");
		background-size: cover;
		background-position-x: 15%;
	}
</style>
<link rel="stylesheet" href="../resources/css/join.css">
<script>
function joincheck() {
	var confirmPassword = document.forms["join_form"]["confirmPassword"].value;
    var agree = document.forms["join_form"]["agree"].value;
    var birthYear = document.getElementById("year").value;
    var birthDay = document.getElementById("day").value;
    
	var password = $("input[name='pass']").val();
    var confirmPassword = $("input[name='confirmPassword']").val();
    
    if (birthYear.length !== 4) {
        alert("년도는 4자리로 입력해주세요.");
        return false;
    }

    if (birthDay.length > 2) {
        alert("일은 최대 2자리로 입력해주세요.");
        return false;
    }
    
    if (password.length < 8) {
        alert("비밀번호는 최소 8자 이상이어야 합니다.");
        return false;
    }
    
    if (password !== confirmPassword) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
    }
    
    if (agree !== "Y") {
        alert("개인정보 처리방침에 동의해야 가입할 수 있습니다.");
        return false;
    }
}
</script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	window.onload = ()=>{
		$("#submitBtn").on("click",function(){
			let day = $("#day").val();
			if(day.length == 1){
				day = '0'+day;
			}
			let date = $("#year").val() + '-' + $("#month").val().replace('월','') + '-' + day;
			console.log(date);
			let mail = $("#mail1").val() + $("#mail2").val();
			$('input[name="birthdate"]').val(date);
			$('input[name="email"]').val(mail);
			$('form').submit();
		});
		
	   	$("#nname").on('keydown', function(e) {
	        if (e.keyCode === 13) { 
	            e.preventDefault(); 
	            $("#check").click();
	        }
	    });
	   	
		$("#check").on("click",function(){
			let nname = $("#nname").val();
			let check = $("#checkNick");
			
			if(nname.trim() === ''){
				check.text('사용하실 닉네임을 입력해 주세요');
				check.css('color','red');
				return;
			}
 			$.ajax({
				type : "POST",
				url : "checkNickName",
				data : {"nname" : nname},
				dataType : "text",
				success : function(data){
					if(data === "OK"){
						check.text('사용가능한 닉네임 입니다.');
						check.css('color','blue');
					}else{
						check.text('이미 사용중인 닉네임 입니다.');
						check.css('color','red');	
					}
				},
				error : function(){
					alert('잘못된 요청입니다!');
				}
			})
		});
	}
</script>
    <form id="join_form" method="post" action="join" onsubmit="return joincheck()"> 
        <div id="enter1">
            <div id="content">
                <div class="enter2">
                    <strong>아이디</strong>
                    <div style="margin-top: 10px;">
                        <span class="box1">
                            <input type="text" name="id" placeholder="아이디" class="int" required>
                        </span>
                    </div>
                    <br><br>
                    <strong>닉네임</strong> 
                    <div style="margin-top: 10px; text-align:right">
                        <span class="box1">
                            <input type="text" name="nname" id="nname" placeholder="닉네임" class="int">
                        </span>
                        <span id='checkNick'></span>
                        <input type="button" value="중복확인" id='check'/>
                    </div>
                    <br><br>
                    <strong>비밀번호</strong>
                    <div style="margin-top: 10px;">
                        <span class="box2">
                        <input type="password" name="pass" placeholder="8-10자 사이의 대,소문자를 구분해서 작성해주세요" class="int">
                        </span>
                    </div>
                    <br><br>
                    <strong>비밀번호 재확인</strong>
                    <div style="margin-top: 10px;">
                        <span class="box2">
                        <input type="password" name="confirmPassword" placeholder="비밀번호 재확인" class="int">
                        </span>
                    </div>
                </div>
                <br><br>
                <strong>이메일</strong>
                <input type="hidden" name="email">
                <div class="enter2">
                    <div class="mail">
                        <strong></strong>
                        <div class="mail1">
                            <span class="box3">
                                <input type="text" placeholder="이메일" class="email" id="mail1">
                            </span>
                        </div>
                        &nbsp;
                        <div class="mail2">
                            <span class="box3">
                                <select class="email" id="mail2">
                                    <option>선택</option>
                                    <option>@naver.com</option>
                                    <option>@daum.net</option>
                                    <option>@gmail.com</option>
                                    <option>@hanmail.com</option>
                                    <option>직접입력</option>
                                </select>
                            </span>
                        </div>
                    </div>
                    <br><br>
                    <strong>이름</strong>
                    <div style="margin-top: 10px;">
                        <span class="box2">
                            <input type="text" name="name" placeholder="성함" class="int">
                        </span>
                    </div>
                    <br><br>
                    <strong>생년월일</strong>
                    <div id="birth">
                    	<input type="hidden" name="birthdate">
                        <div id="birth_yy" style="padding-left: 0px;">
                            <span class="box4">
                                <input type="text" placeholder="년(4자)" id="year" class="int2">&nbsp;
                            </span>
                        </div>
                        <div id="birth_mm">
                            <span class="box4">
                                <select name="year" placeholder="월" id="month" class="int2">
                                    <option>01월</option>
                                    <option>02월</option>
                                    <option>03월</option>
                                    <option>04월</option>
                                    <option>05월</option>
                                    <option>06월</option>
                                    <option>07월</option>
                                    <option>08월</option>
                                    <option>09월</option>
                                    <option>10월</option>
                                    <option>11월</option>
                                    <option>12월</option>
                                </select>
                                &nbsp;
                            </span>
                        </div>
                        <div id="birth_dd">
                            <span class="box4">
                                <input type="text" placeholder="일" id="day" class="int2">
                            </span>
                        </div>
                    </div>
                </div>
                <br><br>
                <span>
                    <div class="enter3">
                        <select name="gender" placeholder="성별">
                            <option>성별</option>
                            <option>남성</option>
                            <option>여성</option>
                            <option>선택안함</option>
                        </select>
                     </div>
                    </span>
                    <br><br>
                    개인정보 처리방침 동의여부 :&nbsp;
                    <input type="radio" name="agree" value="Y">동의 &nbsp;
                    <input type="radio" name="agree" value="N">비동의
                    <br><br>
                   	<div>
                   		<div class="element">
                            <button type="button" id="submitBtn">계정생성</button> 
                        </div>
                    </div>
                </div>
            </div>
        </form>
				
<jsp:include page="../common/footer.jsp" />