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
		<div class="congraturations">패배하셨습니다.</div>
		<button type="button" class="ok_btn">확인</button>
	</div>
</div>
