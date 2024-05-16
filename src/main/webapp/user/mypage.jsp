<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rank.RankVO"%>
<%@ page import="rank.RankDAO"%>
<%@ page import="java.util.List"%>
<head>
<%@ include file="/layout/header.jsp"%>
<link rel="stylesheet" href="mypage.css">
<%
String type = (String) session.getAttribute("profile");
RankDAO dao = new RankDAO();
// 현재 사용자의 순위 정보 가져오기
RankVO myRank = dao.myrank(userId);
%>
<script>
	function deleteUser() {
		// form 요소를 직접 찾아서 submit
		var form = document.deleteForm;
		if (confirm("정말 삭제하시겠습니까??") == true) { // 확인
				form.method="post";
				form.action="/omok/deleteUser";
				form.submit();
		} else { // 취소
				return;
		}
	}

	function updateUser() {
		if (confirm("정말 수정하시겠습니까?") == true){    //확인
			document.getElementById("updateUser").submit();
		}else{   //취소
			return;
		}
	}
	$(document).ready(
			function() {
				$("select[name='profile']").change(
						function() {
							console.log($(this).val());
							// 선택된 옵션의 값을 가져옵니다.
							var selectedOption = $(this).val();

							// 이미지 요소의 src 속성을 설정합니다.
							$(".profile_img").attr(
									"src",
									"/omok/images/profile/" + selectedOption
											+ ".png");
						});
			})
</script>
</head>
<body>
	<main>
		<%@ include file="/layout/mainContainer.jsp"%>
		<div id="mypage-container">
			<div class="player_card">
				<div class="profile_div">
					<img class="profile_img" src="/omok/images/profile/type1.png" />
				</div>
				<div class="nickname"><%=session.getAttribute("nickname")%></div>
				<div class="winlose">
					<span class="wl"> <%=myRank.getWin()%>승 <%=myRank.getLose()%>패
					</span>
				</div>
			</div>
			<form class="change_profile" action="/omok/updateUser" method="post" id="updateUser">
				<div>
					<label id="profile_label">프로필 </label> <select name="profile">
						<option value='<%=session.getAttribute("profile")%>' disabled>현재 프로필</option>
						<option value="type1">type1</option>
						<option value="type2">type2</option>
						<option value="type3">type3</option>
						<option value="type4">type4</option>
						<option value="type5">type5</option>
						<option value="type6">type6</option>
						<option value="type7">type7</option>
					</select>
				</div>

				<input type="text" name="nickname" placeholder="변경할 닉네임"> <input
					type="password" name="pwd" placeholder="변경할 비밀번호">

				<!-- 회원탈퇴 먼가 한번에 못하게 걸어야 할거 같은데 코드리뷰하면서 얘기하기  -->
				<div class="mypage_buttotns">
					<!-- form 태그에 ID 추가 -->
					<button type="button" onclick="deleteUser()" name="deleteForm">회원탈퇴</button> <br>
					<input type="submit" onclick="updateUser()" value="변경 내용 저장" />
				</div>
			</form>
		</div>
	</main>
</body>
<%@ include file="/layout/footer.jsp"%>
