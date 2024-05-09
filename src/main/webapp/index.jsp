<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>신한DS 오목</title>
    <link rel="stylesheet" href="./css/reset.css" />
    <link rel="stylesheet" href="./css/common.css" />
  </head>
  <body>
  <%
	String userId = (String) session.getAttribute("userId");
	String nickname = (String) session.getAttribute("nickname");
  %>
  <%@ include file="layout/header.jsp" %>
    <main>
      <img src="logo" alt="main_logo" />
      <%@ include file="form/loginForm.jsp" %>
    </main>
    <%@ include file="layout/footer.jsp" %>
  </body>
</html>
