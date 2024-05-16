<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>신한DS 오목</title>
<link rel="stylesheet" href="/omok/css/reset.css" />
<link rel="stylesheet" href="/omok/css/common.css" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap"
	rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	// 헤더 상단 마우스 오버 시 슬라이드 구현
	$(function() {
		$(".depth2").hide();
		$(".head_bot").find(".depth1").children().on("mouseover", function() {
			$(this).find("ul").stop().slideDown();
		});

		$(".head_bot").find(".depth1").children().on("mouseleave", function() {
			$(this).find("ul").slideUp();
		});
	});

	//dom 로드 완료 시 세션에서 userId, nickname 정보 받아오기
	$(document)
			.ready(
					function() {
<%String userId = (String) session.getAttribute("userId");
String nickname = (String) session.getAttribute("nickname");
String profile = (String) session.getAttribute("profile");
Integer my_win = (Integer) session.getAttribute("my_win");
Integer my_lose = (Integer) session.getAttribute("my_lose");
System.out.println("(header.jsp)" + session.getAttribute("nickname") + "님이 로그인했습니다.");
System.out.println(profile + " : " + my_win + " : " + my_lose);

if (userId == null && request.getRequestURI() != "/omok/index.jsp") {%>
		alert('로그인 후 이용하세요.');
		location.href="<%=request.getContextPath()%>
	/index.jsp";
<%}%>
	})
</script>
</head>

<header>
	<a href="<%=request.getContextPath()%>/index.jsp"> <img
		src="<%=request.getContextPath()%>/images/logo.png" id="mini_logo"
		alt="mini_logo" />
	</a>
	<div class="head_bot">
		<div>
			<div>
				<ul class="depth1 clear">
					<!-- 로그인 상태에서만 게임, 마이페이지 접근 -->
					<li><a href="">메인메뉴</a>
						<ul class="depth2">
							<li><a href="/omok/room/con/list">게임</a></li>
							<li><a href="/omok/rank/rank.jsp">랭킹</a></li>
							<li><a href="/omok/user/mypage.jsp">마이페이지</a></li>
						</ul></li>
					<li><c:if test="${!empty nickname}">
							<a href=""><%=nickname%>님 </a>
							<ul class="depth2">
								<li><a href="/omok/logout">로그아웃</a></li>
							</ul>
						</c:if> <c:if test="${empty nickname}">
							<a href="/omok/index.jsp">로그인</a>
						</c:if></li>
				</ul>
			</div>
		</div>
	</div>
</header>