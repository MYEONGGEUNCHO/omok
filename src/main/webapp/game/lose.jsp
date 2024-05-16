<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="black_container">
	<div class="alert">
		<img class="close_btn"
			src="<%=request.getContextPath()%>/images/close_btn.png" />
		<div class="profile">
			<img src="<%=request.getContextPath()%>/images/loser.png"
				class="profile_img" />
		</div>
		<div class="congratulations">패배하셨습니다.</div>
		<button type="button" class="ok_btn">확인</button>
	</div>
</div>

<script>
	$(document).ready(function() {
		// 창 크기가 변경될 때마다 #black_container 크기를 조정
		$(window).resize(function() {
			resizeBlackContainer();
		});

		// 초기 #black_container 크기 설정
		resizeBlackContainer();

		// 확인 버튼 클릭 시 페이지 이동
		$(".ok_btn").click(function() {
			location.href = "/omok/lobby/index.jsp";
		});
		//확인 버튼 누르면 로비로 돌아가기
		$(".ok_btn").click(function() {
			location.href = "/omok/lobby/index.jsp";
		})

		//x 버튼 누르면 창 닫기
		$(".close_btn").click(function() {
			$("#black_container").css("display", "none");
		});
	});

	function resizeBlackContainer() {
		// 브라우저 창 너비와 높이 계산
		var windowWidth = $(window).width();
		var windowHeight = $(window).height();

		// #black_container 너비와 높이를 100%로 설정
		$("#black_container").css({
			width : windowWidth + "px",
			height : windowHeight + "px"
		});
	}
</script>