<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<%@ include file="../layout/header.jsp"%>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/game/game.css" />

<script>
	$(function() {
		const $board = $('.omok_board_click');
		$board.on('click', '.cell', function() {
			const row = parseInt($(this).data('row'));
			const col = parseInt($(this).data('col'));

			// 클릭한 셀의 위치 정보를 서버로 보냅니다.
			console.log(row, col);
		});
		$("ok_btn").click(function() {
			location.back();
		})
	})
</script>
</head>
<body>
	<main>
		<div class="game_container">
			<div class="header"></div>
			<div class="player1 player_card">
				<div class="profile">(이미지)</div>
				<div class="nickname">플레이어1</div>
				<div class="winlose">5승 5패</div>
			</div>
			<div class="game_status">대기중</div>
			<div class="player2 player_card">
				<div class="profile">(이미지2)</div>
				<div class="nickname">플레이어2</div>
				<div class="winlose">0승 6패</div>
			</div>
			<div class="game_buttons">
				<button id="back" type="button" title="뒤로가기">
					<img src="<%=request.getContextPath()%>/images/back.png" />
				</button>
				<button id="sorry" type="button" title="무르기 요청">
					<img src="<%=request.getContextPath()%>/images/sorry.png" />
				</button>
				<button id="surrender" type="button" title="항복하기">
					<img src="<%=request.getContextPath()%>/images/surrender.png" />
				</button>
			</div>
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
		<%-- 		<%@ include file="lose.jsp"%> --%>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>
