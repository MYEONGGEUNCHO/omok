<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>신한DS 오목</title>
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/common.css" />
<link rel="stylesheet" href="./login/main.css" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap"
	rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="layout/header.jsp"%>
	<%--//main 부분을 ajax로 가져와서 동적으로 변경 
	 //--> 메인(로그인)부터 회원가입, 로그인 완료 화면까지 --%>
	<main>
		<%@ include file="../layout/mainContainer.jsp"%>
		<%@ include file="login/registerForm.jsp"%>
	</main>
	<%@ include file="layout/footer.jsp"%>
</body>
</html>
