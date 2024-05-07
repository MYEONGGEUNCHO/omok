<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<form id="login_form" action="login.do" method="post">
  <input type="text" name="id" placeholder="아이디" />
  <input type="password" name="password" placeholder="비밀번호" />
  <button type="submit">로그인</button>
  <%-- ajax로 회원가입, 비밀번호 찾기 폼 가져오기 --%>
  <div id="user_info"> 
    <a type="button" href="<%=request.getContextPath()%>/form/registerForm.jsp">회원가입</a> 
    <a type="button" href="<%=request.getContextPath()%>/find.jsp">비밀번호 찾기</a>
  </div>
</form>
