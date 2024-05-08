<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<form id="register" action="../register.do" method="post">
  <input type="text" name="id" placeholder="아이디" />
  <input type="button" name="id_check" value="중복 아이디 확인" />
  <input type="password" name="password" placeholder="비밀번호" />
  <input type="password" name="password_confirm" placeholder="비밀번호 확인" />
  <input type="text" name="nickname" placeholder="닉네임" />

  <select name="character">
    <option value="1">캐릭터1</option>
    <option value="2">캐릭터2</option>
    <option value="3">캐릭터3</option>
    <option value="4">캐릭터4</option>
    <option value="5">캐릭터5</option>
    <option value="6">캐릭터6</option>
    <option value="7">캐릭터7</option>
  </select>

  <button type="submit">회원가입</button>
</form>


<div id="main_container">
	<img src="<%=request.getContextPath()%>/images/main_logo.png"
		id="main_logo" alt="main_logo" />
	<div class="main_layout">
		<div id="top_bar">
			<img id="close_btn"
				src="<%=request.getContextPath()%>/images/close_btn.png" />
		</div>
		<form id="login_form" action="login.do" method="post">
			<input class="font_size2" type="text" name="id" placeholder="아이디" />
			<input class="font_size2" type="password" name="password"
				placeholder="비밀번호" />
			<%-- ajax로 회원가입, 비밀번호 찾기 폼 가져오기 --%>
			<div id="user_info">
				<a type="button"
					href="<%=request.getContextPath()%>/form/registerForm.jsp">회원가입</a>
				<a type="button" href="<%=request.getContextPath()%>/find.jsp">비밀번호
					찾기</a>
			</div>
			<input class="font_size3" id="login_btn" type="submit" value="로그인">

		</form>
	</div>
</div>