<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<%@include file="/layout/header.jsp"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	var id_check = false;
	function btn_duplicate() {
		var _userId = $("#userId").val();
		//console.log(_userId);
		if (_userId == '') {
			alert("ID를 입력하세요");
			return;
		}
		$.ajax({
			type : 'get',
			dataType : 'text',
			async : false,
			url : '/omok/createUser',
			data : {
				userId : _userId
			},
			success : function(data, textStatus) {
				console.log(data);
				if (data == 'usable') {
					$("#message").text('사용할 수 있는 ID입니다.');
					$("#id_check").prop("disabled", true);
					id_check = true;
				} else {
					$("#message").text('사용할 수 없는 ID입니다.');
				}
			}
		});
	}

	// 	function btn_correspond() {
	// 		var p1 = $("#password1").val();
	// 		var p2 = $("#password2").val();

	// 		if (p1 == "" || p2 == "") {
	// 			alert('비밀번호를 입력해주세요')
	// 			return false;
	// 		}

	// 		if (p1.length > 30) {
	// 			alert('입력한 글자가 30글자 이하여야 합니다.');
	// 			return false;
	// 		}

	// 		if (p1 != p2) {
	// 			alert("비밀번호가 일치하지 않습니다.")
	// 			return false;
	// 		} else {
	// 			alert("사용가능한 비밀번호 입니다.")
	// 			return true;
	// 		}
	// 	}
	var pwdOk = false;
	$(document).ready(
			function() {
				// 		비밀번호 변경될때마다 체크 후 조건 확인
				$("#password1").change(function() {
					var p1 = $("#password1").val();
					var p2 = $("#password2").val();
					if (p1 == "" || p2 == "") {
						$("#password_check").html("비밀번호와 비밀번호 확인을 채워주세요.");
					}
					if (p1.length > 30 || p2.length > 30) {
						$("#password_check").html("비밀번호는 30자 이내로 작성해주세요.");
						pwdOk = false;
						return;
					}
					if (p1 != p2) {
						$("#password_check").html("비밀번호가 일치하지 않습니다.");
						pwdOk = false;
						return;
					}
					if (p1 == p2 && p1.length < 30 && p2.length <= 30) {
						$("#password_check").html("사용 가능한 비밀번호 입니다.");
						pwdOk = true;
					}
					console.log(p1, p2);
				})
				$("#password2").change(function() {
					var p1 = $("#password1").val();
					var p2 = $("#password2").val();
					if (p1 == "" || p2 == "") {
						$("#password_check").html("비밀번호와 비밀번호 확인을 채워주세요.");
					}
					if (p1.length > 30 || p2.length > 30) {
						$("#password_check").html("비밀번호는 30자 이내로 작성해주세요.");
						pwdOk = false;
						return;
					}
					if (p1 != p2) {
						$("#password_check").html("비밀번호가 일치하지 않습니다.");
						pwdOk = false;
						return;
					}
					if (p1 == p2 && p1.length < 30 && p2.length <= 30) {
						$("#password_check").html("사용 가능한 비밀번호 입니다.");
						pwdOk = true;
					}
					console.log(p1, p2);
				})
				// 		프로필 선택에 따른 이미지 노출
				// select 요소의 값이 변경될 때마다 실행됩니다.
				$("select[name='profile']").change(
						function() {
							// 선택된 옵션의 값을 가져옵니다.
							var selectedOption = $(this).val();

							// 이미지 요소의 src 속성을 설정합니다.
							$("#profile_img").attr(
									"src",
									"/omok/images/profile/" + selectedOption
											+ ".png");
						});

			})
	function fn_sendMember() {
		//alert('1')
		var frmMember = $("#frmMember");
		//console.log(frmMember);
		var userId = $("#userId").val();
		var pwd = $("#password1").val();
		var nickname = $("#nickname").val();
		if (id_check == false) {
			alert('아이디 중복확인을 해주세요.');
		} else if (userId.length == 0 || userId == '') {
			alert('아이디는 필수입니다.');
		} else if (pwd.length == 0 || pwd == '') {
			alert('비밀번호는 필수입니다.')
		} else if (pwdOk == false) {
			alert("비밀번호는 30자 이내로 작성해주세요.");
		} else if (nickname.length == 0 || nickname == '') {
			alert('닉네임은 필수입니다.')
		} else {
			frmMember.submit();
		}
	}
</script>
</head>
<body>
	<main>
		<%@ include file="/layout/mainContainer.jsp"%>

		<form action="/omok/createUser" method="post" name="frmMember"
			id="frmMember">
			<div>
				<input type="text" id="userId" name="userId" placeholder="아이디">
				<input type="button" id="id_check" value="중복확인"
					onclick="btn_duplicate()">
			</div>
			<div id="message"></div>
			<input type="password" id="password1" name="pwd" placeholder="비밀번호">
			<input type="password" id="password2" placeholder="비밀번호 확인">
			<div id="password_check"></div>
			<!-- 			<input type="button" value="확인" onclick="btn_correspond()"> <br> -->
			<input type="text" name="nickname" id="nickname" placeholder="닉네임">
			<div id="profile-container">
				<label id="profile_label">프로필 </label> <select name="profile">
					<option value="type1" selected>type1</option>
					<option value="type2">type2</option>
					<option value="type3">type3</option>
					<option value="type4">type4</option>
					<option value="type5">type5</option>
					<option value="type6">type6</option>
					<option value="type7">type7</option>
				</select>
				<div id="profile_img_box">
					<img id="profile_img" src="/omok/images/profile/type1.png" />
				</div>
			</div>
			<input type="button" value="회원가입" onclick="fn_sendMember()">
			<input type="hidden" name="command" value="addUser">
		</form>
	</main>
</body>
<%@ include file="/layout/footer.jsp"%>