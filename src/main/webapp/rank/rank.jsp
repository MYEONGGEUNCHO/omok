<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rank.RankVO"%>
<%@ page import="rank.RankDAO"%>
<%@ page import="java.util.List"%>
<%-- <% session.setAttribute("userId", "player4"); --%>

<head>
<%@ include file="/layout/header.jsp"%>
<link rel="stylesheet" href="rank.css" />
</head>
<%
RankDAO dao = new RankDAO();
// 전체 순위 정보 가져오기
List<RankVO> rankList = dao.rank();
// 현재 사용자의 순위 정보 가져오기
RankVO myRank = dao.myrank(userId);
%>
<body>
	<main>
		<%@ include file="/layout/mainContainer.jsp"%>

		<div class="rank-container">
			<div class="rank-title">전체 순위</div>
			<div class="tag">
				<span class="r">순위</span><span class="n">닉네임</span><span class="wl">전적</span>
			</div>
			<div class="total-rank">

				<%
				// 			int rankidx = 1;
				// 				System.out.println(rankList);
				for (RankVO rank : rankList) {
				%>
				<div class="rank-item">
					<span class="r"><%=rank.getIdx()%>위</span><span class="n"><%=rank.getNickname()%></span>
					<span class="wl"><%=rank.getWin()%>승 / <%=rank.getLose()%>패</span>
				</div>
				<%
				// 			rankidx++;
				// 			if (rankidx > 3)
				// 				break;
				}
				%>
			</div>
			<div class="rank-title">내 순위</div>
			<div class="rank-item">
				<c:if test="${empty nickname}">
					<div>로그인 후 확인하세요.</div>
				</c:if>
				<c:if test="${!empty nickname}">
					<div class="center">
						<span class="n"><%=myRank.getNickname()%>님은 </span> <span
							class="wl"><%=myRank.getWin()%>승 <%=myRank.getLose()%>패로</span> <span
							class="r"><%=myRank.getIdx()%>위 입니다.</span>
					</div>
				</c:if>
			</div>
		</div>
	</main>
</body>
<%@ include file="/layout/footer.jsp"%>
