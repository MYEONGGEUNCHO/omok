<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String nickname = (String) session.getAttribute("nickname");
%>
<c:if test="${!empty nickname }">
	<div>
		<h1><%=nickname%>님 안녕하세요
		</h1>
		<button type="button" onclick="location.href='/omok/lobby/index.jsp'">접속하기</button>
		<br>
		<button type="button" onclick="location.href='/omok/logout'">로그아웃</button>
	</div>
</c:if>
<c:if test="${empty nickname }">
	<button type="button" onclick="location.href='/omok/index.jsp'">돌아가기</button>
	<br>
</c:if>
<br>