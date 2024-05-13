<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>
	<link href="<%=request.getContextPath()%>/lobby/lobby.css" />
	<%@ include file="../layout/header.jsp"%>
</head>
<body>
	<main>
	<%@ include file="../layout/mainContainer.jsp" %>
	<%@ include file="lobbyList.jsp"%>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>
