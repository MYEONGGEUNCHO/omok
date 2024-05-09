<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	String userId = (String) session.getAttribute("userId");
	String nickname = (String) session.getAttribute("nickname");
%>
<body>
	<div></div>
	<h1><%=nickname %>님 안녕하세요</h1>
	<button type="button" onclick="location.href='/omok/index.jsp'">접속하기</button> <br>
	<button type="button" onclick="location.href='/omok/logout'">로그아웃</button>
</body>
</html>