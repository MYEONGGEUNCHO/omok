<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>

</script>

<form id="login_form" action="login" method="post">
	<input class="font_size1" type="text" name="userId" placeholder="아이디" />
	<input class="font_size1" type="password" name="pwd" placeholder="비밀번호" />
	<%-- ajax로 회원가입, 비밀번호 찾기 폼 가져오기 --%>
	<div id="user_info">
		<a id="signup" href="#;">회원가입</a> <a id="find_pwd"
			type="button" href="<%=request.getContextPath()%>/find.jsp">비밀번호
			찾기</a>
	</div>
	<input class="font_size3" id="login_btn" type="submit" value="로그인">

</form>