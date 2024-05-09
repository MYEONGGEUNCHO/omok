package account.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {
	
	// DB관련 선언
	private Connection con;
	private PreparedStatement pstmt;
	private DataSource dataFactory;
	
	public UserDAO() {
		try {
			
			Context ctx = new InitialContext();
			Context envContext = (Context)ctx.lookup("java:/comp/env");
			dataFactory = (DataSource)envContext.lookup("jdbc/oracle");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Users 테이블 조회 기능
	 * 
	 * @param searchType : form태그 name 속성값
	 * @param searchWord : form태그 value 속성값
	 * @return : List<UserVO>
	 */
	public List<UserVO> listUsers(String searchType, String searchWord) {
		List<UserVO> list = new ArrayList<>();
		ResultSet rs = null;
		try {
			con = dataFactory.getConnection();
			String query = "select * from users";
			String whereQuery = "";
			// 조회 값이 null아니고, ""가 아니면 -> all 조회
			if (searchWord != null && !"".equals(searchWord)) {
				whereQuery = "where id like '%" + searchWord + "%' or name like '%" + searchWord +" or email like '%" + searchWord +"%'";
			// 조건 조회
			} else {
				whereQuery = " where "+searchType+" like '%"+searchWord+"%'";
			}
			
			query += whereQuery;
						
			// query 준비
			pstmt = con.prepareStatement(query);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				String userId = rs.getString("userId");
				String pwd = rs.getString("pwd");
				String nickname = rs.getString("nickname");
				String profile = rs.getString("profile");
				Date createDate = rs.getDate("createDate");
				Date updateDate = rs.getDate("updateDate");
				int win = rs.getInt("win");
				int lose = rs.getInt("lose");
				UserVO vo = new UserVO();
				
				vo.setUserId(userId);
				vo.setPwd(pwd);
				vo.setNickname(nickname);
				vo.setProfile(profile);
				vo.setCreateDate(createDate);
				vo.setUpdateDate(updateDate);
				vo.setWin(win);
				vo.setLose(lose);
				
				list.add(vo);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	/**
	 * Users 테이블에 회원 추가
	 * 
	 * @param vo : UserVO 객체
	 */
	public void addUser(UserVO vo) {
		try {
			con = dataFactory.getConnection();
//			System.out.println(vo);
			String query = "insert into users (userId, pwd, nickname, profile) values (?, ?, ?, ?)";
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, vo.getUserId());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getNickname());
			pstmt.setString(4, vo.getProfile());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 커밋 로직
			try {
			con = dataFactory.getConnection();
			String query = "commit";
			pstmt = con.prepareStatement(query);
			pstmt.executeUpdate();
			} catch (Exception e) {}
			try {pstmt.close();}catch(Exception e) {}
			try {con.close();}catch(Exception e) {}
		}
	}
	
	/**
	 * userId 중복 체크 기능
	 * 
	 * @param id: userId
	 * @return 중복이면 true/ 중복되지 않으면 false
	 */
	public boolean duplicatedId(String id) {
		boolean result = false;
		try {
			con = dataFactory.getConnection();
			String query = "select count(*) as cnt from users where userId = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			// count 하면 없어도 0, 무조건 값 존재
			rs.next();
//			System.out.println(rs.getInt("cnt"));
			if (rs.getInt("cnt") == 1) {
				result = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {pstmt.close();}catch(Exception e) {}
			try {con.close();}catch(Exception e) {}
		}
		
		return result;
	}
	
	public UserVO login(UserVO UserVO) {
		UserVO vo = null;
		String userId = UserVO.getUserId();
		String pwd = UserVO.getPwd();
		
		try {
			con = dataFactory.getConnection();
			String query = "select * from users where userId = ? and pwd = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setString(2, pwd);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new UserVO();
				vo.setUserId(rs.getString("userId"));
				vo.setNickname(rs.getString("nickname"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
}