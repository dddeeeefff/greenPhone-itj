package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class IndexDao {
// 메인 화면 상품 목록 및 리뷰 목록을 불러오는 클래스
	private static IndexDao indexDao;
	private Connection conn;
	private IndexDao() {}
	
	public static IndexDao getInstance() {
		
		if (indexDao == null)	indexDao = new IndexDao();
		
		return indexDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<ProductInfo> getRecentProductList() {
	// index 페이지의 최신 상품 목록을 ArrayList<ProductInfo>로 리턴하는 메소드
		ArrayList<ProductInfo> recentProductList = new ArrayList<ProductInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		ProductInfo productInfo = null;
		
		try {
			String sql = "select * from v_product_info_index_new";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				productInfo = new ProductInfo();
				String piid = rs.getString("pi_id"); 
				productInfo.setPi_id(piid);
				productInfo.setPi_img1(rs.getString("pi_img1"));
				productInfo.setPi_name(rs.getString("pi_name"));
				productInfo.setPi_min(rs.getInt("pi_min"));
				productInfo.setPi_date(rs.getString("pi_date"));
				productInfo.setStock(getStock(piid));
				recentProductList.add(productInfo);
				
			}
			
		} catch (Exception e) {
			System.out.println("IndexDao 클래스의 getRecentProductList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return recentProductList;
	}
	
	public int getStock(String piid) {
		int stock = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select sum(po_stock) stock from t_product_option where po_isview = 'y' and pi_id = '" + piid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			stock = rs.getInt("stock");
		} catch (Exception e) {
			System.out.println("IndexDao 클래스의 getStock() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return stock;
	}

	public ArrayList<ProductInfo> getHotProductList() {
	// index 페이지의 인기 상품 목록을 ArrayList<ProductInfo>로 리턴하는 메소드
		ArrayList<ProductInfo> hotProductList = new ArrayList<ProductInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		ProductInfo productInfo = null;
		
		try {
			String sql = "select * from v_product_info_index_sale";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				productInfo = new ProductInfo();
				String piid = rs.getString("pi_id");
				productInfo.setPi_id(piid);
				productInfo.setPi_img1(rs.getString("pi_img1"));
				productInfo.setPi_name(rs.getString("pi_name"));
				productInfo.setPi_min(rs.getInt("pi_min"));
				productInfo.setPi_sale(rs.getInt("pi_sale"));
				productInfo.setStock(getStock(piid));
				hotProductList.add(productInfo);
				
			}
			
		} catch (Exception e) {
			System.out.println("IndexDao 클래스의 getHotProductList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return hotProductList;
	}
	
	public ArrayList<ProductInfo> getDcProductList() {
	// index 페이지의 할인 상품 목록을 ArrayList<ProductInfo>로 리턴하는 메소드
		ArrayList<ProductInfo> dcProductList = new ArrayList<ProductInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		ProductInfo productInfo = null;
		
		try {
			String sql = "select * from v_product_info_index_dc";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				productInfo = new ProductInfo();
				String piid = rs.getString("pi_id");
				productInfo.setPi_id(piid);
				productInfo.setPi_img1(rs.getString("pi_img1"));
				productInfo.setPi_name(rs.getString("pi_name"));
				productInfo.setPi_min(rs.getInt("pi_min"));
				productInfo.setPi_dc(rs.getInt("pi_dc"));
				productInfo.setStock(getStock(piid));
				dcProductList.add(productInfo);
				
			}
			
		} catch (Exception e) {
			System.out.println("IndexDao 클래스의 getDcProductList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return dcProductList;
	}
	
	public ArrayList<BbsReview> getRecentReviewList() {
		ArrayList<BbsReview> recentReviewList = new ArrayList<BbsReview>();
		Statement stmt = null;
		ResultSet rs = null;
		BbsReview bbsReview = null;
		
		try {
			String sql = "select * from v_bbs_review_index";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				bbsReview = new BbsReview();
				bbsReview.setBr_idx(rs.getInt("br_idx"));
				bbsReview.setBr_img(rs.getString("br_img"));
				bbsReview.setBr_date(rs.getString("br_date"));
				recentReviewList.add(bbsReview);
				
			}
			
		} catch (Exception e) {
			System.out.println("IndexDao 클래스의 getRecentReviewList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return recentReviewList;
	}
	
}
