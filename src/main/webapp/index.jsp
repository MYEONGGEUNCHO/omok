<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<%@ include file="layout/header.jsp"%>
</head>
<%
String userId = (String) session.getAttribute("userId");
%>

<body>
	<%--//main 부분을 ajax로 가져와서 동적으로 변경 
	 //--> 메인(로그인)부터 회원가입, 로그인 완료 화면까지 --%>
	<main>
		<c:set var="state" value="signup" />

		<%@ include file="/layout/mainContainer.jsp"%>
		<c:if test="${empty userId}">
			<%@ include file="/user/loginForm.jsp"%>
		</c:if>
		<c:if test="${!empty userId}">
			<%@ include file="/user/afterLogin.jsp"%>
		</c:if>

	</main>
</body>
<%@ include file="layout/footer.jsp"%>
