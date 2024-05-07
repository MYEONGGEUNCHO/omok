<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<main>
	<div id="main_container">
		<img src="<%=request.getContextPath()%>/images/main_logo.png"
			id="main_logo" alt="main_logo" />
		<%@ include file="../login/loginForm.jsp"%>
	</div>
</main>