<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/reset.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/common.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/game/game.css" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
	$(function() {
		const $board = $('.omok_board');
		$board.on('click', '.cell', function() {
			const row = parseInt($(this).data('row'));
			const col = parseInt($(this).data('col'));

			// 클릭한 셀의 위치 정보를 서버로 보냅니다.
			console.log(row, col);
		});
	})
</script>
</head>
<body>
	<%@ include file="../layout/header.jsp"%>
	<main>
		<div id="game_container">
			<aside class="player_side">
				<div id="player1" class="player_card">
					<div class="profile">(이미지)</div>
					<div class="nickname">플레이어1</div>
					<div class="winlose">5승 5패</div>
				</div>
				<div id="game_status">대기중</div>
				<div id="player2" class="player_card">
					<div class="profile">(이미지2)</div>
					<div class="nickname">플레이어2</div>
					<div class="winlose">0승 6패</div>
				</div>
				<div id="game_buttons">
					<button id="back" type="button">
						<img src="<%=request.getContextPath()%>/images/back.png" />
					</button>나가기
					<button id="sorry" type="button">
						<img src="<%=request.getContextPath()%>/images/sorry.png" />
					</button>무르기
					<button id="surrender" type="button">
						<img src="<%=request.getContextPath()%>/images/surrender.png" />
					</button>항복
				</div>
			</aside>
			<div id="play_container">
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
			</div>
			<div id="chat_container">
				<div class="game_chat">
					<div class="my_chat">개못하네</div>
					<div id="your_chat_container">
						<img src="<%=request.getContextPath()%>/images/your_chat.png"
							class="your_profile" />
						<div class="your_chat">어쩔티비</div>
					</div>
				</div>
				<div class="input_chat">
					<input type="text" class="chat" name="chat"> <img
						src="<%=request.getContextPath()%>/images/send_btn.png"
						class="send_btn">
				</div>
			</div>
		</div>
			<%@ include file="lose.jsp"%>
		
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>
