<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rank.RankVO"%>
<%@ page import="rank.RankDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="account.user.UserDAO"%>
<%@ page import="account.user.UserVO"%>
<%@ page import="java.lang.System"%>
<head>
<%@ include file="/layout/header.jsp"%>
<%
String type = (String) session.getAttribute("profile");
String role = (String) session.getAttribute("role");
System.out.println(role);
RankDAO rdao = new RankDAO();
// 현재 사용자의 순위 정보 가져오기
RankVO myRank = rdao.myrank(userId);
%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/game/game.css" />

<script>
	$(function() {

		var row = 0;
		var col = 0;
		var last = {row, col};
		var turn = 0;
		var finish = false;
		var state = null;
		const $board = $('.omok_board_click');
		$board.on('click', '.cell', function(event) {
			if($(this).html() != "") {
				alert("이미 놓여진 자리입니다.");
				return;
			}
			if(!finish) {
				row = parseInt($(this).data('row'));
				col = parseInt($(this).data('col'));
	
				// 클릭한 셀의 위치 정보를 서버로 보냅니다.
				console.log(row, col);
				sendOmokMessage(row, col, turn);
				
				if(turn % 2 == 0) {
					$(this).html("<div class='black_dol'></div>");								
				}
				else {					
					$(this).html("<div class='white_dol'></div>");								
				}
				turn++;
			}
		});

		//무르기 요청
		$('#sorry').click(function () {
			console.log(last);
		});
// 		게임 종료 후 확인 버튼 누르면 돌아가기		
		$("ok_btn").click(function() {
			location.back();
		});
	})
	var ws;
	
	
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
		if (content != "") {
			$(".game_chat").append("<div id='your_chat_container'>");
			$(".game_chat").append("<img src='/omok/images/your_chat.png' class='your_profile'>" + "<div class='your_chat'>" + content + "</div>");
			$(".game_chat").append("</div>");
			scrollToBottom();
		}
		else {
			$(".game_chat").append("<div class='my_chat'>" + sender + "님이 종료하였습니다.</div>");
		}
	}
	// (채팅)서버로 메세지 전달
		function send() {
			//var Message = $("#inputMessage").val();
			//console.log($("#inputMessage").val());
			if ($("#inputMessage").val() == "") {

			} else {
				$(".game_chat").append("<div class = 'my_chat'>" + $("#inputMessage").val() + "</p>");

				// <진이 : 바꾼 부분>
				var chatMessage = $("#chat_id").val() + "|" + $("#inputMessage").val();
				let message = {
					type: 'chat',
					chatMessage: chatMessage
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
			var elem =$('.game_chat');
			elem.scrollTop = elem.scrollHeight;
		}

		/*		오목 관련 함수		*/

		// (오목)오목 게임 응답 처리
		function handleGomokMessage(receivedData) {
			console.log("handleGomokMessage(receivedData)", receivedData);
			x = receivedData.x;
			y = receivedData.y;
			currentPlayer = receivedData.turn;
			state = receivedData.state;
			var myTurn = receivedData.myTurn;
			// 내 턴에 내 돌로만 착수할 수 있음
			if (myTurn) {
				currentPlayer = recieveMessage(x, y, currentPlayer, state);
			}
		}

		// (오목)서버로 메세지 전달
		function sendOmokMessage(x, y, currentPlayer) {
			let message = {
				type: 'gomok',
				x: x,
				y: y,
				currentPlayer: currentPlayer
			};
			ws.send(JSON.stringify(message));
			console.log("client > me : " + message);
		}

		// (오목)서버로부터 받은 메세지 처리
		function recieveMessage(x, y, currentPlayer, state) {
			console.log("client> message from server : " + x + " " + y + " " + currentPlayer + " " + state);
			if (state == "goodPostion") {
// 				돌 그리는 로직 수정필요
				drawStone(x, y, currentPlayer);
				currentPlayer = (currentPlayer == 1) ? 2 : 1;
				finish = false;
				console.log("현재 플레이어 변경 : " + currentPlayer);
				return currentPlayer;
			} else if (state == "badPosition") {
				finish = false;
				alert(currentPlayer + "님이 badPosition. 착수 불가 위치에 착수를 시도했습니다.");
				return currentPlayer;
			} else if (state == "white") {
				finish = true;
				drawStone(x, y, currentPlayer);
				alert("white win");
				return currentPlayer;
			} else if (state == "black") {
				drawStone(x, y, currentPlayer);
				finish = true;
				alert("black win");
				return currentPlayer;
			}
		}
	$(document).ready(function() {
	// 웹 소켓 객체 생성
		var socketLink = "ws://";
		socketLink += window.location.host + "/omok/server";
		ws = new WebSocket(socketLink);
		var inputMessage = $('#inputMessage');
		var textarea = $('.game_chat');
		
		var nickname = "<%=nickname%>"; 
		var profile = "<%=profile%>";
		var win = <%=my_win%>;
	    var lose = <%=my_lose%>;
		
		// 서버와 연결된 경우 실행
		ws.onopen = function() {
			textarea.append("<div class='notice'>채팅에 참여하였습니다.</div>");
			console.log("client> connected to server");
			sendSessionInfo();
		};

		//서버로부터 메세지 받은 경우 실행 
		ws.onmessage = function(event) {
			var receivedData = JSON.parse(event.data);
			console.log("ws.onmessage!!")
// 			console.log('받은 json 데이터 : ' + receivedData);
// 			console.log(typeof receivedData);
// 			console.log('받은 json type 데이터 : ' + receivedData.type);
// 			console.log('받은 json message 데이터 : ' + receivedData.message);
			// 받은 데이터의 값을 사용하여 처리
			switch (receivedData.type) {
				case 'chat':	// 채팅 관련 데이터 처리
					handleChatMessage(receivedData);
					break;
				case 'gomok':	// 오목 게임 관련 데이터 처리
					handleGomokMessage(receivedData);
					break;
				case 'sessionInfo':
			    	handlesessionInfo(receivedData);
			    	break;
				default:
					console.log('Unknown message type:', receivedData.type);
			}
		};

		//웹소켓이 닫혔을 때 실행
		ws.onclose = function(event) {
			$(".game_chat").append("<div class='notice'>채팅이 종료되었습니다.</div>");
		}
		//서버에서 정보 받아와서 처리
	    function handlesessionInfo(receivedData){
	    	var nickname = receivedData.nickname;
	    	var profile = receivedData.profile;
	        var win = receivedData.win;
	        var lose = receivedData.lose;

	        // 가져온 값을 사용하여 필요한 처리 수행
	        console.log("닉네임: " + nickname + ", 승: " + win + ", 패: " + lose);
	        //가져온 값으로 화면에 표시
	        document.getElementById('player_profile').innerText = profile; //값에 따라 이미지 처리 해야함
	        document.getElementById('player_nickname').innerText = nickname;
	        document.getElementById('player_winlose').innerText = win + '승 ' + lose + '패';
	    }
	 // 세션 정보를 서버에 전송하는 함수
	    function sendSessionInfo() {
	        let message = {
	            type: 'sessionInfo',
	            profile: profile,
	            nickname: nickname,
	            win: win,
	            lose: lose
	        };
	        ws.send(JSON.stringify(message));
	    }
	})
</script>
<!-- <script src="game.js"></script> -->
</head>
<body>
	<main>
		<div class="game_container">
			<div class="header"></div>
			<div class="player1 player_card">
				<div class="profile">
					<img src="/omok/images/profile/${profile}.png">
				</div>
				<div class="nickname">${nickname}</div>
				<div class="winlose">${my_win }승${my_lose }패</div>
			</div>
			<div class="game_status">대기중</div>
			<%
			if (role != null &&role.equals("host")) { // 호스트인 경우
			%>
			<div id="player2" class="player_card">
				<div class="profile" id="player_profile">대기중</div>
				<div class="nickname" id="player_nickname">대기중</div>
				<div class="winlose" id="player_winlose">대기중</div>
			</div>
			<%
			} else if (role == null) { // 게스트인 경우
				String roomID = (String) session.getAttribute("roomId");
				int roomId = Integer.parseInt(roomID);

				if (roomID == null) {
					System.out.println("룸id가 널값임");
				} else {
					System.out.println(roomID);
				}

			UserDAO dao = new UserDAO(); //정보를 가져오기 위한 dao 객체 생성
			UserVO user1 = dao.getPlayer(roomId); //room db에 저장되어 있는 user1의 정보 가져오기 일단은 임시
			%>
			<div id="player2" class="player_card">
				<div class="profile"><%=user1.getProfile()%></div>
				<div class="nickname" id="player2_nickname"><%=user1.getNickname()%></div>
				<div class="winlose" id="player2_winlose"><%=user1.getWin()%>승
					<%=user1.getLose()%>패
				</div>
			</div>
			<%
			}
			%>
			<div class="play_container">
				<table class="omok_board">
					<!-- 15x15 div 오목판 cell 동적으로 추가할 부분 -->
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
					</tr>

				</table>
				<table class="omok_board_click">
					<tr>
						<td class="cell" data-row=0 data-col=0></td>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=0 data-col=3></td>
						<td class="cell" data-row=0 data-col=4></td>
						<td class="cell" data-row=0 data-col=5></td>
						<td class="cell" data-row=0 data-col=6></td>
						<td class="cell" data-row=0 data-col=7></td>
						<td class="cell" data-row=0 data-col=8></td>
						<td class="cell" data-row=0 data-col=9></td>
						<td class="cell" data-row=0 data-col=10></td>
						<td class="cell" data-row=0 data-col=11></td>
						<td class="cell" data-row=0 data-col=12></td>
						<td class="cell" data-row=0 data-col=13></td>
						<td class="cell" data-row=0 data-col=14></td>
						<td class="cell" data-row=0 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=1 data-col=0></td>
						<td class="cell" data-row=1 data-col=1></td>
						<td class="cell" data-row=1 data-col=2></td>
						<td class="cell" data-row=1 data-col=3></td>
						<td class="cell" data-row=1 data-col=4></td>
						<td class="cell" data-row=1 data-col=5></td>
						<td class="cell" data-row=1 data-col=6></td>
						<td class="cell" data-row=1 data-col=7></td>
						<td class="cell" data-row=1 data-col=8></td>
						<td class="cell" data-row=1 data-col=9></td>
						<td class="cell" data-row=1 data-col=10></td>
						<td class="cell" data-row=1 data-col=11></td>
						<td class="cell" data-row=1 data-col=12></td>
						<td class="cell" data-row=1 data-col=13></td>
						<td class="cell" data-row=1 data-col=14></td>
						<td class="cell" data-row=1 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=2 data-col=0></td>
						<td class="cell" data-row=2 data-col=1></td>
						<td class="cell" data-row=2 data-col=2></td>
						<td class="cell" data-row=2 data-col=3></td>
						<td class="cell" data-row=2 data-col=4></td>
						<td class="cell" data-row=2 data-col=5></td>
						<td class="cell" data-row=2 data-col=6></td>
						<td class="cell" data-row=2 data-col=7></td>
						<td class="cell" data-row=2 data-col=8></td>
						<td class="cell" data-row=2 data-col=9></td>
						<td class="cell" data-row=2 data-col=10></td>
						<td class="cell" data-row=2 data-col=11></td>
						<td class="cell" data-row=2 data-col=12></td>
						<td class="cell" data-row=2 data-col=13></td>
						<td class="cell" data-row=2 data-col=14></td>
						<td class="cell" data-row=2 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=3 data-col=0></td>
						<td class="cell" data-row=3 data-col=1></td>
						<td class="cell" data-row=3 data-col=2></td>
						<td class="cell" data-row=3 data-col=3></td>
						<td class="cell" data-row=3 data-col=4></td>
						<td class="cell" data-row=3 data-col=5></td>
						<td class="cell" data-row=3 data-col=6></td>
						<td class="cell" data-row=3 data-col=7></td>
						<td class="cell" data-row=3 data-col=8></td>
						<td class="cell" data-row=3 data-col=9></td>
						<td class="cell" data-row=3 data-col=10></td>
						<td class="cell" data-row=3 data-col=11></td>
						<td class="cell" data-row=3 data-col=12></td>
						<td class="cell" data-row=3 data-col=13></td>
						<td class="cell" data-row=3 data-col=14></td>
						<td class="cell" data-row=3 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=4 data-col=0></td>
						<td class="cell" data-row=4 data-col=1></td>
						<td class="cell" data-row=4 data-col=2></td>
						<td class="cell" data-row=4 data-col=3></td>
						<td class="cell" data-row=4 data-col=4></td>
						<td class="cell" data-row=4 data-col=5></td>
						<td class="cell" data-row=4 data-col=6></td>
						<td class="cell" data-row=4 data-col=7></td>
						<td class="cell" data-row=4 data-col=8></td>
						<td class="cell" data-row=4 data-col=9></td>
						<td class="cell" data-row=4 data-col=10></td>
						<td class="cell" data-row=4 data-col=11></td>
						<td class="cell" data-row=4 data-col=12></td>
						<td class="cell" data-row=4 data-col=13></td>
						<td class="cell" data-row=4 data-col=14></td>
						<td class="cell" data-row=4 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=5 data-col=0></td>
						<td class="cell" data-row=5 data-col=1></td>
						<td class="cell" data-row=5 data-col=2></td>
						<td class="cell" data-row=5 data-col=3></td>
						<td class="cell" data-row=5 data-col=4></td>
						<td class="cell" data-row=5 data-col=5></td>
						<td class="cell" data-row=5 data-col=6></td>
						<td class="cell" data-row=5 data-col=7></td>
						<td class="cell" data-row=5 data-col=8></td>
						<td class="cell" data-row=5 data-col=9></td>
						<td class="cell" data-row=5 data-col=10></td>
						<td class="cell" data-row=5 data-col=11></td>
						<td class="cell" data-row=5 data-col=12></td>
						<td class="cell" data-row=5 data-col=13></td>
						<td class="cell" data-row=5 data-col=14></td>
						<td class="cell" data-row=5 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=6 data-col=0></td>
						<td class="cell" data-row=6 data-col=1></td>
						<td class="cell" data-row=6 data-col=2></td>
						<td class="cell" data-row=6 data-col=3></td>
						<td class="cell" data-row=6 data-col=4></td>
						<td class="cell" data-row=6 data-col=5></td>
						<td class="cell" data-row=6 data-col=6></td>
						<td class="cell" data-row=6 data-col=7></td>
						<td class="cell" data-row=6 data-col=8></td>
						<td class="cell" data-row=6 data-col=9></td>
						<td class="cell" data-row=6 data-col=10></td>
						<td class="cell" data-row=6 data-col=11></td>
						<td class="cell" data-row=6 data-col=12></td>
						<td class="cell" data-row=6 data-col=13></td>
						<td class="cell" data-row=6 data-col=14></td>
						<td class="cell" data-row=6 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=7 data-col=0></td>
						<td class="cell" data-row=7 data-col=1></td>
						<td class="cell" data-row=7 data-col=2></td>
						<td class="cell" data-row=7 data-col=3></td>
						<td class="cell" data-row=7 data-col=4></td>
						<td class="cell" data-row=7 data-col=5></td>
						<td class="cell" data-row=7 data-col=6></td>
						<td class="cell" data-row=7 data-col=7></td>
						<td class="cell" data-row=7 data-col=8></td>
						<td class="cell" data-row=7 data-col=9></td>
						<td class="cell" data-row=7 data-col=10></td>
						<td class="cell" data-row=7 data-col=11></td>
						<td class="cell" data-row=7 data-col=12></td>
						<td class="cell" data-row=7 data-col=13></td>
						<td class="cell" data-row=7 data-col=14></td>
						<td class="cell" data-row=7 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=8 data-col=0></td>
						<td class="cell" data-row=8 data-col=1></td>
						<td class="cell" data-row=8 data-col=2></td>
						<td class="cell" data-row=8 data-col=3></td>
						<td class="cell" data-row=8 data-col=4></td>
						<td class="cell" data-row=8 data-col=5></td>
						<td class="cell" data-row=8 data-col=6></td>
						<td class="cell" data-row=8 data-col=7></td>
						<td class="cell" data-row=8 data-col=8></td>
						<td class="cell" data-row=8 data-col=9></td>
						<td class="cell" data-row=8 data-col=10></td>
						<td class="cell" data-row=8 data-col=11></td>
						<td class="cell" data-row=8 data-col=12></td>
						<td class="cell" data-row=8 data-col=13></td>
						<td class="cell" data-row=8 data-col=14></td>
						<td class="cell" data-row=8 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=9 data-col=0></td>
						<td class="cell" data-row=9 data-col=1></td>
						<td class="cell" data-row=9 data-col=2></td>
						<td class="cell" data-row=9 data-col=3></td>
						<td class="cell" data-row=9 data-col=4></td>
						<td class="cell" data-row=9 data-col=5></td>
						<td class="cell" data-row=9 data-col=6></td>
						<td class="cell" data-row=9 data-col=7></td>
						<td class="cell" data-row=9 data-col=8></td>
						<td class="cell" data-row=9 data-col=9></td>
						<td class="cell" data-row=9 data-col=10></td>
						<td class="cell" data-row=9 data-col=11></td>
						<td class="cell" data-row=9 data-col=12></td>
						<td class="cell" data-row=9 data-col=13></td>
						<td class="cell" data-row=9 data-col=14></td>
						<td class="cell" data-row=9 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=10 data-col=0></td>
						<td class="cell" data-row=10 data-col=1></td>
						<td class="cell" data-row=10 data-col=2></td>
						<td class="cell" data-row=10 data-col=3></td>
						<td class="cell" data-row=10 data-col=4></td>
						<td class="cell" data-row=10 data-col=5></td>
						<td class="cell" data-row=10 data-col=6></td>
						<td class="cell" data-row=10 data-col=7></td>
						<td class="cell" data-row=10 data-col=8></td>
						<td class="cell" data-row=10 data-col=9></td>
						<td class="cell" data-row=10 data-col=10></td>
						<td class="cell" data-row=10 data-col=11></td>
						<td class="cell" data-row=10 data-col=12></td>
						<td class="cell" data-row=10 data-col=13></td>
						<td class="cell" data-row=10 data-col=14></td>
						<td class="cell" data-row=10 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=11 data-col=0></td>
						<td class="cell" data-row=11 data-col=1></td>
						<td class="cell" data-row=11 data-col=2></td>
						<td class="cell" data-row=11 data-col=3></td>
						<td class="cell" data-row=11 data-col=4></td>
						<td class="cell" data-row=11 data-col=5></td>
						<td class="cell" data-row=11 data-col=6></td>
						<td class="cell" data-row=11 data-col=7></td>
						<td class="cell" data-row=11 data-col=8></td>
						<td class="cell" data-row=11 data-col=9></td>
						<td class="cell" data-row=11 data-col=10></td>
						<td class="cell" data-row=11 data-col=11></td>
						<td class="cell" data-row=11 data-col=12></td>
						<td class="cell" data-row=11 data-col=13></td>
						<td class="cell" data-row=11 data-col=14></td>
						<td class="cell" data-row=11 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=12 data-col=0></td>
						<td class="cell" data-row=12 data-col=1></td>
						<td class="cell" data-row=12 data-col=2></td>
						<td class="cell" data-row=12 data-col=3></td>
						<td class="cell" data-row=12 data-col=4></td>
						<td class="cell" data-row=12 data-col=5></td>
						<td class="cell" data-row=12 data-col=6></td>
						<td class="cell" data-row=12 data-col=7></td>
						<td class="cell" data-row=12 data-col=8></td>
						<td class="cell" data-row=12 data-col=9></td>
						<td class="cell" data-row=12 data-col=10></td>
						<td class="cell" data-row=12 data-col=11></td>
						<td class="cell" data-row=12 data-col=12></td>
						<td class="cell" data-row=12 data-col=13></td>
						<td class="cell" data-row=12 data-col=14></td>
						<td class="cell" data-row=12 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=13 data-col=0></td>
						<td class="cell" data-row=13 data-col=1></td>
						<td class="cell" data-row=13 data-col=2></td>
						<td class="cell" data-row=13 data-col=3></td>
						<td class="cell" data-row=13 data-col=4></td>
						<td class="cell" data-row=13 data-col=5></td>
						<td class="cell" data-row=13 data-col=6></td>
						<td class="cell" data-row=13 data-col=7></td>
						<td class="cell" data-row=13 data-col=8></td>
						<td class="cell" data-row=13 data-col=9></td>
						<td class="cell" data-row=13 data-col=10></td>
						<td class="cell" data-row=13 data-col=11></td>
						<td class="cell" data-row=13 data-col=12></td>
						<td class="cell" data-row=13 data-col=13></td>
						<td class="cell" data-row=13 data-col=14></td>
						<td class="cell" data-row=13 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=14 data-col=0></td>
						<td class="cell" data-row=14 data-col=1></td>
						<td class="cell" data-row=14 data-col=2></td>
						<td class="cell" data-row=14 data-col=3></td>
						<td class="cell" data-row=14 data-col=4></td>
						<td class="cell" data-row=14 data-col=5></td>
						<td class="cell" data-row=14 data-col=6></td>
						<td class="cell" data-row=14 data-col=7></td>
						<td class="cell" data-row=14 data-col=8></td>
						<td class="cell" data-row=14 data-col=9></td>
						<td class="cell" data-row=14 data-col=10></td>
						<td class="cell" data-row=14 data-col=11></td>
						<td class="cell" data-row=14 data-col=12></td>
						<td class="cell" data-row=14 data-col=13></td>
						<td class="cell" data-row=14 data-col=14></td>
						<td class="cell" data-row=14 data-col=15></td>
					</tr>
					<tr>
						<td class="cell" data-row=15 data-col=0></td>
						<td class="cell" data-row=15 data-col=1></td>
						<td class="cell" data-row=15 data-col=2></td>
						<td class="cell" data-row=15 data-col=3></td>
						<td class="cell" data-row=15 data-col=4></td>
						<td class="cell" data-row=15 data-col=5></td>
						<td class="cell" data-row=15 data-col=6></td>
						<td class="cell" data-row=15 data-col=7></td>
						<td class="cell" data-row=15 data-col=8></td>
						<td class="cell" data-row=15 data-col=9></td>
						<td class="cell" data-row=15 data-col=10></td>
						<td class="cell" data-row=15 data-col=11></td>
						<td class="cell" data-row=15 data-col=12></td>
						<td class="cell" data-row=15 data-col=13></td>
						<td class="cell" data-row=15 data-col=14></td>
						<td class="cell" data-row=15 data-col=15></td>
					</tr>
				</table>
			</div>
			<div class="chat_container">
				<div class="game_chat">
					<!-- 					<div class="my_chat"></div> -->
					<!-- 					<div id="your_chat_container"> -->
					<%-- 						<img src="<%=request.getContextPath()%>/images/your_chat.png" --%>
					<!-- 							class="your_profile" /> -->
					<!-- 						<div class="your_chat"></div> -->
					<!-- 					</div> -->
				</div>
				<div class="input_chat">
					<input type="hidden" value="<%=nickname%>" id="chat_id"> <input
						type="text" id="inputMessage" class="chat" name="chat"
						onkeyup="enterkey()" autofocus> <input type="submit"
						id="sendbtn" onclick="send()" value=""
						style="background-image: url(<%=request.getContextPath()%>/images/send_btn.png)"
						class="send_btn" />
				</div>
			</div>
		</div>
		<%-- 		<%@ include file="lose.jsp"%> --%>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>
