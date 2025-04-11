package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class NoticeProcDao {
	private static NoticeProcDao noticeProcDao;
	private Connection conn;
	private NoticeProcDao() {}
	
	public static NoticeProcDao getInstance() {
		if (noticeProcDao == null)		noticeProcDao = new NoticeProcDao();
		
		return noticeProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<BbsNotice> getNoticeList(int cpage, int psize, String where){
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<BbsNotice> noticeList = new ArrayList<BbsNotice>();
		BbsNotice bn = null;

		
		try {
			String sql = "select * from t_bbs_notice where bn_isview = 'y'" + where
				+ " order by bn_idx desc limit " + ((cpage - 1) * psize) + ", " + psize;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				bn = new BbsNotice();
				bn.setBn_idx(rs.getInt("bn_idx"));
				bn.setBn_title(rs.getString("bn_title"));
				bn.setAi_idx(rs.getInt("ai_idx"));
				bn.setBn_read(rs.getInt("bn_read"));
				bn.setBn_date(rs.getString("bn_date"));
				noticeList.add(bn);
				
			}
			
		}catch(Exception e) {
			System.out.println("NoticeProcDao 클래스의 getNoticeList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return noticeList;
	}
	
	public int getNoticeListCount(String where) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(bn_idx) from t_bbs_notice where bn_isview = 'y'" + where;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	rcnt = rs.getInt(1);
			
		}catch(Exception e){
			System.out.println("NoticeProcDao 클래스의 getNoticeListCount() 메소드 오류");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		return rcnt;
	}
	
	public BbsNotice getNoticeDetail(int bnidx) {
		Statement stmt = null;
		ResultSet rs = null;
		BbsNotice noticeDetail = new BbsNotice();
		
		try {
			String sql = "select * from t_bbs_notice where bn_idx = " + bnidx;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				noticeDetail.setBn_idx(rs.getInt("bn_idx"));
				noticeDetail.setAi_idx(rs.getInt("ai_idx"));
				noticeDetail.setBn_title(rs.getString("bn_title"));
				noticeDetail.setBn_img(rs.getString("bn_img"));
				noticeDetail.setBn_content(rs.getString("bn_content"));
				noticeDetail.setBn_read(rs.getInt("bn_read"));
				noticeDetail.setBn_date(rs.getString("bn_date"));
				
			}
		}catch(Exception e) {
			System.out.println("NoticeProcDao 클래스의 getNoticeDetail() 메소드 오류");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		return noticeDetail;
	}
	
	public int readUpdate(int bnidx) {
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "update t_bbs_notice set bn_read = bn_read + 1 where bn_idx = " + bnidx;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		}catch(Exception e) {
			System.out.println("NoticeProcDao 클래스의 readUpdate() 메소드 오류");
			e.printStackTrace();
		}finally {
			close(stmt);
		}
		
		return result;
	}
}
