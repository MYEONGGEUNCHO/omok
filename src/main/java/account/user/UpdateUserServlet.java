package account.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/updateUser")
public class UpdateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserDAO dao = new UserDAO();
		String userId = (String) session.getAttribute("userId");
		System.out.println("변경을 원하는 유저ID: " + userId);
		String pwd = request.getParameter("pwd");
		String nickname = request.getParameter("nickname");
		String profile = request.getParameter("profile");
		PrintWriter out = response.getWriter();
		try {
			dao.updateUser(userId, profile, nickname, pwd);
			out.print("<script>");
			out.print("alert('회원 정보가 변경되었습니다.');");
			out.print("location.href='/omok/user/mypage.jsp';");
			out.print("</script>");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
