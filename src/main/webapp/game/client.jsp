<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>오목 게임</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }
    canvas {
        border: 1px solid #000;
        cursor: pointer;
        background-color: yellow;
    }
    .button-group {
        margin-top: 10px;
    }
</style>
</head>
<body>
<canvas id="omokCanvas" width="600" height="600"></canvas>
<button id="mu">무르기</button>

<script>
    const canvas = document.getElementById('omokCanvas');
    const ctx = canvas.getContext('2d');
    const boardSize = 15;
    const cellSize = canvas.width / boardSize;
	drawBoard();
	
	// 화면에 보드판 그리기 기능
	function drawBoard() {
        ctx.fillStyle = 'yellow'; // 배경색을 노란색으로 설정
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        // 오목판 그리기
        ctx.strokeStyle = '#000'; // 선 색상을 검은색으로 설정
        for (let i = 0; i <= boardSize; i++) {
            ctx.beginPath();
            ctx.moveTo(i * cellSize, 0);
            ctx.lineTo(i * cellSize, canvas.height);
            ctx.stroke();

            ctx.beginPath();
            ctx.moveTo(0, i * cellSize);
            ctx.lineTo(canvas.width, i * cellSize);
            ctx.stroke();
        }
    }
	
	/*   무르기 기능 미완
	const button = document.getElementById('mu');
	 // 버튼에 클릭 이벤트 리스너를 추가합니다.
	 button.addEventListener('click', function() {
	     back(lastStoneX, lastStoneY);
	 });
	 */
	// 화면에 돌 그리기 기능
    function drawStone(x, y, player) {
        const stoneColor = (player === 1) ? '#000' : '#FFF';
        ctx.beginPath();
        ctx.arc(x * cellSize + cellSize / 2, y * cellSize + cellSize / 2, cellSize / 2 - 2, 0, 2 * Math.PI);
        ctx.fillStyle = stoneColor;
        ctx.fill();
        //lastStoneX = x;
        //lastStoneY = y;
    }
	
	
    canvas.addEventListener('click', handleClick);
    var x = 0;
    var y = 0;
    let currentPlayer = 1; // 흑돌부터 시작
    let finish = false;
    let state = null;
    
    function handleClick(event) {
        if (!finish) {
            x = Math.floor(event.offsetX / cellSize);
            y = Math.floor(event.offsetY / cellSize);
	        sendMessage(x, y, currentPlayer);
        }
    }
    
    
    
    
    let ws = new WebSocket("ws://localhost:8090/omok/server");
    
    ws.onopen = function() {
        console.log("client> connected to server")
        //console.log("내 세션 id : " + ws.id);
    };
    
    ws.onmessage = function(event) {
    	let receivedData = JSON.parse(event.data);
    	// 예시: 받은 데이터의 x, y, stone 값을 사용하여 처리
        x = receivedData.x;
        y = receivedData.y;
        currentPlayer = receivedData.currentPlayer;
        state = receivedData.state;
        var myTurn = receivedData.myTurn;
        // 내 턴에 내 돌로만 착수할 수 있음
        if(myTurn) {
	        currentPlayer = recieveMessage(x, y, currentPlayer, state);
        }
        console.log("onmessage의 player : " + currentPlayer + " x, y : " + x + " "+ y + " state : " + state);
        console.log("------------------");
        
    };
	
    // 서버로 메세지 전달
    function sendMessage(x, y, currentPlayer) {
        let message = {
        		x: x,
        		y: y,
        		currentPlayer: currentPlayer
        };
        ws.send(JSON.stringify(message));
        console.log("client > me : " + message);
    }
    
    // 서버로부터 받은 메세지 처리
    function recieveMessage(x, y, currentPlayer, state) {
	    console.log("client> message from server : "+ x + " " + y + " " + currentPlayer + " " + state);
		if(state == "goodPostion") {
			drawStone(x, y, currentPlayer);
			currentPlayer = (currentPlayer == 1) ? 2 : 1;
			finish = false;
			console.log("현재 플레이어 변경 : " + currentPlayer);
			return currentPlayer;
		} else if(state == "badPosition") {
			finish = false;
			alert(currentPlayer + "님이 badPosition. 착수 불가 위치에 착수를 시도했습니다.");
			return currentPlayer;
		} else if(state == "white") {
			finish = true;
			drawStone(x, y, currentPlayer);
			alert("white win");
			return currentPlayer;
		} else if(state == "black") {
			drawStone(x, y, currentPlayer);
			finish = true;
			alert("black win");
			return currentPlayer;
		}
	}

</script>
</body>
</html>
