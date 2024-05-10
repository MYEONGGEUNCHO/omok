<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ page import="room.RoomVO" %>
<%@ page import="java.util.List" %>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>오목 - 방 목록</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/reset.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/common.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/room/list.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <% session.setAttribute("userId", "player24"); %>
    <%@ include file="../layout/header.jsp"%>
    <div class="current-user">
        현재 로그인된 사용자: <%= session.getAttribute("userId") %>
    </div>
    <div class="main-content">
        <ul class="room-list">
            <% List<RoomVO> rooms = (List<RoomVO>) request.getAttribute("roomList");
               for (RoomVO room : rooms) { %>
            <li class="room-item">
                <div class="room-details">
                    <span class="room-name"><%=room.getRoomName()%></span>
                    <span class="room-time">시간 제한: <%=room.getTime()%>분</span>
                </div>
                <a href="<%=request.getContextPath()%>/room/con/gameRoom?roomId=<%=room.getRoomId()%>" class="enter-room">입장</a>
            </li>
            <% } %>
        </ul>
    </div>
    <%@ include file="../layout/footer.jsp"%>
</body>
</html>
