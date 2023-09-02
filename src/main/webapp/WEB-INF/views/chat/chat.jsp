<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<link rel="stylesheet" href="../resources/css/chat.css">
<div class="mainWrap">
	<div id="titleBox">
		<h1>${roomNum}번 채팅방</h1>
		<hr/>
	</div>
	<div class="container chat-container">
		<div>
	        <div id="msgArea" class="col chat-message-area">
	
	        </div>
	        <hr/>
			<div class="col-12 input-col">
			<div class="input-group mb-3">
				<input type="text" id="msg" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
				<div class="input-group-append">
					<button class="btn btn-primary" type="button" id="button-send">전송</button>
				</div>
			</div>
			</div>
		</div>
		<div class="col-6">
		</div>
	</div>
	<div id="userList">
		<h4>참가자 목록</h4>
		<hr/>
		<ul>
			
		</ul>
	</div>
</div>
<script type="text/javascript">

//전송 버튼 누르는 이벤트
$("#button-send").on("click", function(e) {
	if($('#msg').val() == ''){
		alert('전송할 메세지를 입력하라');
		return;
	}
	sendMessage();
	$('#msg').val('')
});

$("#msg").keydown(function(event) {
    if (event.which === 13) {
        event.preventDefault();
        $("#button-send").click();
    }
});

// 접속할주소 설정
var id = '${userInfo.nname}'

if(id == ''){
	alert('로그인 후 이용하시오.');
	location.href='/project/login/login';
}

var room = '${roomNum}';


var serverAddress = '/project/chat';
var sock = new SockJS(serverAddress);

sock.onmessage = onMessage;
sock.onclose = onClose;
sock.onopen = onOpen;

function sendMessage() {
	sock.send(room+":"+id+":"+$("#msg").val());
}
//서버에서 메시지를 받았을 때
function onMessage(msg) {
	
	var data = msg.data;
	var sessionId = null; //데이터를 보낸 사람
	var message = null;
	
	var arr = data.split(":");
	
	var cur_session = id; //현재 세션에 로그인 한 사람

	if(arr.length == 1){
		sessionId = "MASTER";
		message = arr[0];
	}else{
		sessionId = arr[0];
		message = arr[1];			
	}
	
	if(arr[0] === "USERS"){
		updateUserList(arr[1]);
		console.log('바로 이곳!!');
		return;
	}
	
    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
    if (sessionId == cur_session) {
        var str = "<div class='col-12' style='text-align : right;'>";
        str += "<div class='alert alert-secondary message-bubble'>"; // 여기에 'message-bubble' 클래스 추가
        str += "<b>" + '나' + " : " + message + "</b>";
        str += "</div></div>";
        $("#msgArea").append(str);
    } else {
        var str = "<div class='col-12'>";
        str += "<div class='alert alert-warning message-bubble' style='text-align : left;'>"; // 여기에 'message-bubble' 클래스 추가
        str += "<b>" + sessionId + " : " + message + "</b>";
        str += "</div></div>";
        $("#msgArea").append(str);
    }
	
    var msgArea = document.getElementById("msgArea");
    msgArea.scrollTop = msgArea.scrollHeight;
    
    
}
//채팅창에서 나갔을 때
function onClose(evt) {
	var user = id;
	var str = user + " 님이 퇴장하셨습니다.";
	$("#msgArea").append(str);
}
//채팅창에 들어왔을 때
function onOpen(evt) {
	if(room==''){
		alert('비정상적인 접근입니다.');
		location.href = "chatRoom";
	}
	sock.send('ENTER:'+room+':'+id);
	getUsers();
}

//GET_USERS 요청에 대한 처리
function getUsers() {
    sock.send('GET_USERS:' + room);
}

// 유저 리스트 업데이트 처리 함수
function updateUserList(userListStr) {
    var userList = userListStr.split(",");
    $("#userList ul").empty(); // 기존 리스트 지우기

    userList.forEach(function (user) {
        $("#userList ul").append("<li>" + user + "</li>");
    });
}
</script>
<jsp:include page="../common/footer.jsp" />