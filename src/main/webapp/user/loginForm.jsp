<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
$(function() {
    $("#login_btn").click(function(){
        var inputValue = $("#userId").val(); // input 요소의 값 가져오기
        if(inputValue === "") { // 값이 비어있는지 확인
            alert("아이디를 입력해주세요."); // 비어있으면 알림 띄우기
            event.preventDefault(); // 폼 제출 이벤트 중지
        }
        
    });
})
</script>

<form id="login_form" action="login" method="post">
	<input class="font_size1" type="text" name="userId" placeholder="아이디" id="userId" />
	<input class="font_size1" type="password" name="pwd" placeholder="비밀번호" id="userPwd"/>
	<%-- ajax로 회원가입, 비밀번호 찾기 폼 가져오기 --%>
	<div id="user_info">
		<a id="signup" href="/omok/user/signup.jsp">회원가입</a> <a id="find_pwd"
			type="button" href="<%=request.getContextPath()%>/find.jsp">비밀번호
			찾기</a>
	</div>
	<input class="font_size3" id="login_btn" type="submit" value="로그인">

</form>