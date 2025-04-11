package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.time.*;
import java.sql.*;
import vo.*;

public class SellProcDao {
// 상품 판매에 관한 처리를 하는 클래스
	private static SellProcDao sellProcDao;
	private Connection conn;
	private SellProcDao() {}
	
	public static SellProcDao getInstance() {
		
		if (sellProcDao == null)	sellProcDao = new SellProcDao();
		
		return sellProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
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
			
		} catch (Exception e) {
			System.out.println("SellProcDao 클래스의 getBrandList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return brandList;
	}

	public ArrayList<ProductSeries> getSeriesList() {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<ProductSeries> seriesList = new ArrayList<ProductSeries>();
		ProductSeries ps = null;
		
		try {
			String sql = "select * from t_product_series";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				ps = new ProductSeries();
				ps.setPs_id(rs.getString("ps_id"));
				ps.setPb_id(rs.getString("pb_id"));
				ps.setPs_name(rs.getString("ps_name"));
				seriesList.add(ps);
				
			}
			
		} catch (Exception e) {
			System.out.println("SellProcDao 클래스의 getSeriesList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return seriesList;
	}

	public ArrayList<ProductInfo> getProductList() {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<ProductInfo> productList = new ArrayList<ProductInfo>();
		ProductInfo pi = null;
		
		try {
			String sql = "select * from t_product_info";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				pi = new ProductInfo();
				pi.setPi_id(rs.getString("pi_id"));
				pi.setPb_id(rs.getString("pb_id"));
				pi.setPs_id(rs.getString("ps_id"));
				pi.setPi_name(rs.getString("pi_name"));
				productList.add(pi);
				
			}
			
		} catch (Exception e) {
			System.out.println("SellProcDao 클래스의 getProductList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return productList;
	}
	
	public String sellProcIn(BuyInfo bi) {
		Statement stmt = null;
		String resultStr = "";
		int result = 0;
		String biid = bi.getPi_id().charAt(0) + "b";
		LocalDate today = LocalDate.now();
		biid = biid + (today + "").substring(2).replace("-", "") + getNextId();
		
		try {
			String sql = "insert into t_buy_info (bi_id, mi_id, pi_id, bi_color, bi_memory, bi_img1, bi_img2, bi_img3," 
				+ " bi_img4, bi_desc) values ('" + biid + "', '" + bi.getMi_id() + "', '" + bi.getPi_id() + "', '" 
				+ bi.getBi_color() + "', '" + bi.getBi_memory() + "', '" + bi.getBi_img1() + "', '" 
				+ bi.getBi_img2() + "', '" + bi.getBi_img3() + "', '" + bi.getBi_img4() + "', '" + bi.getBi_desc() + "')";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			System.out.println("SellProcDao 클래스의 sellProcIn() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		if (result > 0) {
			resultStr = result + "," + biid;
		} else {
			resultStr = "0,z";
		}
		
		return resultStr;
	}
	
	public String getNextId() {
		Statement stmt = null;
		ResultSet rs = null;
		String nextId = "01";
		int nextInt = 1;
		
		try {
			String sql = "select count(right(bi_id, 2)) + 1 from t_buy_info where left(bi_date, 10) = date(now())";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				nextInt = rs.getInt(1);
			}
			if (nextInt < 10) {
				nextId = "0" + nextInt;
			} else {
				nextId = nextInt + "";
			}
			
		} catch (Exception e) {
			System.out.println("SellProcDao 클래스의 sellProcIn() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return nextId;
	}
	
	public BuyInfo getBuyInfo(String miid, String biid) {
		Statement stmt = null;
		ResultSet rs = null;
		BuyInfo buyInfo = null;
		
		try {
			String sql = "select a.*, b.pi_name from t_buy_info a, t_product_info b where a.pi_id = b.pi_id and mi_id = '" 
				+ miid + "' and bi_id = '" + biid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				buyInfo = new BuyInfo();
				buyInfo.setBi_id(biid);
				buyInfo.setMi_id(miid);
				buyInfo.setPi_id(rs.getString("pi_id"));
				buyInfo.setBi_color(rs.getString("bi_color"));
				buyInfo.setBi_memory(rs.getString("bi_memory"));
				buyInfo.setBi_rank(rs.getString("bi_rank"));
				buyInfo.setBi_option(rs.getInt("bi_option"));
				buyInfo.setBi_img1(rs.getString("bi_img1"));
				buyInfo.setBi_img2(rs.getString("bi_img2"));
				buyInfo.setBi_img3(rs.getString("bi_img3"));
				buyInfo.setBi_img4(rs.getString("bi_img4"));
				buyInfo.setBi_desc(rs.getString("bi_desc"));
				buyInfo.setBi_predict(rs.getInt("bi_predict"));
				buyInfo.setBi_pay(rs.getInt("bi_pay"));
				buyInfo.setBi_invoice(rs.getString("bi_invoice"));
				buyInfo.setBi_bank(rs.getString("bi_bank"));
				buyInfo.setBi_account(rs.getString("bi_account"));
				buyInfo.setBi_status(rs.getString("bi_status"));
				buyInfo.setBi_date(rs.getString("bi_date"));
				buyInfo.setPi_name(rs.getString("pi_name"));
				
			}
							
		} catch (Exception e) {
			System.out.println("SellProcDao 클래스의 getBuyInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return buyInfo;
	}
	
	public int getBioption(String miid, String biid) {
		Statement stmt = null;
		ResultSet rs = null;
		int bioption = 0;
		
		try {
			String sql = "select bi_option from t_buy_info where mi_id = '" + miid + "' and bi_id = '" + biid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			bioption = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("SellProcDao 클래스의 getBioption() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return bioption;
	}
	
	public int sellProcUp(BuyInfo bi, String status) {
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "update t_buy_info set bi_status = '" + status + "'";
			if (status.equals("b") || status.equals("e") || status.equals("i")) {
				sql += " where mi_id = '" + bi.getMi_id() + "' and bi_id = '" + bi.getBi_id() + "'";
				stmt = conn.createStatement();
				result = stmt.executeUpdate(sql);
				
			} else if (status.equals("f")) {
				sql += ", bi_invoice = '" + bi.getBi_invoice() + "' where mi_id = '" + bi.getMi_id() 
					+ "' and bi_id = '" + bi.getBi_id() + "'";
				stmt = conn.createStatement();
				result = stmt.executeUpdate(sql);
				
			} else if (status.equals("j")) {
				sql += ", bi_bank = '" + bi.getBi_bank() + "', bi_account = '" + bi.getBi_account() + "' where mi_id = '" 
					+ bi.getMi_id() + "' and bi_id = '" + bi.getBi_id() + "'";
				stmt = conn.createStatement();
				result = stmt.executeUpdate(sql);
				
			} else if (status.equals("k")) {
				sql += " where mi_id = '" + bi.getMi_id() + "' and bi_id = '" + bi.getBi_id() + "'";
				stmt = conn.createStatement();
				result = stmt.executeUpdate(sql);
				
				if (result == 1) {
					sql = "update t_member_info set mi_point = mi_point + " + bi.getBi_pay() 
						+ " where mi_id = '" + bi.getMi_id() + "'";
					result += stmt.executeUpdate(sql);
					
					if (result == 2) {
						sql = "insert into t_member_point (mi_id, mp_point, mp_desc, mp_detail) values ('" + bi.getMi_id() 
							+ "', " + bi.getBi_pay() + ", '상품 구매', '" + bi.getBi_id() + "')";
						result += stmt.executeUpdate(sql);
						
						if (result == 3) {
							sql = "update t_product_option set po_stock = po_stock + 1 where po_idx = " + bi.getBi_option();
							result += stmt.executeUpdate(sql);
							
						}
					}
				}
			}
			
		} catch (Exception e) {
			System.out.println("SellProcDao 클래스의 sellProcUp() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
}
