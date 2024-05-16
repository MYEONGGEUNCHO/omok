<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="game.css" />
<%@include file="../layout/header.jsp"%>
<script src="game.js"></script>
</head>
<body>
	<main>
		<canvas id="omokCanvas" width="600" height="600"></canvas>
		<button id="mu">무르기</button>
		<img class="chat_icon" src="/omok/images/chat_icon.png" width="100px"
			height="100px"> <input type="hidden" value="<%=nickname%>"
			id="chat_id">
		<div id="_chatbox">
			<fieldset id=sendbox>
				<div id="messageWindow"></div>
				<input type="text" id="inputMessage" onkeyup="enterkey()" autofocus />
				<input type="submit" id="sendbtn" value="보내기" onclick="send()" />
			</fieldset>
		</div>
	</main>
</body>
<%@include file="../layout/footer.jsp"%>
