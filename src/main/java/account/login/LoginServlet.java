package account.login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import account.user.UserDAO;
import account.user.UserVO;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String userId = request.getParameter("userId");
		String pwd = request.getParameter("pwd");
		
		UserVO vo = new UserVO();
		vo.setUserId(userId);
		vo.setPwd(pwd);
		HttpSession session = request.getSession();
		UserDAO dao = new UserDAO();
		UserVO loginVO = dao.login(vo);
		response.setContentType("text/html; charset=utf-8");
		if (loginVO == null) {
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('아이디 비밀번호가 올바르지 않습니다.');");
			out.println("history.back();"); // 이전 페이지로 돌아가는 JavaScript 코드
			out.println("</script>");
			
		} else {
			// 세션에 객체 저장
			session.setAttribute("loginSession", loginVO);
			session.setAttribute("userId", loginVO.getUserId());
			session.setAttribute("nickname", loginVO.getNickname());
			session.setAttribute("profile", loginVO.getProfile());
			session.setAttribute("my_win", loginVO.getWin());
			session.setAttribute("my_lose", loginVO.getLose());
//			System.out.println(session.getAttribute("profile"));
			request.setAttribute("userId", loginVO.getUserId());
			request.setAttribute("nickname", loginVO.getNickname());
//			response.sendRedirect("/omok/index.jsp");
			PrintWriter out = response.getWriter();
			out.println("<script>location.href='/omok/index.jsp'</script>");
		}
	}


}
