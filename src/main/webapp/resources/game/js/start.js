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
}; 
