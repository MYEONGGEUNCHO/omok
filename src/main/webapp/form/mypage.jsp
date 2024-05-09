<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/omok/">
		<div>
		
		</div>
		
		<div>
			변경할 닉네임 <input type="text" name="nickname"> <br>
			변경할 비밀번호 <input type="password" name="pwd"> <br>
		</div>
		<button type="button" onclick="location.href='/omok/deleteUser'">회원탈퇴</button> <br>
		<input type="submit" value="변경 내용 저장">
	</form>
</body>
</html>