package room;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class RoomDAO {
    private DataSource dataFactory;
    private Connection con;
    private PreparedStatement pstmt;

    public RoomDAO() {
        try {
            Context ctx = new InitialContext();
            Context envContext = (Context) ctx.lookup("java:/comp/env");
            dataFactory = (DataSource) envContext.lookup("jdbc/oracle");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void addRoom(RoomVO vo) {
        try {
            con = dataFactory.getConnection();
            String query = "INSERT INTO room (roomId,roomName, time, user1, user2) VALUES (room_seq.NEXTVAL,?, ?, ?, ?)";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, vo.getRoomName());
            pstmt.setInt(2, vo.getTime());
            pstmt.setString(3, vo.getUser1());
            pstmt.setString(4, vo.getUser2());
            int result = pstmt.executeUpdate();
            System.out.println("Insert operation result: " + result);  // 로깅 추가
        } catch (SQLException e) {
            System.out.println("SQLException in addRoom: " + e.getMessage());  // 에러 로깅
            e.printStackTrace();
        } finally {
            close(pstmt);
            close(con);
        }
    }


    public List<RoomVO> listRooms() {
        List<RoomVO> rooms = new ArrayList<>();
        ResultSet rs = null;
        try {
            con = dataFactory.getConnection();
            String query = "SELECT * FROM room WHERE user2 IS NULL OR user2 = ''";
            pstmt = con.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                RoomVO room = new RoomVO();
                room.setRoomId(rs.getInt("roomId"));
                room.setRoomName(rs.getString("roomName"));
                room.setTime(rs.getInt("time"));
                room.setUser1(rs.getString("user1"));
                room.setUser2(rs.getString("user2"));
                rooms.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(con);
        }
        return rooms;
    }
//    public List<RoomVO> listRooms() {
//        List<RoomVO> rooms = new ArrayList<>();
//        ResultSet rs = null;
//        try {
//            con = dataFactory.getConnection();
//            String query = "SELECT * FROM room";
//            pstmt = con.prepareStatement(query);
//            rs = pstmt.executeQuery();
//
//            while (rs.next()) {
//                RoomVO room = new RoomVO();
//                room.setRoomId(rs.getInt("roomId"));
//                room.setRoomName(rs.getString("roomName"));
//                room.setTime(rs.getInt("time"));
//                room.setUser1(rs.getString("user1"));
//                room.setUser2(rs.getString("user2"));
//                rooms.add(room);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            close(rs);
//            close(pstmt);
//            close(con);
//        }
//        return rooms;
//    }

    private void close(AutoCloseable ac) {
        if (ac != null) {
            try {
                ac.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public RoomVO getRoomById(int roomId) {
        RoomVO room = null;
        ResultSet rs = null;
        try {
            con = dataFactory.getConnection();
            String query = "SELECT * FROM room WHERE roomId = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, roomId);
            rs = pstmt.executeQuery();
            System.out.println("getRoomById 진입");

            if (rs.next()) {
                room = new RoomVO();
                room.setRoomId(rs.getInt("roomId"));
                room.setRoomName(rs.getString("roomName"));
                room.setTime(rs.getInt("time"));
                room.setUser1(rs.getString("user1"));
                room.setUser2(rs.getString("user2"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(con);
        }
        return room;
    }
    
    public RoomVO getRoomByName(String roomName) {
        RoomVO room = null;
        ResultSet rs = null;
        try {
            con = dataFactory.getConnection();
            String query = "SELECT * FROM room WHERE roomName = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, roomName);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                room = new RoomVO();
                room.setRoomId(rs.getInt("roomId"));
                room.setRoomName(rs.getString("roomName"));
                room.setTime(rs.getInt("time"));
                room.setUser1(rs.getString("user1"));
                room.setUser2(rs.getString("user2"));
            }
        } catch (SQLException e) {
            System.out.println("SQLException in getRoomByName: " + e.getMessage());
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(con);
        }
        return room;
    }

    
    public void updateRoomUser2(RoomVO room) {
        try {
            con = dataFactory.getConnection();
            String query = "UPDATE room SET user2 = ? WHERE roomId = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, room.getUser2());
            pstmt.setInt(2, room.getRoomId());
            int result = pstmt.executeUpdate();
            System.out.println("Update operation result: " + result);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(pstmt);
            close(con);
        }
    }


}

