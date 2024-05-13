<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ page import="rank.RankVO"%>
<%@ page import="rank.RankDAO"%>
<%@ page import="java.util.List"%>
<%-- <% session.setAttribute("userId", "player4"); --%>
<%
RankDAO dao = new RankDAO();

// 전체 순위 정보 가져오기
List<RankVO> rankList = dao.rank();

// 현재 사용자의 아이디 (세션 등에서 가져와야 함)
String userId = (String) session.getAttribute("userId");

// 현재 사용자의 순위 정보 가져오기
RankVO myRank = dao.myrank(userId);
%>
<head>
<meta charset="UTF-8">
<title>랭크 페이지</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

	<%@ include file="../layout/header.jsp"%>
	<div class="rank-block">
		<h1>전체 순위</h1>
		<div class="tag">
			<span class="r">순위</span><span class="n">닉네임</span><span class="wl">전적</span>
		</div>
		<%
		int rankidx = 1;
		for (RankVO rank : rankList) {
		%>
		<div class="rank-item">
			<span class="r"><%=rankidx%>위</span><span class="n"><%=rank.getNickname()%></span>
			<span class="wl">win: <%=rank.getWin()%> / lose: <%=rank.getLose()%></span>
		</div>
		<%
		rankidx++;
		}
		%>
		<h1>내 순위</h1>
		<div class="rank-item">
			<span class="r"><%=myRank.getIdx()%>위</span><span class="n"><%=myRank.getNickname()%></span>
			<span class="wl">win: <%=myRank.getWin()%> / lose: <%=myRank.getLose()%></span>
		</div>
	</div>



	<%@ include file="../layout/footer.jsp"%>
</body>
<style>
h1 {
	text-align: center;
}

.tag {
	margin: 0 auto;
	margin-bottom: 10px;
	width: 800px;
	height: auto;
	background-color: none;
	width: 800px;
	display: felx;
}

.tag>span {
	font-size: 30px;
}

.r {
	float: left;
	margin-left: 20px;
}

.n {
	margin-left: 100px;
}

.wl {
	float: right;
}

.rank-block {
	padding: 10px;
	width: 1200px;
	height: 700px;
	background-color: #FFD7CE;
	margin: 0 auto;
}

.rank-item {
	margin: 0 auto;
	margin-bottom: 20px;
	width: 800px;
	height: 90px;
	background-color: white;
	width: 800px;
	display: flex;
	align-items: center;
}
.rank-item .wl {
    margin-left: auto;
    margin-right: 10px;
}


.rank-item>span {
	font-size: 30px;
}
</style>
</html>