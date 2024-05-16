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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">

	//파라미터로 닉네임, 방 정보 가져오기

	//웹 소켓은 http가 아닌 ws 프로토콜을 사용
    var websocket = new WebSocket('ws://localhost:8090/omok/websocket');
    var inputMessage = document.getElementById('inputMessage');
    var textarea = document.getElementById("messageWindow");
    var nickname = "<%= nickname %>"; 
    
    websocket.onmessage = onMessage;
    websocket.onopen = onOpen;
    websocket.onclose = onClose;

    //웹소켓 서버에 연결되었을 때 실행
    function onOpen(event) {
		$("#messageWindow").html("<p class='notice'>채팅에 참여하였습니다.</p>");
	}

    //웹소켓이 닫혔을 때 실행
	function onClose(event) {
		$("#messageWindow").html("<p class='notice'>채팅이 종료되었습니다.</p>");
	}

    //메세지 받았을 때 실행
    function onMessage(event) {
    	//console.log(event.data);
        var message = event.data.split("|");  //대화명과 메시지 분리
        var sender = message[0];
		var content = message[1];
		//console.log(sender);
		//console.log(content);
		
        if(content !=""){
        	$("#messageWindow").html($("#messageWindow").html() + "<img src='../images/profile.png' class='profile_ic'>" + sender
        			+ "<p class='chat_content1'>"+ content + "</p>");
            scrollToBottom();
        } 
        else {
            $("#messageWindow").html($("#messageWindow").html() + "<p class='chat_content'>" + sender + "님이 종료하였습니다.</p>");
        }
    }

	
    function send(){
    	//var Message = $("#inputMessage").val();
    	//console.log($("#inputMessage").val());
        if($("#inputMessage").val() == ""){

        }else{
            $("#messageWindow").html($("#messageWindow").html()
                + "<p class = 'chat_content2'>" + $("#inputMessage").val() + "</p>");
            websocket.send($("#chat_id").val() + "|" + $("#inputMessage").val());  //서버로 전송
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

    $(document).ready(function() {
        //websocket.init();
        let chatVisible = true; // 채팅창의 표시 여부를 나타내는 변수

    //아이콘 클릭시 채팅창 보이기 & 숨기기
        $(".chat_icon").on({"click" : function() {
            if(chatVisible){
                $(".chat_icon").attr("src", "../images/chat_icon.png");
                $("#_chatbox").css("display", "none");
                chatVisible = false;
            }else{
                $(".chat_icon").attr("src", "../images/chat_icon.png");
                $("#_chatbox").css("display", "block");
                chatVisible = true;
            }
           }
        });
    });

    function scrollToBottom() {  //하단으로 이동
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
