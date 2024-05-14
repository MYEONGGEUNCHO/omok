<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>
<%
String nickname = (String) session.getAttribute("nickname");
%>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	// 웹 소켓은 http가 아닌 ws 프로토콜을 사용
	var websocket = new WebSocket('ws://localhost:9000/omok/websocket');
	
	// 메세지를 받았을 때 실행
	websocket.onmessage = function(event) {
		var message = event.data.split("|"); // 대화명과 메시지 분리
		var sender = message[0];
		var content = message[1];

		if (content !== "") {
			$("#messageWindow").append(
					"<div class='message'><img src='../images/profile.png' class='profile_ic'>"
							+ "<span class='sender'>" + sender + "</span>"
							+ "<p class='chat_content1'>" + content
							+ "</p></div>");
			scrollToBottom();
		} else {
			$("#messageWindow").append(
					"<div class='message'><span class='system'>" + sender
							+ "님이 종료하였습니다.</span></div>");
			scrollToBottom();
		}
	};
	// 웹소켓 서버에 연결되었을 때 실행
	websocket.onopen = function() {
		$("#messageWindow").html("<p class='notice'>채팅에 참여하였습니다.</p>");

	};
	
	// 웹소켓이 닫혔을 때 실행
	websocket.onclose = function() {
		console.log(event);
		$("#messageWindow").html("<p class='notice'>채팅이 종료되었습니다.</p>");

	};
	//웹소켓 에러 발생 시 실행
	websocket.onerror = function(event) {
		console.log(event);
	}

	function send() {
		var message = $("#inputMessage").val().trim();
		if (message !== "") {
			$("#messageWindow").append(
					"<div class='message'><span class='self'>" + message
							+ "</span></div>");
			websocket.send(message); // 서버로 전송
			$("#inputMessage").val(""); // 메시지 초기화
			scrollToBottom(); // 하단으로 이동
		}
	}

	// 엔터키 눌렀을 때 send 함수 호출
	function enterkey(event) {
		if (event.keyCode === 13) {
			send();
		}
	}

	function scrollToBottom() { // 하단으로 이동
		var elem = document.getElementById('messageWindow');
		elem.scrollTop = elem.scrollHeight;
	}

	$(document).ready(function() {
		// 아이콘 클릭시 채팅창 보이기 & 숨기기
		$(".chat_icon").on("click", function() {
			$("#_chatbox").toggle();
		});
	});
</script>

</head>


<body>
	<img class="chat_icon" src="../images/chat_icon.png" width="100px"
		height="100px">
	<input type="hidden" value="<%=nickname%>" id="chat_id">
	<div id="_chatbox">
		<fieldset id=sendbox>
			<div id="messageWindow"></div>
			<input type="text" id="inputMessage" onkeyup="enterkey()" autofocus />
			<input type="submit" id="sendbtn" value="보내기" onclick="send()" />
		</fieldset>
	</div>
</body>
<style>
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

#messageWindow {
	max-height: 600px;
	overflow-y: overlay;
}

#messageWindow::-webkit-scrollbar {
	width: 5px; /* 스크롤바의 너비 */
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

#inputMessage {
	margin-left: 20px;
}

.chat_content1 {
	padding: 4px;
	width: fit-content;
	background-color: #fff;
	clear: both;
	border-radius: 10px;
}

.chat_content2 {
	padding: 4px;
	width: fit-content;
	background-color: #FCFFE7;
	float: right;
	clear: both;
	border-radius: 10px;
}

.profile_ic {
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
