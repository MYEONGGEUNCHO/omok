<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<% String nickname = (String) session.getAttribute("nickname"); %>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>오목 게임</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
    
    #_chatbox {
        align-items: center;
        display: block;
        background-color: #ffd7cf; 
        width: 300px; 
        height: 650px;
        
        position: relative;
    }
    #sendbox {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        border: none;
    }
   
    #messageWindow{  
        max-height: 600px;
        overflow-y: overlay;
    }
    
    #messageWindow::-webkit-scrollbar {
        width: 5px;  /* 스크롤바의 너비 */
    }
    
    #messageWindow::-webkit-scrollbar-thumb {
    height: 20%; /* 스크롤바의 길이 */
    background: #fff; /* 스크롤바의 색상 */
    border-radius: 10px;
}
    #messageWindow::-webkit-scrollbar-track {
        box-shadow: none;
        background-color: transparent;
    }
    #inputMessage{
    	margin-left: 20px;
    }
    
    .chat_content1{
        padding: 4px;
        width: fit-content;
        background-color: #fff;
        clear:both;
        border-radius: 10px;
    }
    .chat_content2{
        padding: 4px;
        width: fit-content;
        background-color: #FCFFE7;
        float: right; 
        clear:both;
        border-radius: 10px;
    }
    
    .profile_ic{
    	width: 20px;
    	height: 20px;
    	border-radius: 50%;
    	margin-bottom: 2px;
    }
    .notice {
    	text-align: center;
    	align-content: center;
    	background-color: white;
    	font-size: 14px;
    }
</style>
</head>
<body>
<canvas id="omokCanvas" width="600" height="600"></canvas>
<button id="mu">무르기</button>
	<img class="chat_icon" src = "../images/chat_icon.png" width="100px" height="100px">
    <input type="hidden" value="<%= nickname %>" id="chat_id">
    <div id="_chatbox" >
        <fieldset id=sendbox>
            <div id="messageWindow"></div>
            <input type="text" id="inputMessage" onkeyup="enterkey()" autofocus/>
            <input type="submit" id = "sendbtn" value = "보내기" onclick="send()"/>
        </fieldset>
    </div>


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
            sendOmokMessage(x, y, currentPlayer);
        }
    }
    
    
    
    /*		서버 소켓 통신 관련 함수		*/
    
    // 웹 소켓 객체 생성
    let ws = new WebSocket("ws://localhost:8090/test/server");
    console.log("객체 생성");
    var inputMessage = document.getElementById('inputMessage');
    var textarea = document.getElementById("messageWindow");
    var nickname = "<%= nickname %>"; 
    // 서버와 연결된 경우 실행
    ws.onopen = function() {
    	$("#messageWindow").html("<p class='notice'>채팅에 참여하였습니다.</p>");
        console.log("client> connected to server")
    };
    
    //서버로부터 메세지 받은 경우 실행 
    ws.onmessage = function(event) {
    	var receivedData = JSON.parse(event.data);
    	console.log('받은 json 데이터 : ' + receivedData);
    	console.log(typeof receivedData);
    	console.log('받은 json type 데이터 : ' + receivedData.type);
    	console.log('받은 json message 데이터 : ' + receivedData.message);
    	// 받은 데이터의 값을 사용하여 처리
    	switch(receivedData.type) {
		    case 'chat':	// 채팅 관련 데이터 처리
		        handleChatMessage(receivedData);
		        break;
		    case 'gomok':	// 오목 게임 관련 데이터 처리
		        handleGomokMessage(receivedData);
		        break;
		    default:
		        console.log('Unknown message type:', receivedData.type);
		}
    };
    
  	//웹소켓이 닫혔을 때 실행
    ws.onclose = function(event) {
		$("#messageWindow").html("<p class='notice'>채팅이 종료되었습니다.</p>");
	}

  	
    /*		채팅 관련 함수		*/
    
    // (채팅)채팅 응답 처리
    function handleChatMessage(receivedData) {
    	var chatMessage = receivedData.message;
    	//console.log(event.data);
        var message = chatMessage.split("|");  //대화명과 메시지 분리
      	//var message = event.data.split("|");  //대화명과 메시지 분리
        var sender = message[0];
		var content = message[1];
		//console.log(sender);
		if(content !="") {
        	$("#messageWindow").html($("#messageWindow").html() + "<img src='../images/profile.png' class='profile_ic'>" + sender
        			+ "<p class='chat_content1'>"+ content + "</p>");
            scrollToBottom();
        } 
        else {
            $("#messageWindow").html($("#messageWindow").html() + "<p class='chat_content'>" + sender + "님이 종료하였습니다.</p>");
        }
    }
    
 	// (채팅)서버로 메세지 전달
    function send(){
    	//var Message = $("#inputMessage").val();
    	//console.log($("#inputMessage").val());
        if($("#inputMessage").val() == ""){

        }else{
            $("#messageWindow").html($("#messageWindow").html()
                + "<p class = 'chat_content2'>" + $("#inputMessage").val() + "</p>");
            
            // <진이 : 바꾼 부분>
            var chatMessage = $("#chat_id").val() + "|" + $("#inputMessage").val();
            let message = {
            		type:'chat',
            		chatMessage:chatMessage
            };
            //websocket.send($("#chat_id").val() + "|" + $("#inputMessage").val());  //서버로 전송
            ws.send(JSON.stringify(message));
            // </진이 : 바꾼 부분>
            
            $("#inputMessage").val(""); //메시지 초기화
            scrollToBottom();  //하단으로 이동
        }
    }
    //enter치면 send
    function enterkey() {
        if (window.event.keyCode == 13) {
            send(); 
        }
    }
    
    function scrollToBottom() {  //하단으로 이동
        var elem = document.getElementById('messageWindow');
        elem.scrollTop = elem.scrollHeight;
    }
    
    
    /*		오목 관련 함수		*/
    
    // (오목)오목 게임 응답 처리
    function handleGomokMessage(receivedData) {
        x = receivedData.x;
        y = receivedData.y;
        currentPlayer = receivedData.currentPlayer;
        state = receivedData.state;
        var myTurn = receivedData.myTurn;
        // 내 턴에 내 돌로만 착수할 수 있음
        if(myTurn) {
	        currentPlayer = recieveMessage(x, y, currentPlayer, state);
        }
	}
	
    // (오목)서버로 메세지 전달
    function sendOmokMessage(x, y, currentPlayer) {
        let message = {
        		type:'gomok',
        		x: x,
        		y: y,
        		currentPlayer: currentPlayer
        };
        ws.send(JSON.stringify(message));
        console.log("client > me : " + message);
    }
    
    // (오목)서버로부터 받은 메세지 처리
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
