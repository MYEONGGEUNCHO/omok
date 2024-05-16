<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="rank.RankVO"%>
<%@ page import="rank.RankDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="account.user.UserDAO"%>
<%@ page import="account.user.UserVO"%>
<%@ page import="java.lang.System"%>
<%@ page import="java.io.*"%>

<head>
<%@ include file="/layout/header.jsp"%>
<%
String type = (String) session.getAttribute("profile");
String role = (String) session.getAttribute("role");
System.out.println("role : " + role);
RankDAO rdao = new RankDAO();
// 현재 사용자의 순위 정보 가져오기
RankVO myRank = rdao.myrank(userId);

// HttpSession sess = request.getSession();
// Enumeration<String> attributeNames = sess.getAttributeNames();
// while(attributeNames.hasMoreElements()) {
//     String attributeName = attributeNames.nextElement();
//     Object value = sess.getAttribute(attributeName);
// 	System.out.println("세션에 있는 값 : " + attributeName+", " +value);
// }
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/game/game.css" />
<script>
	var role = "<%=role%>";
</script>
<%@ include file="game.jsp"%>
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
			if (role != null && role.equals("host")) { // 호스트인 경우
			%>
			<div class="player2 player_card">
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
			<div class="player2 player_card">
				<div class="profile">
					<img src="/omok/images/profile/<%=user1.getProfile()%>.png">
				</div>
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
						<td class="cell" data-row=1 data-col=0></td>
						<td class="cell" data-row=2 data-col=0></td>
						<td class="cell" data-row=3 data-col=0></td>
						<td class="cell" data-row=4 data-col=0></td>
						<td class="cell" data-row=5 data-col=0></td>
						<td class="cell" data-row=6 data-col=0></td>
						<td class="cell" data-row=7 data-col=0></td>
						<td class="cell" data-row=8 data-col=0></td>
						<td class="cell" data-row=9 data-col=0></td>
						<td class="cell" data-row=10 data-col=0></td>
						<td class="cell" data-row=11 data-col=0></td>
						<td class="cell" data-row=12 data-col=0></td>
						<td class="cell" data-row=13 data-col=0></td>
						<td class="cell" data-row=14 data-col=0></td>
						<td class="cell" data-row=15 data-col=0></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=1></td>
						<td class="cell" data-row=1 data-col=1></td>
						<td class="cell" data-row=2 data-col=1></td>
						<td class="cell" data-row=3 data-col=1></td>
						<td class="cell" data-row=4 data-col=1></td>
						<td class="cell" data-row=5 data-col=1></td>
						<td class="cell" data-row=6 data-col=1></td>
						<td class="cell" data-row=7 data-col=1></td>
						<td class="cell" data-row=8 data-col=1></td>
						<td class="cell" data-row=9 data-col=1></td>
						<td class="cell" data-row=10 data-col=1></td>
						<td class="cell" data-row=11 data-col=1></td>
						<td class="cell" data-row=12 data-col=1></td>
						<td class="cell" data-row=13 data-col=1></td>
						<td class="cell" data-row=14 data-col=1></td>
						<td class="cell" data-row=15 data-col=1></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=2></td>
						<td class="cell" data-row=1 data-col=2></td>
						<td class="cell" data-row=2 data-col=2></td>
						<td class="cell" data-row=3 data-col=2></td>
						<td class="cell" data-row=4 data-col=2></td>
						<td class="cell" data-row=5 data-col=2></td>
						<td class="cell" data-row=6 data-col=2></td>
						<td class="cell" data-row=7 data-col=2></td>
						<td class="cell" data-row=8 data-col=2></td>
						<td class="cell" data-row=9 data-col=2></td>
						<td class="cell" data-row=10 data-col=2></td>
						<td class="cell" data-row=11 data-col=2></td>
						<td class="cell" data-row=12 data-col=2></td>
						<td class="cell" data-row=13 data-col=2></td>
						<td class="cell" data-row=14 data-col=2></td>
						<td class="cell" data-row=15 data-col=2></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=3></td>
						<td class="cell" data-row=1 data-col=3></td>
						<td class="cell" data-row=2 data-col=3></td>
						<td class="cell" data-row=3 data-col=3></td>
						<td class="cell" data-row=4 data-col=3></td>
						<td class="cell" data-row=5 data-col=3></td>
						<td class="cell" data-row=6 data-col=3></td>
						<td class="cell" data-row=7 data-col=3></td>
						<td class="cell" data-row=8 data-col=3></td>
						<td class="cell" data-row=9 data-col=3></td>
						<td class="cell" data-row=10 data-col=3></td>
						<td class="cell" data-row=11 data-col=3></td>
						<td class="cell" data-row=12 data-col=3></td>
						<td class="cell" data-row=13 data-col=3></td>
						<td class="cell" data-row=14 data-col=3></td>
						<td class="cell" data-row=15 data-col=3></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=4></td>
						<td class="cell" data-row=1 data-col=4></td>
						<td class="cell" data-row=2 data-col=4></td>
						<td class="cell" data-row=3 data-col=4></td>
						<td class="cell" data-row=4 data-col=4></td>
						<td class="cell" data-row=5 data-col=4></td>
						<td class="cell" data-row=6 data-col=4></td>
						<td class="cell" data-row=7 data-col=4></td>
						<td class="cell" data-row=8 data-col=4></td>
						<td class="cell" data-row=9 data-col=4></td>
						<td class="cell" data-row=10 data-col=4></td>
						<td class="cell" data-row=11 data-col=4></td>
						<td class="cell" data-row=12 data-col=4></td>
						<td class="cell" data-row=13 data-col=4></td>
						<td class="cell" data-row=14 data-col=4></td>
						<td class="cell" data-row=15 data-col=4></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=5></td>
						<td class="cell" data-row=1 data-col=5></td>
						<td class="cell" data-row=2 data-col=5></td>
						<td class="cell" data-row=3 data-col=5></td>
						<td class="cell" data-row=4 data-col=5></td>
						<td class="cell" data-row=5 data-col=5></td>
						<td class="cell" data-row=6 data-col=5></td>
						<td class="cell" data-row=7 data-col=5></td>
						<td class="cell" data-row=8 data-col=5></td>
						<td class="cell" data-row=9 data-col=5></td>
						<td class="cell" data-row=10 data-col=5></td>
						<td class="cell" data-row=11 data-col=5></td>
						<td class="cell" data-row=12 data-col=5></td>
						<td class="cell" data-row=13 data-col=5></td>
						<td class="cell" data-row=14 data-col=5></td>
						<td class="cell" data-row=15 data-col=5></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=6></td>
						<td class="cell" data-row=1 data-col=6></td>
						<td class="cell" data-row=2 data-col=6></td>
						<td class="cell" data-row=3 data-col=6></td>
						<td class="cell" data-row=4 data-col=6></td>
						<td class="cell" data-row=5 data-col=6></td>
						<td class="cell" data-row=6 data-col=6></td>
						<td class="cell" data-row=7 data-col=6></td>
						<td class="cell" data-row=8 data-col=6></td>
						<td class="cell" data-row=9 data-col=6></td>
						<td class="cell" data-row=10 data-col=6></td>
						<td class="cell" data-row=11 data-col=6></td>
						<td class="cell" data-row=12 data-col=6></td>
						<td class="cell" data-row=13 data-col=6></td>
						<td class="cell" data-row=14 data-col=6></td>
						<td class="cell" data-row=15 data-col=6></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=7></td>
						<td class="cell" data-row=1 data-col=7></td>
						<td class="cell" data-row=2 data-col=7></td>
						<td class="cell" data-row=3 data-col=7></td>
						<td class="cell" data-row=4 data-col=7></td>
						<td class="cell" data-row=5 data-col=7></td>
						<td class="cell" data-row=6 data-col=7></td>
						<td class="cell" data-row=7 data-col=7></td>
						<td class="cell" data-row=8 data-col=7></td>
						<td class="cell" data-row=9 data-col=7></td>
						<td class="cell" data-row=10 data-col=7></td>
						<td class="cell" data-row=11 data-col=7></td>
						<td class="cell" data-row=12 data-col=7></td>
						<td class="cell" data-row=13 data-col=7></td>
						<td class="cell" data-row=14 data-col=7></td>
						<td class="cell" data-row=15 data-col=7></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=8></td>
						<td class="cell" data-row=1 data-col=8></td>
						<td class="cell" data-row=2 data-col=8></td>
						<td class="cell" data-row=3 data-col=8></td>
						<td class="cell" data-row=4 data-col=8></td>
						<td class="cell" data-row=5 data-col=8></td>
						<td class="cell" data-row=6 data-col=8></td>
						<td class="cell" data-row=7 data-col=8></td>
						<td class="cell" data-row=8 data-col=8></td>
						<td class="cell" data-row=9 data-col=8></td>
						<td class="cell" data-row=10 data-col=8></td>
						<td class="cell" data-row=11 data-col=8></td>
						<td class="cell" data-row=12 data-col=8></td>
						<td class="cell" data-row=13 data-col=8></td>
						<td class="cell" data-row=14 data-col=8></td>
						<td class="cell" data-row=15 data-col=8></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=9></td>
						<td class="cell" data-row=1 data-col=9></td>
						<td class="cell" data-row=2 data-col=9></td>
						<td class="cell" data-row=3 data-col=9></td>
						<td class="cell" data-row=4 data-col=9></td>
						<td class="cell" data-row=5 data-col=9></td>
						<td class="cell" data-row=6 data-col=9></td>
						<td class="cell" data-row=7 data-col=9></td>
						<td class="cell" data-row=8 data-col=9></td>
						<td class="cell" data-row=9 data-col=9></td>
						<td class="cell" data-row=10 data-col=9></td>
						<td class="cell" data-row=11 data-col=9></td>
						<td class="cell" data-row=12 data-col=9></td>
						<td class="cell" data-row=13 data-col=9></td>
						<td class="cell" data-row=14 data-col=9></td>
						<td class="cell" data-row=15 data-col=9></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=10></td>
						<td class="cell" data-row=1 data-col=10></td>
						<td class="cell" data-row=2 data-col=10></td>
						<td class="cell" data-row=3 data-col=10></td>
						<td class="cell" data-row=4 data-col=10></td>
						<td class="cell" data-row=5 data-col=10></td>
						<td class="cell" data-row=6 data-col=10></td>
						<td class="cell" data-row=7 data-col=10></td>
						<td class="cell" data-row=8 data-col=10></td>
						<td class="cell" data-row=9 data-col=10></td>
						<td class="cell" data-row=10 data-col=10></td>
						<td class="cell" data-row=11 data-col=10></td>
						<td class="cell" data-row=12 data-col=10></td>
						<td class="cell" data-row=13 data-col=10></td>
						<td class="cell" data-row=14 data-col=10></td>
						<td class="cell" data-row=15 data-col=10></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=11></td>
						<td class="cell" data-row=1 data-col=11></td>
						<td class="cell" data-row=2 data-col=11></td>
						<td class="cell" data-row=3 data-col=11></td>
						<td class="cell" data-row=4 data-col=11></td>
						<td class="cell" data-row=5 data-col=11></td>
						<td class="cell" data-row=6 data-col=11></td>
						<td class="cell" data-row=7 data-col=11></td>
						<td class="cell" data-row=8 data-col=11></td>
						<td class="cell" data-row=9 data-col=11></td>
						<td class="cell" data-row=10 data-col=11></td>
						<td class="cell" data-row=11 data-col=11></td>
						<td class="cell" data-row=12 data-col=11></td>
						<td class="cell" data-row=13 data-col=11></td>
						<td class="cell" data-row=14 data-col=11></td>
						<td class="cell" data-row=15 data-col=11></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=12></td>
						<td class="cell" data-row=1 data-col=12></td>
						<td class="cell" data-row=2 data-col=12></td>
						<td class="cell" data-row=3 data-col=12></td>
						<td class="cell" data-row=4 data-col=12></td>
						<td class="cell" data-row=5 data-col=12></td>
						<td class="cell" data-row=6 data-col=12></td>
						<td class="cell" data-row=7 data-col=12></td>
						<td class="cell" data-row=8 data-col=12></td>
						<td class="cell" data-row=9 data-col=12></td>
						<td class="cell" data-row=10 data-col=12></td>
						<td class="cell" data-row=11 data-col=12></td>
						<td class="cell" data-row=12 data-col=12></td>
						<td class="cell" data-row=13 data-col=12></td>
						<td class="cell" data-row=14 data-col=12></td>
						<td class="cell" data-row=15 data-col=12></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=13></td>
						<td class="cell" data-row=1 data-col=13></td>
						<td class="cell" data-row=2 data-col=13></td>
						<td class="cell" data-row=3 data-col=13></td>
						<td class="cell" data-row=4 data-col=13></td>
						<td class="cell" data-row=5 data-col=13></td>
						<td class="cell" data-row=6 data-col=13></td>
						<td class="cell" data-row=7 data-col=13></td>
						<td class="cell" data-row=8 data-col=13></td>
						<td class="cell" data-row=9 data-col=13></td>
						<td class="cell" data-row=10 data-col=13></td>
						<td class="cell" data-row=11 data-col=13></td>
						<td class="cell" data-row=12 data-col=13></td>
						<td class="cell" data-row=13 data-col=13></td>
						<td class="cell" data-row=14 data-col=13></td>
						<td class="cell" data-row=15 data-col=13></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=14></td>
						<td class="cell" data-row=1 data-col=14></td>
						<td class="cell" data-row=2 data-col=14></td>
						<td class="cell" data-row=3 data-col=14></td>
						<td class="cell" data-row=4 data-col=14></td>
						<td class="cell" data-row=5 data-col=14></td>
						<td class="cell" data-row=6 data-col=14></td>
						<td class="cell" data-row=7 data-col=14></td>
						<td class="cell" data-row=8 data-col=14></td>
						<td class="cell" data-row=9 data-col=14></td>
						<td class="cell" data-row=10 data-col=14></td>
						<td class="cell" data-row=11 data-col=14></td>
						<td class="cell" data-row=12 data-col=14></td>
						<td class="cell" data-row=13 data-col=14></td>
						<td class="cell" data-row=14 data-col=14></td>
						<td class="cell" data-row=15 data-col=14></td>
					</tr>
					<tr>
						<td class="cell" data-row=0 data-col=15></td>
						<td class="cell" data-row=1 data-col=15></td>
						<td class="cell" data-row=2 data-col=15></td>
						<td class="cell" data-row=3 data-col=15></td>
						<td class="cell" data-row=4 data-col=15></td>
						<td class="cell" data-row=5 data-col=15></td>
						<td class="cell" data-row=6 data-col=15></td>
						<td class="cell" data-row=7 data-col=15></td>
						<td class="cell" data-row=8 data-col=15></td>
						<td class="cell" data-row=9 data-col=15></td>
						<td class="cell" data-row=10 data-col=15></td>
						<td class="cell" data-row=11 data-col=15></td>
						<td class="cell" data-row=12 data-col=15></td>
						<td class="cell" data-row=13 data-col=15></td>
						<td class="cell" data-row=14 data-col=15></td>
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
					<input type="hidden" value="<%=nickname%>" id="chat_id"> <input type="text" id="inputMessage" class="chat" name="chat" onkeyup="enterkey()" autofocus> <input type="submit" id="sendbtn" onclick="send()" value="" style="background-image: url(<%=request.getContextPath()%>/images/send_btn.png)" class="send_btn" />
				</div>
			</div>
		</div>
		<div class="winner"></div>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>
