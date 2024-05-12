<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<form id="login" action="/omok/login" method="post">
  <input type="text" name="userId" placeholder="아이디" />
  <input type="password" name="pwd" placeholder="비밀번호" />
  <button type="submit">로그인</button>
  <a type="button" href="/omok/user/signup.jsp">회원가입</a>
  <a type="button" href="/find.jsp">비밀번호 찾기</a>
</form>
