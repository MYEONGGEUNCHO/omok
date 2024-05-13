<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/login/main.css" />
</head>
<%@ include file="layout/header.jsp"%>
<%
String userId = (String) session.getAttribute("userId");
String nickname = (String) session.getAttribute("nickname");
%>
<body>
	<%--//main 부분을 ajax로 가져와서 동적으로 변경 
	 //--> 메인(로그인)부터 회원가입, 로그인 완료 화면까지 --%>
	<%
	String userId = (String) session.getAttribute("userId");
	String nickname = (String) session.getAttribute("nickname");
	%>
	<main>
		<c:if test="${empty userId}">
			<%@ include file="../layout/mainContainer.jsp"%>
			<%@ include file="login/loginForm.jsp"%>
		</c:if>
		<c:if test="${!empty userId}">
			<%@ include file="../layout/mainContainer.jsp"%>
			<%@ include file="login/afterLogin.jsp"%>
		</c:if>
	</main>
	<%@ include file="layout/footer.jsp"%>
</body>
</html>