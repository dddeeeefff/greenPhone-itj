package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import java.time.LocalDate;

import vo.*;

public class OrderProcDao {
	private static OrderProcDao orderProcDao;
	private Connection conn;
	private OrderProcDao() {}
	
	public static OrderProcDao getInstance() {
		
		if (orderProcDao == null)	orderProcDao = new OrderProcDao();
		
		return orderProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	
	public ArrayList<SellCart> getCartList (String kind, String sql) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<SellCart> cartList = new ArrayList<SellCart>();
		SellCart sc = null;
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			
			while (rs.next()) {
				sc = new SellCart();
				if (kind.equals("c"))	sc.setSc_idx(rs.getInt("sc_idx"));
				// 장바구니를 통한 구매일 경우 장바구니 인덱스를 추가
				sc.setPi_id(rs.getString("pi_id"));
				sc.setPi_img1(rs.getString("pi_img1"));
				sc.setPi_name(rs.getString("pi_name"));
				sc.setPi_min(rs.getInt("price"));
				sc.setPi_dc(rs.getInt("pi_dc"));
				sc.setSc_cnt(rs.getInt("cnt"));
				sc.setPo_idx(rs.getInt("po_idx"));
				sc.setPo_name(rs.getString("po_name"));
				cartList.add(sc);
			}
			
		} catch(Exception e) {
			System.out.println("OrderDao 클래스의 getCartList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return cartList;
	}
	

	public String getSiid(String kind) {
		Statement stmt = null;
		ResultSet rs = null;
		String siid = null;
		
		try {
			stmt = conn.createStatement();
			LocalDate today = LocalDate.now();	// yyyy-mm-dd
			String td = (today + "").substring(2).replace("-", "");	// yymmdd

			String sql = "select right(si_id, 2) seq from t_sell_info " + 
			" where mid(si_id, 3, 6) = '" + td + "' order by si_date desc limit 0, 1;";
			// 같은 날 입력된 주문번호들 중 가장 최근 것을 가져오는 쿼리
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	// 오늘 구매한 주문번호가 있으면
				int num = Integer.parseInt(rs.getString("seq")) + 1;
				siid = kind + td + num;
			} else {	// 오늘 첫 구매일 경우
				siid = kind + td + "11";
			}
			
		} catch(Exception e) {
			System.out.println("OrderProcDao 클래스의 getSiid() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}

		return siid;
	}
	
	public String orderInsert(String kind, SellInfo si, String temp) {
		Statement stmt = null;
		ResultSet rs = null;
		int rcount = 0, target = 0;
		// rcount : 실제 쿼리 실행결과로 정상적으로 적용되는 레코드 개수를 누적 저장할 변수
		// target : insert, update, delete 등의 쿼리 실행횟수로 적용되어야 할 레코드의 총 개수를 저장할 변수
		String siid = getSiid(si.getSi_id());

		try {
			stmt = conn.createStatement();

			// t_sell_info 테이블 insert
			String sql = "insert into t_sell_info(si_id, mi_id, si_name, si_phone, si_zip, si_addr1, si_addr2, " + 
			"si_memo, si_payment, si_pay, si_upoint, si_spoint, si_invoice, si_status) values('" + 
			siid + "', '" + si.getMi_id() +  "', '" + si.getSi_name() + "', '" + si.getSi_phone() + "', '" + si.getSi_zip() + 
			"', '" + si.getSi_addr1() + "', '" + si.getSi_addr2() + "', '" + si.getSi_memo() + "', '" + si.getSi_payment() + 
			"', '" + (si.getSi_pay() - si.getSi_upoint()) + "', '" + si.getSi_upoint() + "', '" + si.getSi_spoint() + "', '" + "" + 
			"', '" + si.getSi_status() + "') ";
			
			target++;	rcount = stmt.executeUpdate(sql);
			
			if(kind.equals("c")) {
			// 장바구니를 통한 주문일 경우
				sql = "select a.pi_id, a.po_idx, a.sc_cnt, b.pi_name, b.pi_img1, b.pi_dc, ceil(((b.pi_min * (100 - b.pi_dc) / 100) * (1 + c.po_inc / 100)) * a.sc_cnt) price, c.po_name " + 
					  " from t_sell_cart a, t_product_info b, t_product_option c " +
					  " where a.pi_id = b.pi_id and a.pi_id = c.pi_id and a.mi_id = '" + si.getMi_id() + "' and a.po_idx = c.po_idx and (";
				String delWhere = " where mi_id = '" + si.getMi_id() + "' and (";
				String[] arr = temp.split(",");
				// 장바구니 테이블의 인덱스번호들로 배열 생성
				for(int i = 0; i < arr.length; i++) {
					if(i == 0) {
						sql += "a.sc_idx = " + arr[i];
						delWhere += "sc_idx = " + arr[i];
					} else {
						sql += " or a.sc_idx = " + arr[i];
						delWhere += " or sc_idx = " + arr[i];
					}
				}
				sql += ")";
				delWhere += ")";
				rs = stmt.executeQuery(sql);
				if(rs.next()) {		// 장바구니에 구매할 상품정보가 있다면
					do {
						Statement stmt2 = conn.createStatement();

						// t_sell_detail 테이블에 사용할 insert 문
						sql = "insert into t_sell_detail (si_id, pi_id, po_idx, sd_mname, sd_oname, sd_img, sd_cnt, sd_price, sd_dc) " +
						" values('" + siid + "', '" + rs.getString("pi_id") + "', '" + rs.getInt("po_idx") + "', '" + 
						rs.getString("pi_name") + "', '" + rs.getString("po_name") + "', '" + rs.getString("pi_img1") + "', '" + 
						rs.getInt("sc_cnt") + "', '" + (rs.getInt("price") / rs.getInt("sc_cnt") - si.getSi_upoint()) + "', '" + rs.getInt("pi_dc") + "') ";
						target++;		rcount += stmt2.executeUpdate(sql);
						System.out.println(sql);
						
						// t_product_option 테이블의 판매 및 재고 변경 update 문
						sql = "update t_product_option set po_stock = po_stock - " + rs.getInt("sc_cnt") + " where po_idx = " + rs.getInt("po_idx");
						target++;	rcount += stmt2.executeUpdate(sql);	
						System.out.println(sql);
					}while(rs.next());
					
					// t_sell_cart 테이블의 구매 후 삭제 delete 문
					sql = "delete from t_sell_cart " + delWhere;
					stmt.executeUpdate(sql);
				}else {	// 장바구니에 구매할 상품정보가 없으면
					return siid + ",1,4";
				}
				
			}else {	// 바로 구매일 경우
				
			}
			
			// t_member_info 사용 포인트 감소
			sql = "update t_member_info set mi_point = mi_point - " + si.getSi_upoint() + " where mi_id = '" + si.getMi_id() + "' ";
			target++;	rcount += stmt.executeUpdate(sql);
			if (si.getSi_upoint() > 0) {
			// t_member_point 테이블의 포인트 사용내역 추가 쿼리
				sql = "insert into t_member_point(mi_id, mp_su, mp_point, mp_desc, mp_detail) " + 
					  " values('" + si.getMi_id() + "', 'u', '" +si.getSi_upoint() + "' , '포인트 사용', '" + siid + "') ";
				target++;	rcount += stmt.executeUpdate(sql);	
			}
			/*
			if(!si.getSi_status().equals("a")) {
				// t_member_info 포인트 적립 추가
				int pnt = (si.getSi_pay() - si.getSi_upoint()) / 100;
				sql = "update t_member_info set mi_point = mi_point + " + pnt + " where mi_id = '" + si.getMi_id() + "' ";
				target++;	rcount += stmt.executeUpdate(sql);
				
				// t_member_point 테이블의 포인트 적립내역 추가 쿼리
				sql = "insert into t_member_point(mi_id, mp_su, mp_point, mp_desc, mp_detail) " + 
					  " values('" + si.getMi_id() + "', 's', '" + pnt + "' , '상품구매 적립', '" + siid + "') ";
				target++;	rcount += stmt.executeUpdate(sql);
			}
			*/
		}catch(Exception e) {
			System.out.println("OrderProcDao 클래스의 orderInsert() 메소드 오류");
			e.printStackTrace();
		}finally {
//			close(rs);	close(stmt);
			if (rs != null) close(rs);
			if (stmt != null) close(stmt);
		}
		
		return siid + "," + rcount + "," + target;
	}
	
	
	public SellInfo getSellInfo(String siid) {
		Statement stmt = null;
		ResultSet rs = null;
		SellInfo si = null;
		
		try { 
			String sql = "select si_id, si_pay, si_spoint, si_upoint, si_payment from t_sell_info where si_id = '" + siid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				si = new SellInfo();
				si.setSi_id(siid);
				si.setSi_pay(rs.getInt("si_pay"));
				si.setSi_upoint(rs.getInt("si_upoint"));
				si.setSi_payment(rs.getString("si_payment"));
				si.setSi_spoint(rs.getInt("si_spoint"));
			}
			
		} catch(Exception e) {
			System.out.println("OrderProcDao 클래스의 getSellInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return si;
	}
	
	
	
	public ArrayList<SellInfo> getBuyList(String miid, int cpage, int psize) {
		ArrayList<SellInfo> buyList = new ArrayList<SellInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		SellInfo buyInfo = null;
		
		try {
			String sql = "select a.si_id, b.sd_mname, a.si_pay, a.si_status, a.si_date " +
				" from t_sell_info a, t_sell_detail b where a.si_id = b.si_id and " + 
				" sd_idx = (select min(c.sd_idx) from t_sell_detail c where a.si_id = c.si_id) and a.mi_id = '" 
				+ miid + "' order by a.si_date desc limit " + ((cpage - 1) * psize) + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				buyInfo = new SellInfo();
				String siid = rs.getString("si_id");
				buyInfo.setSi_id(siid);
				int cnt = getBuyModelCount(siid);
				String mname = rs.getString("sd_mname");
				if (cnt > 0)		mname = mname + " 외 " + cnt + "개";
				buyInfo.setSd_mname(mname);
				buyInfo.setSi_pay(rs.getInt("si_pay"));
				buyInfo.setSi_status(rs.getString("si_status"));
				buyInfo.setSi_date(rs.getString("si_date"));
				buyList.add(buyInfo);
			}

		} catch (Exception e) {
			System.out.println("OrderProcDao 클래스의 getBuyList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return buyList;
	}

	public ArrayList<BuyInfo> getSellList(String miid, int cpage, int psize) {
		ArrayList<BuyInfo> sellList = new ArrayList<BuyInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		BuyInfo sellInfo = null;
		
		try {
			String sql = "select a.bi_id, b.pi_name, a.bi_pay, a.bi_status, a.bi_date " +
				" from t_buy_info a, t_product_info b where a.pi_id = b.pi_id and mi_id = '" + miid + "' " +	
				" order by a.bi_date desc " +
				" limit " + ((cpage - 1) * psize) + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				sellInfo = new BuyInfo();
				sellInfo.setBi_id(rs.getString("bi_id"));
				sellInfo.setPi_name(rs.getString("pi_name"));
				sellInfo.setBi_pay(rs.getInt("bi_pay"));
				sellInfo.setBi_status(rs.getString("bi_status"));
				sellInfo.setBi_date(rs.getString("bi_date"));
				sellList.add(sellInfo);
			}

		} catch (Exception e) {
			System.out.println("OrderProcDao 클래스의 getSellList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return sellList;
	}	
	
	public int getBuyListCount(String miid) {
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_sell_info where mi_id = '" + miid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			result = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("OrderProcDao 클래스의 getBuyListCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return result;
	}
	
	public int getSellListCount(String miid) {
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_buy_info where mi_id = '" + miid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			result = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("OrderProcDao 클래스의 getSellListCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return result;
	}
	
/*
	public ArrayList<OrderInfo> getOrderList(String miid, int cpage, int psize) {
		ArrayList<OrderInfo> orderInfoList = new ArrayList<OrderInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		Statement stmt2 = null;
		ResultSet rs2 = null;
		Statement stmt3 = null;
		ResultSet rs3 = null;
		OrderInfo orderInfo = null;
		
		try {
			String sql = "select * from t_sell_info where mi_id = '" + miid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String siid = rs.getString("si_id");
				sql = "select min(sd_idx) min from t_sell_detail " +
					" where si_id = '" + siid +"'";
				stmt2 = conn.createStatement();
				rs2 = stmt2.executeQuery(sql);
				rs2.next();
				sql = "select '구매', a.si_id oi_id, b.sd_mname oi_name, " +
					" a.si_pay oi_pay, a.si_status oi_status, a.si_date oi_date " +
					" from t_sell_info a, t_sell_detail b " +
					" where a.si_id = b.si_id and sd_idx = " + rs2.getString("min") +
					" union " +
					" select '판매', a.bi_id, b.pi_name, a.bi_pay, a.bi_status, " +
					" a.bi_date from t_buy_info a, t_product_info b " +
					" where a.pi_id = b.pi_id order by oi_date desc";
				stmt3 = conn.createStatement();
				rs3 = stmt3.executeQuery(sql);
				while (rs3.next()) {
					orderInfo = new OrderInfo();
					orderInfo.setMi_id(miid);
					orderInfo.setOi_minIdx(rs2.getInt("min"));
					orderInfo.setOi_kind(rs3.getString("구매"));
					orderInfo.setOi_id(rs3.getString("oi_id"));
					orderInfo.setOi_name(rs3.getString("oi_name"));
					int cnt = getBuyModelCount(siid);
					if (cnt > 0)	orderInfo.setOi_name(orderInfo.getOi_name() + "외 " + cnt + "개");
					System.out.println(orderInfo.getOi_name());
					orderInfo.setOi_pay(rs3.getInt("oi_pay"));
					orderInfo.setOi_status(rs3.getString("oi_status"));
					orderInfo.setOi_date(rs3.getString("oi_date"));
					orderInfoList.add(orderInfo);
				}
			}
		} catch (Exception e) {
			System.out.println("OrderProcDao 클래스의 getOrderList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
			close(stmt2);	close(rs2);
			close(stmt3);	close(rs3);
		}
		
		return orderInfoList;
	}

*/
	
	public ArrayList<OrderInfo> getOrderList(String miid, int cpage, int psize) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<OrderInfo> orderList = new ArrayList<OrderInfo>();
		OrderInfo orderInfo = null;
		
		try {
			String sql = "select '구매', a.si_id oi_id, b.sd_mname oi_name, a.si_pay oi_pay, a.si_status oi_status, a.si_date oi_date " 
				+ " from t_sell_info a, t_sell_detail b where a.si_id = b.si_id and a.mi_id = '" + miid + "' and sd_idx = " 
				+ " (select min(c.sd_idx) from t_sell_detail c where c.si_id = a.si_id) union select '판매', a.bi_id, b.pi_name, a.bi_pay, " 
				+ "a.bi_status, a.bi_date from t_buy_info a, t_product_info b where a.pi_id = b.pi_id and mi_id = '" + miid + "' order by oi_date desc";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				orderInfo = new OrderInfo();
				orderInfo.setOi_kind(rs.getString(1));
				String oiid = rs.getString("oi_id");
				orderInfo.setOi_id(oiid);
				int cnt = getBuyModelCount(oiid);
				String oiname = rs.getString("oi_name");
				if (cnt > 0)		oiname = oiname + " 외 " + cnt + "개";
				orderInfo.setOi_name(oiname);
				orderInfo.setOi_pay(rs.getInt("oi_pay"));
				orderInfo.setOi_status(rs.getString("oi_status"));
				orderInfo.setOi_date(rs.getString("oi_date"));
				orderList.add(orderInfo);
			}
			
		} catch (Exception e) {
			System.out.println("OrderProcDao 클래스의 getSdidx() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
	
		return orderList;
	}

	public int getBuyModelCount(String oiid) {
		Statement stmt = null;
		ResultSet rs = null;
		int count = 0;
		
		try {
			String sql = "select count(*) from t_sell_detail where si_id = '" + oiid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			count = rs.getInt(1) - 1;
			
		} catch (Exception e) {
			System.out.println("OrderProcDao 클래스의 getBuyModelCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);		close(stmt);
		}
		
		return count;
	}

	public int getOrderListCount(String miid) {
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_buy_info where mi_id = '" + miid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			result = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("OrderProcDao 클래스의 getSellListCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return result;
	}
	
	
	public int cancelStatus(SellInfo si) {
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			stmt = conn.createStatement();
			String sql = "update t_sell_info set si_status = 'f' where si_id = '" + si.getSi_id() + "'";
			System.out.println(sql);
			System.out.println(si.getSi_status());
			result = stmt.executeUpdate(sql);
			if(si.getSi_status().equals("a") || si.getSi_status().equals("b")) {
				sql = "select a.mi_id, a.si_spoint, a.si_upoint, b.sd_price, b.sd_cnt, c.po_idx, c.po_name " + 
					  " from t_sell_info a, t_sell_detail b, t_product_option c " +
					  " where a.si_id = b.si_id and b.pi_id = c.pi_id and b.sd_oname = c.po_name and b.si_id = '" + si.getSi_id() + "'";
				System.out.println(sql);
				rs = stmt.executeQuery(sql);
				 
				if(rs.next()) {
					
					Statement stmt2 = conn.createStatement();
					if(rs.getInt("si_upoint") > 0) {
						 // 환불 포인트 사용한 포인트  내역 테이블에 추가
						sql = "insert into t_member_point(mi_id, mp_su, mp_point, mp_desc, mp_detail) " + 
					           " values('" + rs.getString("mi_id") + "', 's', '" + rs.getInt("si_upoint") + "' , '주문 취소 환불', '" + si.getSi_id() + "') ";
						System.out.println(sql);
						result += stmt2.executeUpdate(sql);
					}
					
					do {	// 구입한 상품 옵션의 갯수 채우기
						Statement stmt3 = conn.createStatement();
						sql = "update t_product_option set po_stock = po_stock + '" + rs.getInt("sd_cnt") + "' where po_idx = '" + rs.getInt("po_idx") + "'";
						System.out.println(sql);
				        result += stmt3.executeUpdate(sql);
				         
				        if(rs.getInt("si_upoint") > 0) {
				       	// 사용한 포인트 환불
					        sql = "update t_member_info set mi_point = mi_point + '" + rs.getInt("si_upoint") + "'";
					        System.out.println(sql);
					        result += stmt3.executeUpdate(sql);
					    }
					} while(rs.next());

					System.out.println(result);
				 }
			}
		}catch(Exception e){
			System.out.println("OrderProcDao 클래스의 cancelStatus() 메소드 오류");
			e.printStackTrace();
		}finally {
			close(rs);		close(stmt);
		}
		return result;
		
	}
	
	
	public MemberInfo getMemberPoint(String miid) {
		Statement stmt = null;
		ResultSet rs = null;
		MemberInfo pointInfo = null;
		
		try {
			String sql = "select mi_point from t_member_info where mi_id = '" + miid + "'";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				pointInfo = new MemberInfo();
				pointInfo.setMi_point(rs.getInt("mi_point"));			
			}
			
		}catch(Exception e) {
			System.out.println("OrderProcDao 클래스의 getMemberPoint() 메소드 오류");
			e.printStackTrace();
		}finally {
			close(rs);		close(stmt);
		}
		return pointInfo;
	}

	public ArrayList<BuyChart> getBuyChartList(String model, int cpage, int psize) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<BuyChart> buyChartList = new ArrayList<BuyChart>();
		BuyChart buyChart = null;
		
		try {
			String sql = "select b.sd_mname, b.sd_oname, if(b.sd_cnt > 1, sd_price div sd_cnt, sd_price) price, b.sd_dc, date(a.si_date) wdate "
				+ " from t_sell_info a, t_sell_detail b where a.si_id = b.si_id and lcase(b.sd_mname) like '%" + model + "%' order by date(a.si_date) desc limit " + ((cpage - 1) * psize) + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				buyChart = new BuyChart();
				buyChart.setMname(rs.getString("sd_mname"));
				buyChart.setOname(rs.getString("sd_oname"));
				buyChart.setPrice(rs.getInt("price"));
				buyChart.setDc(rs.getInt("sd_dc"));
				buyChart.setDate(rs.getString("wdate"));
				buyChartList.add(buyChart);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("OrderProcDao 클래스의 getBuyChartList() 메소드 오류");
		} finally {
			close(rs);		close(stmt);
		}
		
		return buyChartList;
	}

	public int getBuyChartCount(String model) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(b.sd_idx) from t_sell_info a, t_sell_detail b where a.si_id = b.si_id and lcase(b.sd_mname) like '%" + model + "%'";
//			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("OrderProcDao 클래스의 getBuyChartCount() 메소드 오류");
		} finally {
			close(rs);		close(stmt);
		}
		
		return rcnt;
	}
	
}
