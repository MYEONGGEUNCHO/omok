<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="room.RoomVO"%>
<%@ page import="java.util.List"%>
<head>
<%@ include file="../layout/header.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/room/list.css" />
</head>
<body>
	<main>
		<%@ include file="../layout/mainContainer.jsp"%>
<!-- 		<div class="current-user"> -->
<!-- 			현재 로그인된 사용자: -->
<%-- 			<%=session.getAttribute("userId")%> --%>
<!-- 		</div> -->
		<div class="main-content">
			<ul class="room-list">
				<%
				List<RoomVO> rooms = (List<RoomVO>) request.getAttribute("roomList");
				for (RoomVO room : rooms) {
				%>
				<li class="room-item">
					<div class="room-details">
						<span class="room-name"><%=room.getRoomName()%></span> <span
							class="room-time">시간 제한: <%=room.getTime()%>분
						</span>
					</div> <a
					href="<%=request.getContextPath()%>/room/con/gameRoom?roomId=<%=room.getRoomId()%>"
					class="enter-room">입장</a>
				</li>
				<%
				}
				%>
			</ul>
		</div>
	</main>
</body>
<%@ include file="../layout/footer.jsp"%>