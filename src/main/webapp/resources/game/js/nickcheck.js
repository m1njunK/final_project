const pattern =  /^[ㄱ-ㅎ가-힣a-zA-Z0-9]+$/;
var nick;

function nickCheck(){
  const inputField = document.getElementById("nickCheck");
  if(pattern.test(inputField.value) && inputField.value.length > 2){
  	document.querySelector("#gameBox").style.display = 'block';
  	document.querySelector("#itemBox").style.display = 'block';
	document.querySelector("#start_1").remove();
    	nick = inputField.value;
	getScene();
	displayText(scene1);
  }else{
	  alert('닉네임을 다시 확인해주시기 바랍니다.');
  }
}

document.getElementById("nickCheck").onkeypress = (e) => {
  if (e.key === 'Enter') {
    nickCheck();
  }
};

document.getElementById("checkBtn").onclick = () => {
  nickCheck();
};
