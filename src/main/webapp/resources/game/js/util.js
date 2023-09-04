// 해당 div가 overflow 속성이 있을경우 안에 있는 요소들이 원래 지정한 높이값보다 높아지면 스크롤을 가장 아래로 땡김 
function scrollToBottom(div) {
    div.scrollTo(0, div.scrollHeight);
}

// 윈도우 시작후 ENTER키 이벤트 핸들러 gameBox에 마우스가 올라갈땐 활성화 
gameBox.addEventListener('mouseenter', function () {
    document.addEventListener('keypress', keyPressHandler);
});
// gameBox에서 마우스가 벗어나면 비활성화
gameBox.addEventListener('mouseleave', function () {
    document.removeEventListener('keypress', keyPressHandler);
});

// 클릭 이벤트 핸들러 추가
gameBox.addEventListener('click', function () {
    // keyPressHandler 함수를 클릭 이벤트에서도 호출
    keyPressHandler({ key: 'Enter' });
});

function keyPressHandler(event) {
   const sceneObject = window["scene" + scene];
   if (event.key === 'Enter' && sys_isEnter && isSys && !isAction) {
       scrollToBottom(systemText);
       displayText(sceneObject);
   } else if (event.key === 'Enter' && sys_isEnter && !isSys && isAction) {
       scrollToBottom(systemText);
       createAction(sceneObject);
   }
}

function itemListOpen() {
    $('.items').toggle(300);
}

function zoomClick() {
	$('#zoom').hide(0);
    $('#zoom > img').hide(0);
}

// 시스템에 찍힐때 대사 닉네임 이미지 다 없애는 함수
function clean() {
    if(document.querySelector("#systemText").lastChild != null){
        let lastPtag = document.querySelector("#systemText").lastChild.textContent;
        if(lastPtag.substring(lastPtag.length-1,lastPtag.length) == '▼'){
            document.querySelector("#systemText").lastChild.textContent = 
                lastPtag.substring(0,lastPtag.length-1); 
        }   
    }
    document.querySelector("#systemZoomTextBox").textContent = "";
    document.querySelector("#char_Nick").innerHTML = "";
    const profile = document.querySelector("#char_Image");
    profile.style.backgroundImage = '';
}

function loadingStart() {
   document.querySelector("#loading").style.display = 'block';
}

function loadingEnd() {
    document.querySelector("#loading").style.display = 'none';
}

function audioClean() {
	audio.pause();
	bgmAudio.play();
}

function subGameEnd() {
	document.querySelector("#sub_game").remove();
	subGameBox.style.dispaly = "none";
	gameBox.style.display = "block";
	scene++;
	const sceneObject = window["scene"+scene];
	displayText(sceneObject);
}
