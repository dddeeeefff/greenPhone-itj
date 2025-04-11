package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class FreeReplyProcDao {
// 자유 게시판 댓글 관련 쿼리 작업(목록, 등록, 삭제)들을 모두 처리하는 클래스
	private static FreeReplyProcDao freeReplyProcDao;
	private Connection conn;
	private FreeReplyProcDao() {}
	
	public static FreeReplyProcDao getInstance() {
		
		if (freeReplyProcDao == null)	freeReplyProcDao = new FreeReplyProcDao();
		
		return freeReplyProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<BbsFreeReply> getReplyList(int bfidx) {
	// 지정한 게시글에 속한 댓글들의 목록을 ArrayList<BbsFreeReply>로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<BbsFreeReply> replyList = new ArrayList<BbsFreeReply>();		// 댓글 목록을 저장할 객체
		BbsFreeReply bfr = null;		// replyList에 저장할 하나의 댓글 정보를 담을 인스턴스
		
		try {
			String sql = "select * from t_bbs_free_reply where bfr_isdel = 'n' and bf_idx = " + bfidx;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				bfr = new BbsFreeReply();		// 하나의 댓글 정보들을 저장할 BbsFreeReply 형 인스턴스 생성
				bfr.setBfr_idx(rs.getInt("bfr_idx"));
				bfr.setBf_idx(bfidx);
				bfr.setMi_id(rs.getString("mi_id"));
				bfr.setBfr_content(rs.getString("bfr_content"));
				bfr.setBfr_date(rs.getString("bfr_date"));
				replyList.add(bfr);
			}
			
		} catch (Exception e) {
			System.out.println("FreeReplyProcDao 클래스의 getReplyList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return replyList;
	}
	
	public int replyInsert(BbsFreeReply bfr) {
	// 사용자가 입력한 댓글을 테이블에 저장하는 메소드
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "insert into t_bbs_free_reply (bf_idx, mi_id, bfr_content) values ("
					 + bfr.getBf_idx() + ", '" + bfr.getMi_id() + "', '" + bfr.getBfr_content() + "')";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
			sql = "update t_bbs_free set bf_reply = bf_reply + 1 where bf_idx = " + bfr.getBf_idx();
			stmt.executeUpdate(sql);
					
		} catch (Exception e) {
			System.out.println("FreeReplyProcDao 클래스의 replyInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int replyDelete(BbsFreeReply bfr) {
	// 지정한 댓글을 삭제하는 메소드
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "update t_bbs_free_reply set bfr_isdel = 'y' where mi_id = '" + bfr.getMi_id()
				+ "' and bfr_idx = " + bfr.getBfr_idx();
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
			sql = "update t_bbs_free set bf_reply = bf_reply - 1 where bf_reply > 0 and bf_idx = " + bfr.getBf_idx();
			stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			System.out.println("FreeReplyProcDao 클래스의 replyDelete() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}

}
