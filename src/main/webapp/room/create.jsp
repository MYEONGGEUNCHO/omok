<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<%@ include file="../layout/header.jsp"%>
<link rel="stylesheet" href="create.css"/>

<script>
	$(document).ready(function() {
		$(".time-btn").click(function() {
			console.log(this, "clicked");
			// 모든 버튼의 'active' 클래스 제거
			$(".time-btn").removeClass("active");
			// 클릭된 버튼에만 'active' 클래스 추가
			$(this).addClass("active");
			// 시간 버튼 클릭 시 해당 값을 input hidden에 설정
			$("#timeInput").val($(this).data("time"));
		});

		$("#createRoomForm").submit(function() {
			if ($("#timeInput").val() === "") {
				alert("제한 시간을 선택해 주세요.");
				return false; // 시간이 선택되지 않으면 폼 제출 방지
			}
			if ($("#roomName").val().trim() === "") {
				alert("방 이름을 입력해 주세요.");
				return false; // 방 이름이 비어있으면 폼 제출 방지
			}
			return true; // 모든 검증 통과 후 폼 제출
		});
	});
</script>
</head>
<body>
	<main>
		<%@include file="../layout/mainContainer.jsp"%>
<!-- 		<div class="current-user"> -->
<!-- 			현재 로그인된 사용자: -->
<%-- 			<%=session.getAttribute("nickname")%> --%>
<!-- 		</div> -->
		<div class="create_room_container">
			<h1 class="create_title">방 만들기</h1>
			<form id="createRoomForm"
				action="<%=request.getContextPath()%>/room/con/create" method="POST">
				<div class="input-group">
					<label for="roomName">방 이름</label> <input type="text"
						id="roomName" name="roomName" required>
				</div>
				<div class="input-group">
					<label>시간</label>
					<div class="time_group">
						<button type="button" class="time-btn" data-time="1">1분</button>
						<button type="button" class="time-btn" data-time="3">3분</button>
						<button type="button" class="time-btn" data-time="5">5분</button>
						<input type="hidden" id="timeInput" name="time">
					</div>
				</div>
				<div class="input-group">
					<input type="submit" value="생성">
				</div>
			</form>
		</div>
	</main>
</body>
<%@ include file="../layout/footer.jsp"%>