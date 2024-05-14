<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<%@ include file="../layout/header.jsp"%>
<link rel="stylesheet" href="rank.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<main>
		<%@ include file="../layout/mainContainer.jsp"%>

		<div class="rank-container">
			<div class="rank-title">전체 순위</div>
			<div class="tag">
				<span class="r">순위</span><span class="n">닉네임</span><span class="wl">전적</span>
			</div>
			<%
			int rankidx = 1;
			// 				System.out.println(rankList);
			for (RankVO rank : rankList) {
			%>
			<div class="rank-item">
				<span class="r"><%=rankidx%>위</span><span class="n"><%=rank.getNickname()%></span>
				<span class="wl">win: <%=rank.getWin()%> / lose: <%=rank.getLose()%></span>
			</div>
			<%
			rankidx++;
			if (rankidx > 3)
				break;
			}
			%>
			<div class="rank-title">내 순위</div>
			<div class="rank-item">
				<c:if test="${myRank == null}">
					<div>로그인 후 확인하세요.</div>
				</c:if>
				<c:if test="${myRank != null}">
					<span class="r"><%=myRank.getIdx()%>위</span>
					<span class="n"><%=myRank.getNickname()%></span>
					<span class="wl">win: <%=myRank.getWin()%> / lose: <%=myRank.getLose()%></span>
				</c:if>
			</div>
		</div>
	</main>
</body>
<%@ include file="../layout/footer.jsp"%>
