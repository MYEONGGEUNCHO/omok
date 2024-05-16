package room;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RoomController
 */
@WebServlet("/room/con/*")
public class RoomController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RoomDAO dao;

    public void init() throws ServletException {
        System.out.println("RoomController initialized");
        dao = new RoomDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if ("/list".equals(action)) {
        	List<RoomVO> list = dao.listRooms();
        	if (list == null) {
        	    list = new ArrayList<>(); // 빈 리스트를 생성하여 NullPointer 방지
        	}
        	request.setAttribute("roomList", list);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/room/list.jsp");
            dispatcher.forward(request, response);
        } else if (action.startsWith("/gameRoom")) {
            HttpSession session = request.getSession();
            String userId = (String) session.getAttribute("userId");
            String roomId = request.getParameter("roomId");
            System.out.println(userId);
            System.out.println(roomId);
            try {
                RoomVO room = dao.getRoomById(Integer.parseInt(roomId)); // Ensure this method exists and works correctly in your DAO

                if (room != null) {
                    // Assuming that user2 is initially null and gets set here
                    if (room.getUser2() == null || room.getUser2().isEmpty()) {
                        room.setUser2(userId);
                        dao.updateRoomUser2(room); // Ensure this method exists to update the user2 in the DB
                        session.setAttribute("roomInfo", room);
                    }
                    response.sendRedirect(request.getContextPath() + "/game/client.jsp?roomId=" + roomId);
                    //response.sendRedirect(request.getContextPath() + "/room/game.jsp?roomId=" + roomId + "&role=guest");
                } else {
                    response.sendRedirect(request.getContextPath() + "/room/roomList"); // Redirect back if room is not found
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/room/roomList"); // Redirect back on error
            }
        } 
       
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if ("/create".equals(action)) {
            System.out.println("doPost accessed");

            String roomName = request.getParameter("roomName");
            int time = Integer.parseInt(request.getParameter("time"));
            HttpSession session = request.getSession();
            
            // 세션에서 userId 가져오기
            String user1 = (String) session.getAttribute("userId");
            
            // 세션 확인 로그 추가
            System.out.println("Session ID: " + session.getId());
            System.out.println("Room Name: " + roomName);
            System.out.println("Time: " + time);
            System.out.println("User1 ID: " + user1);

            if (user1 == null) {
                System.out.println("User ID is null. Redirecting to login page.");
                response.sendRedirect(request.getContextPath() + "/login"); // 로그인 페이지로 리다이렉트
                return;
            }

            RoomVO room = new RoomVO();
            room.setRoomName(roomName);
            room.setTime(time);
            room.setUser1(user1);
            room.setUser2("");

            dao.addRoom(room);
            
            RoomVO addedRoom = dao.getRoomByName(roomName);
            int roomId = addedRoom.getRoomId();

            System.out.println("Room created: " + room);

            session.setAttribute("roomInfo", room);
            response.sendRedirect(request.getContextPath() + "/game/client.jsp?roomId=" + roomId + "&role=host");
            //response.sendRedirect(request.getContextPath() + "/room/game.jsp?roomId=" + roomId + "&role=host");
        }
    }

}

