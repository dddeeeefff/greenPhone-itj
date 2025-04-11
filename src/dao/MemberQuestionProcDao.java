package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class MemberQuestionProcDao {

	private static MemberQuestionProcDao memberQuestionProcDao;
	private Connection conn;
	private MemberQuestionProcDao() {}
	
	public static MemberQuestionProcDao getInstance() {
		
		if (memberQuestionProcDao == null)	memberQuestionProcDao = new MemberQuestionProcDao();
		
		return memberQuestionProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public ArrayList<MemberQuestion> getMemberQuestionList(String miid) {
		ArrayList<MemberQuestion> memberQuestionList = new ArrayList<MemberQuestion>();
		Statement stmt = null;
		ResultSet rs = null;
		MemberQuestion memberQuestion = null;
		
		try {
			String sql = "select * from t_bbs_member_question " +
				" where mi_id = '" + miid + "' order by bmq_date desc";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			System.out.println(sql);
			while (rs.next()) {
				memberQuestion = new MemberQuestion();
				memberQuestion.setBmq_idx(rs.getInt("bmq_idx"));
				memberQuestion.setMi_id(rs.getString("mi_id"));
				memberQuestion.setBmq_title(rs.getString("bmq_title"));
				memberQuestion.setBmq_img(rs.getString("bmq_img"));
				memberQuestion.setBmq_status(rs.getString("bmq_status"));
				memberQuestion.setBmq_content(rs.getString("bmq_content"));
				memberQuestion.setBmq_date(rs.getString("bmq_date"));
				memberQuestionList.add(memberQuestion);
			}

		} catch (Exception e) {
			System.out.println("MemberQuestionProcDao 클래스의 getMemberQuestionList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return memberQuestionList;
	}

	public int memberQuestionProcIn(String uid, String title, String content) {
		Statement stmt = null;
		int result = 0;

		try {
			String sql = "insert into t_bbs_member_question (mi_id, bmq_title, bmq_content) " +
				" values ('" + uid + "','" + title + "', '" + content + "')";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);			

		} catch (Exception e) {
			System.out.println("MemberQuestionProcDao 클래스의 memberQuestionProcIn() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
		
	}

	public MemberQuestion getMemberQuestion(String miid, int idx) {
		Statement stmt = null;
		ResultSet rs = null;
		MemberQuestion memberQuestion = null;
		
		try {
			String sql = "select * from t_bbs_member_question " +
					" where mi_id = '" + miid + "' and bmq_idx = '" + idx + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			System.out.println(sql);
			rs.next();
			memberQuestion = new MemberQuestion();
			memberQuestion.setBmq_title(rs.getString("bmq_title"));
			memberQuestion.setBmq_status(rs.getString("bmq_status"));
			memberQuestion.setMi_id(miid);
			memberQuestion.setBmq_date(rs.getString("bmq_date"));
			memberQuestion.setBmq_img(rs.getString("bmq_img"));
			memberQuestion.setBmq_content(rs.getString("bmq_content"));
			memberQuestion.setAi_idx(rs.getInt("ai_idx"));
			memberQuestion.setBmq_answer(rs.getString("bmq_answer"));
			System.out.println(sql);
			

		} catch (Exception e) {
			System.out.println("MemberQuestionProcDao 클래스의 getMemberQuestion() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		return memberQuestion;
	}

}
