<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<form id="register" action="register.do" method="post">
  <input type="text" name="id" placeholder="아이디" />
  <input type="password" name="password" placeholder="비밀번호" />
  <button type="submit">로그인</button>
  <a type="button" href="/signup.jsp">회원가입</a>
  <a type="button" href="/find.jsp">비밀번호 찾기</a>
</form>
