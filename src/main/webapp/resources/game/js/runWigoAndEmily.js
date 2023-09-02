const canvasWidth = 960; 
const canvasHeight = 512; 
let map = 'lobby';
let isEnd = false;

const bgImg = new Image();
bgImg.src = "../resources/game/map/lobby.png";
const bgImg2 = new Image();
bgImg2.src = "../resources/game/map/outside.png";
const bgImg3 = new Image();
bgImg3.src = "../resources/game/map/b.png";

class Sprite {
  constructor({ position, image }) {
    this.position = position;
    this.image = image;
  }

  draw() {
    context.drawImage(this.image, this.position.x, this.position.y);
  }
}

const lobby = new Sprite({
  position: {
    x: 90,
    y: -120
  },
  image: bgImg
});

const outside = new Sprite({
  position: {
    x : -885,
    y : 125
  },
  image: bgImg2
});

const bridge = new Sprite({
	position : {
		x : lobby.position.x,
		y : lobby.position.y
	},
	image : bgImg3
});


const rightPlayerImage = [
  "../resources/game/img/game/myke/right0.png",
  "../resources/game/img/game/myke/right1.png",
  "../resources/game/img/game/myke/right2.png",
  "../resources/game/img/game/myke/right3.png",
  "../resources/game/img/game/myke/right4.png"
];

const leftPlayerImage = [
  "../resources/game/img/game/myke/left0.png",
  "../resources/game/img/game/myke/left1.png",
  "../resources/game/img/game/myke/left2.png",
  "../resources/game/img/game/myke/left3.png",
  "../resources/game/img/game/myke/left4.png"
];

const prontPlayerImage = [
  "../resources/game/img/game/myke/pront0.png",
  "../resources/game/img/game/myke/pront1.png",
  "../resources/game/img/game/myke/pront2.png",
  "../resources/game/img/game/myke/pront3.png",
  "../resources/game/img/game/myke/pront4.png"
]

const backPlayerImage = [
  "../resources/game/img/game/myke/back0.png",
  "../resources/game/img/game/myke/back1.png",
  "../resources/game/img/game/myke/back2.png",
  "../resources/game/img/game/myke/back3.png",
  "../resources/game/img/game/myke/back4.png"
]

const colLobby = collisionData.objects.map((obj) => ({
  id: obj.id,
  x: obj.x,
  y: obj.y,
  width: obj.width,
  height: obj.height,
}));

const colOutside = collisionData2.objects.map((obj) => ({
  id: obj.id,
  x: obj.x,
  y: obj.y,
  width: obj.width,
  height: obj.height,
}));

const playerImage = new Image();
playerImage.src = "../resources/game/img/game/myke/pront0.png";

let playerImageIndex = 0;
let imageChangeDelay = 0;

const player = { x: canvasWidth/2, y: canvasHeight/2, speed: 5, width: 48, height: 48 };

function gameLoop() {
  context.clearRect(0, 0, canvas.width, canvas.height);
  
  // 배경 그리기
  if(map == 'lobby') {
    lobby.draw();
  }
	
  if(map == 'outside'){
    outside.draw();
  }

  // 플레이어 그리기
  context.drawImage(playerImage , player.x , player.y , player.width , player.height);
  
  // 플레이어 움직임 처리
  
  // 오른쪽
  if (keys.ArrowRight) {
    const isCol = checkCollision(player, 'right');
    if (!isCol && map == 'lobby') lobby.position.x = lobby.position.x - player.speed;
    if (!isCol && map == 'outside' ) outside.position.x = outside.position.x - player.speed;
    imageChange(rightPlayerImage);
  }
  
  // 왼쪽
  if (keys.ArrowLeft) {
    const isCol = checkCollision(player, 'left');
    if (!isCol && map == 'lobby') lobby.position.x = lobby.position.x + player.speed;
    if (!isCol && map == 'outside' ) outside.position.x = outside.position.x + player.speed;
    imageChange(leftPlayerImage);
  }

  // 위
  if (keys.ArrowUp) {
    const isCol = checkCollision(player, 'up');
    if (!isCol && map == 'lobby') lobby.position.y = lobby.position.y + player.speed;
    if (!isCol && map == 'outside' ) outside.position.y = outside.position.y + player.speed;
    imageChange(backPlayerImage);
  }

  // 아래
  if (keys.ArrowDown) {
    const isCol = checkCollision(player, 'down');
    if (!isCol && map == 'lobby') lobby.position.y = lobby.position.y - player.speed;
    if (!isCol && map == 'outside' ) outside.position.y = outside.position.y - player.speed;
    imageChange(prontPlayerImage);
  }

  if (imageChangeDelay > 0) {
    imageChangeDelay--;
  } 
  
  if(map == 'outside'){
     context.drawImage(bgImg3, outside.position.x , outside.position.y);
  }
  
  // 게임 루프 반복
  if(isEnd){
  	runWigoAndEmilyEnd();
  	return;
  }
  requestAnimationFrame(gameLoop);
}


// 충돌 감지 함수
function checkCollision(player,arrow) {
  const obstacles = (map == 'lobby') ? colLobby : colOutside;
  const bgX = (map == 'lobby') ? lobby.position.x : outside.position.x;
  const bgY = (map == 'lobby') ? lobby.position.y : outside.position.y;
  for (let obj of obstacles) {
    let objX = obj.x * 3 + bgX;
    let objY = obj.y * 3 + bgY;
    switch(arrow){
      case "left" : objX += player.speed; break;
      case "right" : objX -= player.speed; break;
      case "up" : objY += player.speed; break;
      case "down" : objY -= player.speed; break;
    }
    if (
      player.x < objX + obj.width * 3 &&
      player.x + player.width > objX &&
      player.y < objY + obj.height * 3 &&
      player.y + player.height > objY
    ) {
      if(obj.id == 104 && map == 'lobby'){ 
        map = 'outside';
      }
      if(obj.id == 30 && map == 'outside'){
        map = 'lobby';
        lobby.position.x = -960;
        lobby.position.y = -1175;
      }
      if(obj.id == 11 && map == 'outside'){
        isEnd = true;
      }
      return true; // 충돌이 발생했음을 반환
    }
  }
  return false; // 충돌이 발생하지 않음을 반환
}


// 키 입력 상태 저장
const keys = {};

window.addEventListener("keydown", (event) => {
  const arrowKeys = [37, 38, 39, 40];
  if (arrowKeys.includes(event.keyCode)) {
    event.preventDefault();
  }
  keys[event.key] = true;
});

window.addEventListener("keyup", (event) => {
  keys[event.key] = false;
});

function imageChange(playerImageArray) {
  if (imageChangeDelay == 0) {
      imageChangeDelay = 7;
      playerImageIndex = (playerImageIndex + 1) % playerImageArray.length;
      playerImage.src = playerImageArray[playerImageIndex];
  }
};
