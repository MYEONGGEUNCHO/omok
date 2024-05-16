<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
//클라이언트에서 서버로 전송할 데이터
var board = {
  "map": [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ]
};
var row = 0;
var col = 0;
var last = { row, col };
var currentPlayer;
var playerNumber;
if(role == "host") {
// 	console.log("플레이어 넘버 실행됨");
	currentPlayer = 1;
	playerNumber = 1;
} else {
	currentPlayer = 2;
	playerNumber = 2;
}
var isGomok = false;
var turn = 0;
var finish = false;

$(function() {
	var state = null;
	var role = '<%=role%>';
	
	
// 	console.log("role:",role);
	const $board = $(".omok_board_click");
	$board.on("click", ".cell", function(event) {
		if(!isEnemy && role == "host") {
			alert("상대방이 들어오기를 기다려주세요.");
			return;
		}
		if ($(this).html() != "") {
			alert("이미 놓여진 자리입니다.");
			return;
		}
		if((turn % 2) + 1 != playerNumber) {
			alert("본인 차례에만 놀 수 있습니다.");
			return;
		}
		row = parseInt($(this).data("col"));
		col = parseInt($(this).data("row"));
// 		console.log(row, col,"클릭됨");
// 		console.log(finish, board.map, board.map[row][col]);
		if (!finish && board.map[row][col] == 0) {
			// 클릭한 셀의 위치 정보를 서버로 보냅니다.
			//console.log(row, col);
// 			console.log("현재 턴: ", turn, "내 번호와 커렌트 플레이어 ",playerNumber, currentPlayer);
			if ((turn % 2) + 1 == 1) {
// 				console.log("플레이어1이 돌을 둠",row,col,currentPlayer);
				sendOmokMessage(row, col, currentPlayer, board, turn);
				if(isGomok) {
					$(this).html("<div class='black_dol'></div>");
					board.map[row][col] = playerNumber;
					isGomok = false;
				}
			} else if ((turn % 2) + 1 == 2) {
// 				console.log("플레이어2이 돌을 둠",row,col,currentPlayer);
				sendOmokMessage(row, col, currentPlayer, board, turn);
				if(isGomok) {
					$(this).html("<div class='white_dol'></div>");
					board.map[row][col] = playerNumber;
					isGomok = false;
				}
			}
		}
	});

	//무르기 요청
	$("#sorry").click(function() {
		console.log(last);
		alert("아직 구현되지 않은 기능입니다.");
	});
	// 		게임 종료 후 확인 버튼 누르면 돌아가기
	$("ok_btn").click(function() {
		location.back();
	});
});

/*		채팅 관련 함수		*/

// (채팅)채팅 응답 처리
function handleChatMessage(receivedData) {
	var chatMessage = receivedData.message;
	//console.log(event.data);
	var message = chatMessage.split("|"); //대화명과 메시지 분리
	//var message = event.data.split("|");  //대화명과 메시지 분리
	var sender = message[0];
	var content = message[1];
	//console.log(sender);
	if (content != "") {
		$(".game_chat").append("<div id='your_chat_container'>");
		$(".game_chat").append(
			"<img src='/omok/images/your_chat.png' class='your_profile'>" +
			"<div class='your_chat'>" +
			content +
			"</div>"
		);
		$(".game_chat").append("</div>");
		scrollToBottom();
	} else {
		$(".game_chat").append(
			"<div class='my_chat'>" + sender + "님이 종료하였습니다.</div>"
		);
	}
}
// (채팅)서버로 메세지 전달
function send() {
	//var Message = $("#inputMessage").val();
	//console.log($("#inputMessage").val());
	if ($("#inputMessage").val() == "") {
	} else {
		$(".game_chat").append(
			"<div class = 'my_chat'>" + $("#inputMessage").val() + "</p>"
		);

		// <진이 : 바꾼 부분>
		var chatMessage = $("#chat_id").val() + "|" + $("#inputMessage").val();
		let message = {
			type: "chat",
			chatMessage: chatMessage,
		};
		//websocket.send($("#chat_id").val() + "|" + $("#inputMessage").val());  //서버로 전송
		ws.send(JSON.stringify(message));
		// </진이 : 바꾼 부분>

		$("#inputMessage").val(""); //메시지 초기화
		scrollToBottom(); //하단으로 이동
	}
}
//enter치면 send
function enterkey() {
	if (window.event.keyCode == 13) {
		send();
	}
}

function scrollToBottom() {
	//하단으로 이동
	var elem = $(".game_chat");
	elem.scrollTop = elem.scrollHeight;
}

/*		오목 관련 함수		*/

// (오목)서버로 메세지 전달
function sendOmokMessage(x, y, currentPlayer, board, turn) {
	let message = {
		type: "gomok",
		x: x,
		y: y,
		currentPlayer: currentPlayer,
		board: board,
		turn: turn
	};
	ws.send(JSON.stringify(message));
// 	console.log("client > server : 고목 좌표 정보 보냄",x,y,currentPlayer);
}

// (오목)오목 게임 응답 처리
function handleGomokMessage(receivedData) {
// 	console.log("handleGomokMessage(receivedData)", receivedData);
	x = receivedData.x;
	y = receivedData.y;
// 	currentPlayer = receivedData.currentPlayer;
	state = receivedData.state;
	var myTurn = currentPlayer == playerNumber ? true : false; 
	board.map = receivedData.board;
	turn = receivedData.turn;
	$(".game_status").html(turn + "수 째 게임중");
	//받은 좌표대로 상대방 돌 그려주기
	// board.map을 순회하면서 해당 위치의 값을 확인하고, 값이 1인 경우 해당 요소의 내용을 변경합니다.
	$('.omok_board_click td.cell').each(function() {
	    var row_ = $(this).data('col');
	    var col_ = $(this).data('row');
	    if (board.map[row_][col_] === 1) {
			$(this).html("<div class='black_dol'></div>");
	    }
	    else if (board.map[row_][col_] === 2) {    	
			$(this).html("<div class='white_dol'></div>");
	    }
	});
	// 내 턴에 내 돌로만 착수할 수 있음
	if (myTurn) {
		recieveMessage(x, y, currentPlayer, state);
		return true;
	}
}
// (오목)서버로부터 받은 메세지 처리
function recieveMessage(x, y, currentPlayer, state) {
// 	console.log("돌 놓고 서버에게 받은 응답 : ", state);
	if (state == "goodPostion") {
// 		if(currentPlayer == 1) {
// 			currentPlayer = 2;
// 		}
// 		else {
// 			currentPlayer = 1;
// 		}
		finish = false;
	} else if (state == "badPosition") {
		finish = false;
		alert(
			playerNumber + "님이 badPosition. 착수 불가 위치에 착수를 시도했습니다."
		);
	} else if (state == "white") {
		finish = true;
		var isQuit = confirm('백돌님이 승리하였습니다.<br>나가시겠습니까?');
		if(isQuit) {
			location.href="/omok/index.jsp";
		}
	} else if (state == "black") {
		finish = true;
		var isQuit = alert('흑돌님이 승리하였습니다.<br>나가시겠습니까?');
		if(isQuit) {
			location.href="/omok/index.jsp";
		}
	} else {
// 		console.log("예외 상황 발생", state);
	}
	
	;
};

var ws;
function webSocketLink() {
	// 웹 소켓 객체 생성
	var socketLink = "ws://";
	socketLink += window.location.host + "/omok/server";
	ws = new WebSocket(socketLink);
	//ws = new WebSocket("ws://localhost:8999/omok/server");

};

$(document).ready(function() {
	webSocketLink();
	// 서버와 연결된 경우 실행
	ws.onopen = function() {
		textarea.append("<div class='notice'>채팅에 참여하였습니다.</div>");
// 		console.log("client> connected to server");
		sendSessionInfo();
	};

	ws.onerror = function(e) {
		console.log("[에러발생]", e);
// 		console.log(e.message);
	};


	//서버로부터 메세지 받은 경우 실행
	ws.onmessage = function(event) {
		var receivedData = JSON.parse(event.data);
		// 받은 데이터의 값을 사용하여 처리
		switch (receivedData.type) {
			case "chat": // 채팅 관련 데이터 처리
				handleChatMessage(receivedData);
				break;
			case "gomok": // 오목 게임 관련 데이터 처리
				isGomok = handleGomokMessage(receivedData);
				break;
			case "sessionInfo":
				handlesessionInfo(receivedData);
				break;
			default:
// 				console.log("Unknown message type:", receivedData.type);
		};
	};

	//웹소켓이 닫혔을 때 실행
	ws.onclose = function(event) {
		$(".game_chat").append("<div class='notice'>채팅이 종료되었습니다.</div>");
		alert("서버에 오류가 있습니다. 다시 시도해주세요.");
		ws.close();

	};
});


var inputMessage = $("#inputMessage");
var textarea = $(".game_chat");

var nickname = "<%=nickname%>";
var profile = "<%=profile%>";
var win = "<%=my_win%>";
var lose = "<%=my_lose%>";
var isEnemy = false;
// console.log(nickname);
//서버에서 정보 받아와서 처리
function handlesessionInfo(receivedData) {
	var nickname = receivedData.nickname;
	var profile = receivedData.profile;
	var win = receivedData.win;
	var lose = receivedData.lose;

	// 가져온 값을 사용하여 필요한 처리 수행
// 	console.log("닉네임: " + nickname + ", 승: " + win + ", 패: " + lose);
	//가져온 값으로 화면에 표시
	var profile_img = "<img src='/omok/images/profile/" + profile + ".png'>;";
	$("#player_profile").html(profile_img); //값에 따라 이미지 처리
	document.getElementById("player_nickname").innerText = nickname;
	document.getElementById("player_winlose").innerText =
		win + "승 " + lose + "패";
	isEnemy = true;
};
// 세션 정보를 서버에 전송하는 함수
function sendSessionInfo() {
	let message = {
		type: "sessionInfo",
		profile: profile,
		nickname: nickname,
		win: win,
		lose: lose,
	};
	ws.send(JSON.stringify(message));
};
</script>
