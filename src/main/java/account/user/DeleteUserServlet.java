package account.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserDAO dao = new UserDAO();
		String userId = (String) session.getAttribute("userId");
		PrintWriter out = response.getWriter();
		if (userId != null) {
			dao.deleteUser(userId);
            // 삭제가 완료되면 세션에서 userId 속성을 제거
//            session.removeAttribute("userId");
            // 이후에 세션을 무효화하고 싶다면
			session.invalidate();
            out.print("<script>");
			out.print("alert('회원삭제되었습니다.');");
			out.print("location.href='index.jsp';");
			out.print("</script>");
		} else {
			// userId가 null인 경우
            // 로그인 화면으로 보내기
			out.print("<script>");
			out.print("alert('로그인이 필요합니다.');");
			out.print("location.href='index.jsp';");
			out.print("</script>");
		}
	}

}
