package account.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CreateUserServlet
 */
@WebServlet("/createUser")
public class CreateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 회원 ID 중복확인
	 * 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id = request.getParameter("userId");
//		System.out.println(id);
		try {
			UserDAO dao = new UserDAO();
			// UserDAO의 중복아이디 체크 기능
			boolean result = dao.duplicatedId(id);
//			System.out.println(result);
			PrintWriter out = response.getWriter();
			if (result) {
				out.print("not_usable");
			} else {
				out.print("usable");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 회원정보로 회원등록 기능
	 * 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getParameter("command");
		UserDAO dao = new UserDAO();
//		System.out.println(request.getParameter("userId"));
		String id = request.getParameter("userId");
		String pwd = request.getParameter("pwd");
		String nickname = request.getParameter("nickname");
		String profile = request.getParameter("profile");
		
		if (id != null && pwd != null && nickname != null) {
			UserVO vo = new UserVO();
			vo.setUserId(id);
			vo.setPwd(pwd);
			vo.setNickname(nickname);
			vo.setProfile(profile);
			dao.addUser(vo);
			System.out.println(vo.getUserId());
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/user/welcome.jsp");
		rd.forward(request, response);
	}

}
