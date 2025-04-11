package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class CartDao {
	private static CartDao cartDao;
	private Connection conn;
	private CartDao() {}
	
	public static CartDao getInstance() {
		if (cartDao == null)	cartDao = new CartDao();
		
		return cartDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int cartInsert (SellCart sc) {
	// 사용자가 선택한 상품을 장바구니 담기
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "update t_sell_cart set sc_cnt = sc_cnt + " + sc.getSc_cnt() + 
						 "  where mi_id = '" + sc.getMi_id() + "' " +
						 " and pi_id = '" + sc.getPi_id() + "' " + 
						 " and po_idx = " + sc.getPo_idx();
			//System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			// 현재 로그인한 회원의 장바구니에 동일한 상품 및 옵션이 있으면 수량을 증가시키는 쿼리 실행
			if (result == 0) {
			// 동일한 상품(옵션 포함)이 없으면 장바구니에 새롭게 추가
				sql = "insert into t_sell_cart (mi_id, pi_id, po_idx, sc_cnt) values " +
					  " ('" + sc.getMi_id() + "', '" + sc.getPi_id() + "', '" + sc.getPo_idx() + "', '" + sc.getSc_cnt() + "') ";
				// System.out.println(sql);
				result = stmt.executeUpdate(sql);
			}
			
		} catch(Exception e) {
			System.out.println("CartDao 클래스의 cartInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int cartDelete (String where) {
	// 장바구니 내 지정한 상품 삭제
		Statement stmt = null;
		int result = 0;
		try { 
			String sql = "delete from t_sell_cart " + where;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("CartDao 클래스의 cartDelete() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int cartUpdate(SellCart sc) {
	// 수량 변경
		Statement stmt = null;
		int result = 0;
		
		try {
			stmt = conn.createStatement();
			String sql = "update t_sell_cart set sc_cnt = '" + sc.getSc_cnt() + "' where mi_id = '" + sc.getMi_id() + "' and sc_idx = '" + sc.getSc_idx() + "' "; 
			// System.out.println(sql);
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("CartDao 클래스의 cartUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	
	public ArrayList<SellCart> getCartList(String miid) {
	// 장바구니에서 보여줄 정보들을  ArrayList로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<SellCart> cartList = new ArrayList<SellCart>();
		SellCart sc = null;
		
		try {
			//ProductProcDao ppd = ProductProcDao.getInstance();
			//ppd.setConnection(conn);
			
			String sql = "select a.*, b.pi_name, b.pi_dc, b.pi_img1, c.po_name, c.po_inc, " + 
						 " ceil(((b.pi_min * (100 - b.pi_dc) / 100) * (1 + c.po_inc / 100)) * a.sc_cnt) price " + 
						 " from t_sell_cart a, t_product_info b, t_product_option c " +
						 " where a.pi_id = b.pi_id and a.pi_id = c.pi_id and a.po_idx = c.po_idx and b.pi_isview = 'y' and a.mi_id = '" + miid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				sc = new SellCart();
				sc.setSc_idx(rs.getInt("sc_idx"));
				sc.setPi_id(rs.getString("pi_id"));
				sc.setPo_idx(rs.getInt("po_idx"));
				sc.setSc_cnt(rs.getInt("sc_cnt"));
				sc.setPi_name(rs.getString("pi_name"));
				sc.setPi_dc(rs.getInt("pi_dc"));
				sc.setPi_img1(rs.getString("pi_img1"));
				sc.setPo_name(rs.getString("po_name"));
				sc.setPo_inc(rs.getInt("po_inc"));
				sc.setPi_min(rs.getInt("price"));
				
				// 현재 상품의 옵션 및 재고량 목록
				cartList.add(sc);
			}
			
		} catch(Exception e) {
			System.out.println("CartDao 클래스 getCartList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return cartList;
	}
}
