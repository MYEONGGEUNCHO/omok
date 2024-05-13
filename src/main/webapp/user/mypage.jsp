<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
function deleteUser() {
	alert('1')
	//$("#deleteUser").get("/omok/deleteUser")
}
</script>

</head>
<body>
	<form action="/omok/updateUser" method="get">
		<div>
			<button type="button">프로필수정</button> <br>
		</div>
		
		<div>
			변경할 닉네임 <input type="text" name="nickname"> <br>
			변경할 비밀번호 <input type="password" name="pwd"> <br>
		</div>
		<!-- 회원탈퇴 먼가 한번에 못하게 걸어야 할거 같은데 코드리뷰하면서 얘기하기  -->
		<button type="button" onclick="deleteUser()" id="deleteUser">회원탈퇴</button> <br>
		<input type="submit" value="변경 내용 저장">
	</form>
</body>
</html>