package rank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class RankDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private DataSource dataFactory;

	public RankDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<RankVO> rank() {
		List<RankVO> list = new ArrayList<>();
		ResultSet rs = null;
		try {
			con = dataFactory.getConnection();
			String query = "SELECT * FROM (SELECT nickname, win, lose, DENSE_RANK() OVER (ORDER BY win DESC) AS rank FROM users)"
					+ " WHERE rank <= 3";
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				RankVO rank = new RankVO();
				rank.setNickname(rs.getString("nickname"));
				rank.setWin(rs.getInt("win"));
				rank.setLose(rs.getInt("lose"));
				rank.setIdx(rs.getInt("rank"));
				list.add(rank);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}

		return list;
	}

	private void close(AutoCloseable ac) {
		if (ac != null) {
			try {
				ac.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public RankVO myrank(String id) {
		RankVO rank = null;
		ResultSet rs = null;

		try {
			con = dataFactory.getConnection();
			String query = "select nickname, win, lose, rank from (select userId, nickname, win, lose, rank() over(order by win desc) rank from users) where userId = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				rank = new RankVO();
				rank.setIdx(rs.getInt("rank"));
				rank.setNickname(rs.getString("nickname"));
				rank.setWin(rs.getInt("win"));
				rank.setLose(rs.getInt("lose"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return rank;

	}

}