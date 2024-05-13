<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>신한DS 오목</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reset.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/common.css?ver=1" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap"
	rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

</head>
<header>
	<a href="<%=request.getContextPath()%>/index.jsp"> <img
		src="<%=request.getContextPath()%>/images/logo.png" id="mini_logo"
		alt="mini_logo" />
	</a>
	<table>
		<tr>
			<td>
				<ul>
					<!-- 로그인 상태에서만 게임, 마이페이지 접근 -->
					<li><a href="">메인메뉴</a></li>
					<li><a href="">게임</a></li>
					<li><a href="">랭킹</a></li>
					<li><a href="">마이페이지</a></li>
				</ul>
			</td>
			<td><a href="/omok/logout">로그아웃</a></td>
		</tr>
	</table>
</header>
