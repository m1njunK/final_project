const systemText = document.querySelector("#systemText");
const gameBox = document.querySelector("#gameBox");
const gameBtn = document.querySelector("#gameBtn");
const subGameBox = document.querySelector("#subGameBox");
const systemZoomText = document.querySelector("#systemZoomText");
const systemZoomTextBox = document.querySelector("#systemZoomTextBox");
const endBox = document.querySelector("#endBox");
const bgmAudio = document.getElementById('bgm');
let idx = 0;
let context;
// scene을 구분하는것 ex : 'scene'+scene = scene1; default = 1
let scene = 1; 
// 현재 option을 뭘 골랐는지 구분할 변수
let selNum = 0;
// action중 ALL -> 다보고 넘어가기 위한 변수
let optionCount = 0;
let sceneOptionCount = 0;
// enter로 특정함수를 실행할수있게할 변수 start.js에 25번째줄 부터 보면됨
let sys_isEnter = true;
let isSys = true;
let isAction = false;
let audio;


// introText 타이핑 작업 후 createOptions 함수
function displayText(sceneObject) {
	clean();
	isSys = true;
	const textArray = sceneObject.introText;
	
	if (sceneObject.hasOwnProperty('options') && idx >= textArray.length) {
		idx = 0;
		isSys = false;
		createOptions(sceneObject);
		return;
	} else {
		let line = textArray[idx]; 
		gameTyping(line);
	}

}

function createOptions(sceneObject) {
	clean();
	const option = sceneObject.options;
	const action = sceneObject.action;

	if (!option || option.length === 0) {
		return;
	}

	sys_isEnter = false;
	// SELECT = 여러개의 옵션중 하나만 고르고 다음 씬으로 넘김
	if (action == "SELECT" || action == "END" || action == "GAME") {
	    createOptionButtons(option, () => {
	        document.querySelector("#btnDiv").remove();
	        createAction(sceneObject);
	    });
	}else{
		sceneOptionCount = option.length;
		createOptionButtons(option, () => {
			document.querySelector("#btnDiv").style.display = "none";
	        createAction(sceneObject);
	    });
	}
}

function createAction(sceneObject) {
	clean();
	let gameType = "";
	sys_isEnter = false;
	isAction = true;
	const textArray = sceneObject.options[selNum].actionText;
	const action = sceneObject.action;
	const sound = sceneObject.sound;
	const tagColor = sceneObject.options[selNum].color;

	if(action == 'GAME') gameType = sceneObject.options[selNum].gameType;

	if(action != '' && idx >= textArray.length){
		if (sound !== '') playSound(sound);
		isAction = false;
		isSys = true;
		idx = 0;
		selNum = 0;
		switch(action){
			case 'SELECT' : 	
				scene++;
				const sceneObject = window["scene" + scene];
				displayText(sceneObject);
				break;

			case 'ALL' :
				optionCount++;
				if (optionCount == sceneOptionCount) {
					scene++;
					const sceneObject = window["scene" + scene];
					optionCount = 0;
					document.querySelector("#btnDiv").remove();
					displayText(sceneObject);
				} else {
					isAction = true;
					isSys = false;
					const btns = document.querySelector("#btnDiv");
					btns.style.display = "block";
					scrollToBottom(systemText);
					gameBtn.appendChild(btns);
				}
				break;
			
			case 'GAME' :
				createGame(gameType);
				break;

			case 'END' :
				gameEnd();
				break;
		}
	} else {
		let line = textArray[idx];
		gameTyping(line,tagColor);
	}

};

function playSound(sound) {
	const link = '../resources/game/sound/' + sound + '.mp3';
	audio = new Audio(link);
	if(sound == 'proviso' || sound == 'find') audio.loop = true;
	if(sound != 'door') bgmAudio.pause();
	audio.play();
}

function lineCheck(line) {
	if(line.startsWith(nick+":") || line.startsWith("레베카:") || line.startsWith("카렌:") || 
	   line.startsWith("빅토르:") || line.startsWith("에밀리:")){
	   return true;
	}
	return false;
}

function changeImageAndNick(line){
	const profile = document.querySelector("#char_Image");
	profile.style.backgroundSize = "cover";
	let prefix = "세글자:";

	if (line.startsWith(nick+":")) {
		prefix = nick+":";
		profile.style.backgroundImage = "url('../resources/game/img/mike.png')";
    } else if (line.startsWith("레베카:")) {
		profile.style.backgroundImage = "url('../resources/game/img/rebecca.png')";
    } else if (line.startsWith("빅토르:")) {
		profile.style.backgroundImage = "url('../resources/game/img/victor.png')";
    } else if (line.startsWith("카렌:")) {
		prefix = "두글:";
		profile.style.backgroundImage = "url('../resources/game/img/caren.png')";
    } else if (line.startsWith("에밀리:")) {
		profile.style.backgroundImage = "url('../resources/game/img/emily.png')";
    }
	
	// prefix의 길이만큼 잘라서 이름만 이름칸에 넣어주기
	document.querySelector("#char_Nick").innerHTML = line.substring(0,prefix.length-1);

	return line.substring(prefix.length);
}

// 버튼을 만들어주는 함수
function createOptionButtons(options, callback) {
	const optionButtonWrapper = document.createElement("div");
	optionButtonWrapper.id = "btnDiv";
	gameBtn.appendChild(optionButtonWrapper);

    options.forEach((optionObj, index) => {
        const optionButton = document.createElement("button");
        optionButton.textContent = optionObj.buttonText;

        optionButton.onclick = (e) => {
            e.target.remove();
            document.querySelector("#btnDiv").style.display = "none";
            selNum = index;
            callback(optionObj);
        };

        scrollToBottom(systemText);
        optionButtonWrapper.appendChild(optionButton);
    });
}


// ajax 통신으로 jsp파일 불러와서 subGameBox 안에 생성
function createGame(subGame) {
	loadingStart();
	const sub_game = document.createElement("div");
	const link = '../resources/game/subGame/' + subGame + '.jsp';
	sub_game.setAttribute("id","sub_game");
	gameBox.style.display = "none";
	
	if(subGame == 'proviso'){
		document.querySelector("#docBtn").style.display = 'block';
		document.querySelector("#letterBtn").style.display = 'block';
	}

	setTimeout(function() {
		var xhr = new XMLHttpRequest();
		xhr.open('GET', link, true);
		xhr.onreadystatechange = function () {
			if (xhr.readyState === 4 && xhr.status === 200) {
				loadingEnd();
				sub_game.innerHTML = xhr.responseText;
				if(subGame == 'runWigoAndEmily'){
					canvas = document.querySelector("#gameCanvas");
					context = canvas.getContext("2d");
					gameLoop();
				}
			}
    	};
		xhr.send();
		subGameBox.style.display = "block";
		subGameBox.appendChild(sub_game);
	}, 1500); 
}

// subGame중 단서 찾기가 하나씩 끝날때마다 실행하는중
function findEnding() {
	sys_isEnter = true;
	isAction = false;
	isSys = true;
	audioClean();
	subGameEnd();
}

// subGame중 단서 다 찾은 후 조합 엔딩
function provisoEnding() {
	audioClean();
	subGameEnd();
	document.querySelector("#docBtn").style.display = 'none';
	document.querySelector("#letterBtn").style.display = 'none';
}

function runWigoAndEmilyEnd() {
	audioClean();
	subGameEnd();
}

function gameEnd() {
	gameBox.style.display = 'none';
	document.querySelector("#newsTitle").innerText = "속보 ! "+nick+"가 빛나는 별의 도둑들을 잡다";
	document.querySelector("#endTitle").style.display = 'block';
	endBox.style.display = 'flex';
}

function gameTyping(line){
	gameTyping(line,white);
}

function gameTyping(line,color) {
	const paragraph = document.createElement("p");
	// text에서 캐릭터이름 분리 후 따로 타이핑하기 위한 if문
	let isCheck = false;
	if(lineCheck(line)){
		isCheck = true;
		line = changeImageAndNick(line);
	}else{
		paragraph.style.color = color;
		systemText.appendChild(paragraph); 
	}

	// 타이핑
	let i = 0;
	function typingSys() {
		if (i < line.length) {
			sys_isEnter = false;
			const char = line.charAt(i);
			
			if(isCheck){
				systemZoomTextBox.textContent += char;
			}else{
				paragraph.textContent += char;
				if(i == line.length-1){
					paragraph.textContent += " ▼";
				}
			}

			i++;
			scrollToBottom(systemText);
			setTimeout(typingSys, 10); // 한 글자 출력 간격을 10ms로 설정 (조절 가능)
		} else {
			sys_isEnter = true;
			idx++;
		}
	}

	typingSys();
}
