<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<header>
  <img src="<%=request.getContextPath()%>/images/mini_logo.png" id="mini_logo" alt="mini_logo" />
  <table>
    <tr>
      <td>
        <ul>
          <!-- 로그인 상태에서만 게임, 마이페이지 접근 -->
          <li>메인메뉴</li>
          <li>게임</li>
          <li>랭킹</li>
          <li>마이페이지</li>
        </ul>
      </td>
      <td>로그아웃</td>
    </tr>
  </table>
</header>
