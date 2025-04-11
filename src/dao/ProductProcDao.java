package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class ProductProcDao {
// 상품 관련된 쿼리 작업(목록, 상세보기)들을 모두 처리하는 클래스
	private static ProductProcDao productProcDao;
	private Connection conn;
	private ProductProcDao() {}
	
	public static ProductProcDao getInstance() {
		if (productProcDao == null)	productProcDao = new ProductProcDao();
		
		return productProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ProductInfo getProductInfo(String piid) {
	// 사용자가 선택한 상품의 정보를 ProductInfo형 인스턴스로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ProductInfo pi = null;
		
		try { 
			String sql = "select pi_id, pi_name, pi_min, pi_dc, pi_img1, pi_img2, pi_isview " + 
					" from t_product_info where pi_isview = 'y' and pi_id = '" + piid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				pi = new ProductInfo();	// 상품정보를 저장할 인스턴스 생성
				pi.setPi_id(rs.getString("pi_id"));
				pi.setPi_name(rs.getString("pi_name"));
				pi.setPi_min(rs.getInt("pi_min"));
				pi.setPi_dc(rs.getInt("pi_dc"));
				pi.setPi_img1(rs.getString("pi_img1"));
				pi.setPi_img2(rs.getString("pi_img2"));
				pi.setPi_isview(rs.getString("pi_isview"));
				// pi.setStockList(getStockList(piid));
			}
			
		} catch(Exception e) {
			System.out.println("ProductDao 클래스의 getProductInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return pi;
	}

	public int getProductCount(String where) {
	// 검색 되는 상품의 개수(select 쿼리 실행결과의 레코드 개수)를 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		int rcnt = 0;

		try { 
			String sql = "select count(*) from t_product_info a " + 
			" where a.pi_isview = 'y' " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	rcnt = rs.getInt(1);
			
		} catch(Exception e) {
			System.out.println("ProductDao 클래스의 getProductCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return rcnt;
	}
	
	public int getStock(String piid) {
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			String sql = "select sum(po_stock) stock from t_product_option where po_isview = 'y' and pi_id = '" + piid + "' ";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	result = rs.getInt(1);
			
		} catch(Exception e) {
			System.out.println("ProductProcDao 클래스의 getStock() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return result;
	}
	
	public ArrayList<ProductInfo> getProductList(int cpage, int psize, String where, String orderBy) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<ProductInfo> productList = new ArrayList<ProductInfo>();
		ProductInfo pi = null;
		
		try {
			String sql = "select a.pi_id, b.pb_name, a.pi_name, a.pi_min, a.pi_dc, a.pi_img1, sum(c.po_stock) stock from t_product_info a, t_product_brand b, t_product_option c " +  
					" where a.pb_id = b.pb_id and a.pi_id = c.pi_id and a.pi_isview = 'y' " + where + " group by a.pi_id " + orderBy + " limit " + ((cpage - 1) * psize) + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				pi = new ProductInfo();
				pi.setPi_id(rs.getString("pi_id"));
				pi.setPi_name(rs.getString("pi_name"));
				pi.setPb_name(rs.getString("pb_name"));
				pi.setPi_min(rs.getInt("pi_min"));
				pi.setPi_dc(rs.getInt("pi_dc"));
				pi.setPi_img1(rs.getString("pi_img1"));
				pi.setStock(rs.getInt("stock"));
				productList.add(pi);
			}
			
		} catch(Exception e) {
			System.out.println("ProductDao 클래스의 getProductList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return productList;
	}
	
	public ArrayList<ProductBrand> getBrandList() {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<ProductBrand> brandList = new ArrayList<ProductBrand>();
		ProductBrand pb = null;
		
		try {
			String sql = "select * from t_product_brand";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				pb = new ProductBrand();
				pb.setPb_id(rs.getString("pb_id"));
				pb.setPb_name(rs.getString("pb_name"));
				brandList.add(pb);
			}
		} catch(Exception e) {
			System.out.println("ProductDao 클래스의 getBrandList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return brandList;
	}
	
	public String getProductViewCal(ProductOption po) {
	// '옵션 선택'버튼 클릭 시 ajax로 작업
		Statement stmt = null;
		ResultSet rs = null;
		String option = "";
		try { 
			String sql = "select po_idx, po_inc from t_product_option where po_isview = 'y' and po_stock > 0 " + 
				" and pi_id = '" + po.getPi_id() + "' and po_color = '" + po.getPo_color() + 
				"' and po_memory = '" + po.getPo_memory() + "' and po_rank = '" + po.getPo_rank() + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				// po_idx:po_inc 5:30
				// option = rs.getInt("po_idx") + ":";		// option = 5:;
				// option += rs.getInt("po_inc");			// option = 5:30;
				option = rs.getInt("po_idx") + ":" + rs.getInt("po_inc");
			}
			
		} catch(Exception e) {
			System.out.println("ProductDao 클래스의 getProductViewCal() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return option;
	}
}
