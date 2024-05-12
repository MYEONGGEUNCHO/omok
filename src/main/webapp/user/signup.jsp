<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">

function btn_duplicate() {
	var _userId = $("#userId").val();
	//console.log(_userId);
	if (_userId == '') {
		alert("ID를 입력하세요");
		return;
	}
	$.ajax({
		type:'get',
		dataType:'text',
		async:false,
		url:'/omok/createUser',
		data:{userId:_userId},
		success:function(data,textStatus) {
			console.log(data);
			if (data == 'usable') {
				$("#message").text('사용할 수 있는 ID입니다.');
				$("#btn_duplicate").prop("disabled",true);
			} else {
				$("#message").text('사용할 수 없는 ID입니다.');
			}
		}
	});
}

function btn_correspond() {
	var p1 = $("#password1").val();
	var p2 = $("#password2").val();
	
	if(p1 == "" || p2 == "") {
		alert('비밀번호를 입력해주세요')
		return false;
	}
	
	if(p1.length > 30) {
		alert('입력한 글자가 30글자 이하여야 합니다.');
        return false;
	}
	
	if( p1 != p2) {
		alert("비밀번호가 일치하지 않습니다.")
		return false;
	} else {
		alert("사용가능한 비밀번호 입니다.")
		return true;
	}
}

function fn_sendMember() {
	//alert('1')
	var frmMember = $("#frmMember");
	//console.log(frmMember);
	var userId = $("#userId").val();
	
	var pwd = $("#password1").val();
	var nickname = $("#nickname").val();
	
	if (userId.length == 0 || userId == '') {
		alert('아이디는 필수입니다.');
	} else if (pwd.length == 0 || pwd == '') {
		alert('비밀번호는 필수입니다.')
	} else if (nickname.length == 0 ||nickname == '') {
		alert('닉네임은 필수입니다.')
	} else {
		frmMember.submit();
	};
}

</script>
</head>
<body>
	<form action="/omok/createUser" method="post" name="frmMember" id="frmMember">
		아이디 <input type="text" id="userId" name="userId"> <input type="button" value="중복확인" onclick="btn_duplicate()"> <br>
		<div id="message"></div>
		비밀번호 <input type="password" id="password1" name="pwd"> <br>
		비밀번호 확인 <input type="password" id="password2"> <input type="button" value="확인" onclick="btn_correspond()"> <br>
		닉네임 <input type="text" name="nickname" id="nickname"> <br>
		프로필
		<select name="profile">
			<option value="type1" selected> type1 </option>
			<option value="type2"> type2 </option>
			<option value="type3"> type3 </option>
			<option value="type4"> type4 </option>
			<option value="type5"> type5 </option>
			<option value="type6"> type6 </option>
			<option value="type7"> type7 </option>
		</select> <br>
		<input type="button" value="회원가입" onclick="fn_sendMember()">
		<input type="hidden" name="command" value="addUser">
	</form>
</body>
</html>