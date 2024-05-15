package account.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateUser")
public class UpdateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		String nickname = request.getParameter("nickname");
		String profile = request.getParameter("profile");
		UserDAO dao = new UserDAO();
		PrintWriter out = response.getWriter();
		try {
			dao.updateUser(userId, profile, nickname);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
