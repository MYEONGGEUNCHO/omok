<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="../layout/header.jsp"%>
<body>
	<%--//main 부분을 ajax로 가져와서 동적으로 변경 
	 //--> 메인(로그인)부터 회원가입, 로그인 완료 화면까지 --%>
	<main>
		<%@ include file="../layout/mainContainer.jsp"%>
		<div id="welcome-container">
			<div class="say_hello">
				<div class="login_id"></div>
				님 안녕하세요.
			</div>
			<button>게임 시작</button>
			<button type="button">로그아웃</button>
		</div>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>