window.onload = () => {

    const content = "최소 3글자 최대 5글자 특수문자는 포함하지 말아주세요.";
    const content2 = "닉네임을 입력해주세요.";
    const text = document.getElementById("typing");
    const text2 = document.getElementById("typing2");

    let i = 0;
    let x = 0;

    function typing() {
        if (i < content.length) {
            text.innerHTML += content.charAt(i);
            i++;
        }
        if (i == content.length) {
            text2.innerHTML += content2.charAt(x);
            x++;
            if (content2.charAt(x) == '.') {
                document.getElementById("nickCheck").removeAttribute("readonly");
            }
        }
    } setInterval(typing, 20)

    // 윈도우 시작후 ENTER키 이벤트 핸들러 gameBox에 마우스가 올라갈땐 활성화 
    gameBox.addEventListener('mouseenter', function () {
        document.addEventListener('keypress', keyPressHandler);
    });
    // gameBox에서 마우스가 벗어나면 비활성화
    gameBox.addEventListener('mouseleave', function () {
        document.removeEventListener('keypress', keyPressHandler);
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
}; 
