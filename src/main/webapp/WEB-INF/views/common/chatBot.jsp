<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<link rel="stylesheet" href="${path}/resources/game/css/chatBot.css" />
<div id="openChatBot">도우미<br>키기</div>
<div id="chatBotBox">
	<div id="closeChatBot"></div>
	<h1 style="text-align:center;">도우미입니다. 무엇이든 물어보세요</h1>
	<div id="chatBotText">
	</div>
	<div id="chatBotClient">
		<input type="text" id="chatPrompt" autocomplete="off"/>
		<div id="chatBotBtn">보내기</div>
	</div>
</div>
<script>
	let apiKey;
	let ENDPOINT;
	
	document.querySelector("#openChatBot").addEventListener("click",() => {
		document.querySelector("#chatBotBox").style.display = 'block';
		document.querySelector("#openChatBot").style.display = 'none';
	});
	
	document.querySelector("#closeChatBot").addEventListener("click",() => {
		document.querySelector("#chatBotBox").style.display = 'none';
		document.querySelector("#openChatBot").style.display = 'block';
	});
	
	document.querySelector("#chatBotBtn").addEventListener("click", () => {
	    handleChat();
	});

	document.querySelector("#chatPrompt").addEventListener("keydown", (e) => {
	    if (e.key === "Enter") {
	        handleChat();
	    }
	});

	function handleChat() {
		const chatPromptInput = document.querySelector("#chatPrompt");
	    const prompt = chatPromptInput.value;
	    const trimPrompt = prompt.trim();
	    chatPromptInput.disabled = true;
	    
	    if (trimPrompt != '') {
	    	document.querySelector("#chatPrompt").value = "";
	    	switch(prompt){
	    		case '공지사항' :
	    			location.href = '${path}/notice/noticeList';
	    			break;
	    		case '채팅' :
	    			location.href = '${path}/chat/chatRoom';
	    			break;
	    		case '이미지게시판' :
	    		case '이미지' :
	    			location.href = "${path}/imageBoard/imgBoard_list";
	    			break;
	    		case '자유게시판' :
	    		case '자게' :
	    			location.href = "${path}/freeBoard/freeBoard_list";
	    			break;
	    		case 'QNA' :
	    		case '질문' :
	    		case 'qna' :
	    			location.href = "${path}/qna/qnaPage";
	    			break;
	    		case '내정보' :
	    		case '마이페이지' :
	    			location.href = "${path}/user/user?id=${userInfo.id}";
	    			break;
	    		default :
	    			generateText(prompt);
	    			appendMyText(prompt);
	    			break;
	    	}
	    }
	}
	
	function getKey(){
		let xhr = new XMLHttpRequest();
		let url = '/project/getKey';
		xhr.onreadystatechange = function() {
			if(xhr.readyState === XMLHttpRequest.DONE) {
				if(xhr.status === 200){
					const result = xhr.responseText.split(',');
					apiKey = result[0];
					ENDPOINT = result[1];
				}
			}
		}
		
		xhr.open('GET',url,true);
		xhr.send();
	}
	
	getKey();
</script>
<script src="/project/resources/js/AI.js"></script>