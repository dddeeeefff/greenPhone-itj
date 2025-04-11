package dao;

import static db.JdbcUtil.*;
import java.util.*;


import java.sql.*;
import vo.*;

public class ReviewProcDao {
	private static ReviewProcDao reviewProcDao;
	private Connection conn;
	private ReviewProcDao() {}
	
	public static ReviewProcDao getInstance() {
		
		if (reviewProcDao == null)	reviewProcDao = new ReviewProcDao();
		
		return reviewProcDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public ArrayList<BbsReview> getReviewList(int cpage, int psize) {
		ArrayList<BbsReview> reviewList = new ArrayList<BbsReview>();
		Statement stmt = null;
		ResultSet rs = null;
		BbsReview bbsReview = null;
		
		try {
			String sql = "select * from t_bbs_review where br_isdel = 'n' order by br_idx desc" +
			" limit " + ((cpage - 1) * psize) + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				bbsReview = new BbsReview();
				bbsReview.setBr_idx(rs.getInt("br_idx"));
				bbsReview.setMi_id(rs.getString("mi_id"));
				bbsReview.setSi_id(rs.getString("si_id"));
				bbsReview.setPi_id(rs.getString("pi_id"));
				bbsReview.setBr_name(rs.getString("br_name"));
				bbsReview.setBr_title(rs.getString("br_title"));
				bbsReview.setBr_content(rs.getString("br_content"));
				bbsReview.setBr_img(rs.getString("br_img"));
				bbsReview.setBr_read(rs.getInt("br_read"));
				bbsReview.setBr_date(rs.getString("br_date"));
				reviewList.add(bbsReview);
			}
		} catch (Exception e) {
			System.out.println("ReviewProcDao �겢�옒�뒪�쓽 getReviewList() 硫붿냼�뱶 �삤瑜�");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return reviewList;
	}

	public int getReviewListCount() {
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_bbs_review where br_isdel = 'n'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			result = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("ReviewProcDao 클래스의 getReviewList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return result;
	}

	public BbsReview getReview(String bridx) {
		BbsReview review = new BbsReview();
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
				String sql ="select * from t_bbs_review where br_idx = '" + bridx + "'";
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				rs.next();
				review.setMi_id(rs.getString("mi_id"));
				review.setSi_id(rs.getString("si_id"));
				review.setPi_id(rs.getString("pi_id"));
				review.setBr_name(rs.getString("br_name"));
				review.setBr_title(rs.getString("br_title"));
				review.setBr_content(rs.getString("br_content"));
				review.setBr_img(rs.getString("br_img"));
				review.setBr_read(rs.getInt("br_read"));
				review.setBr_date(rs.getString("br_date"));
		} catch (Exception e) {
			System.out.println("ReviewProcDao 클래스의 getReview() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return review;
		
	}

	public int readUpdate(String bridx) {
		Statement stmt = null;
		int result = 0;
		try {
			String sql = "update t_bbs_review set br_read = br_read + 1 where br_idx = " + bridx;
			System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);

		} catch(Exception e) {
			System.out.println("ReviewProcDao 클래스의 readUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}

	public BbsReview getPrevReview(String bridx) {
		BbsReview PrevReview = new BbsReview();
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_bbs_review where br_idx = (select min(br_idx) from t_bbs_review where br_isdel = 'n' and br_idx > "+ bridx + ")";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				PrevReview.setBr_idx(rs.getInt("br_idx"));
				PrevReview.setMi_id(rs.getString("mi_id"));
				PrevReview.setSi_id(rs.getString("si_id"));
				PrevReview.setPi_id(rs.getString("pi_id"));
				PrevReview.setBr_name(rs.getString("br_name"));
				PrevReview.setBr_title(rs.getString("br_title"));
				PrevReview.setBr_content(rs.getString("br_content"));
				PrevReview.setBr_img(rs.getString("br_img"));
				PrevReview.setBr_read(rs.getInt("br_read"));
				PrevReview.setBr_date(rs.getString("br_date"));
			} else {
				PrevReview = null;
			}
		} catch (Exception e) {
			System.out.println("ReviewProcDao 클래스의 getPrevReview() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return PrevReview;
		
	}

	public BbsReview getNextReview(String bridx) {
		BbsReview NextReview = new BbsReview();
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_bbs_review where br_idx = (select max(br_idx) from t_bbs_review where br_isdel = 'n' and br_idx < "+ bridx + ")";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				NextReview.setBr_idx(rs.getInt("br_idx"));
				NextReview.setMi_id(rs.getString("mi_id"));
				NextReview.setSi_id(rs.getString("si_id"));
				NextReview.setPi_id(rs.getString("pi_id"));
				NextReview.setBr_name(rs.getString("br_name"));
				NextReview.setBr_title(rs.getString("br_title"));
				NextReview.setBr_content(rs.getString("br_content"));
				NextReview.setBr_img(rs.getString("br_img"));
				NextReview.setBr_read(rs.getInt("br_read"));
				NextReview.setBr_date(rs.getString("br_date"));
			} else {
				NextReview = null;
			}
		} catch (Exception e) {
			System.out.println("ReviewProcDao 클래스의 getPrevReview() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return NextReview;
	}

}
