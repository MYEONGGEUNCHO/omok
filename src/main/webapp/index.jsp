<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<%@ include file="/layout/header.jsp"%>
</head>

<body>
	<main>
		<c:set var="state" value="signup" />

		<%@ include file="/layout/mainContainer.jsp"%>
		<c:if test="${empty userId}">
			<%@ include file="/user/loginForm.jsp"%>
		</c:if>
		<c:if test="${!empty userId}">
			<h1><%=nickname%>님 안녕하세요
			</h1>
			<button type="button" onclick="location.href='/omok/lobby/index.jsp'">접속하기</button>
			<br>
			<button type="button" onclick="location.href='/omok/logout'">로그아웃</button>
		</c:if>

	</main>
</body>
<%@ include file="layout/footer.jsp"%>
