<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/common.css" />
</head>

<%@ include file="layout/header.jsp"%>
<body>
	<%--//main 부분을 ajax로 가져와서 동적으로 변경 
	 //--> 메인(로그인)부터 회원가입, 로그인 완료 화면까지 --%>
	<%
	String userId = (String) session.getAttribute("userId");
	String nickname = (String) session.getAttribute("nickname");
	%>
	<main>
		<%@ include file="../layout/mainContainer.jsp"%>
		<%@ include file="login/loginForm.jsp"%>
	</main>
	<%@ include file="layout/footer.jsp"%>
</body>
</html>