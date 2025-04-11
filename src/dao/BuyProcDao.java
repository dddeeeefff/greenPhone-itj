package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.time.*;
import java.sql.*;
import vo.*;

public class BuyProcDao {
	private static BuyProcDao buyProcDao;
	private Connection conn;
	private BuyProcDao() {}
	
	public static BuyProcDao getInstance() {
		
		if (buyProcDao == null)	buyProcDao = new BuyProcDao();
		
		return buyProcDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}


	public ArrayList<SellDetail> getSellDetailList(String miid, String siid) {
		ArrayList<SellDetail> sellDetailList = new ArrayList<SellDetail>();
		Statement stmt = null;
		ResultSet rs = null;
		SellDetail sellDetail = null;
		
		try {
			String sql = "select * from t_sell_detail a, t_sell_info b where a.si_id = b.si_id and b.mi_id = '" + miid + "' and a.si_id = '" + siid + "' order by sd_idx asc";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				sellDetail = new SellDetail();
				//sellDetail.setSd_idx(rs.getInt("sd_idx"));
				sellDetail.setSi_id(rs.getString("si_id"));
				sellDetail.setSd_mname(rs.getString("sd_mname"));
				sellDetail.setSd_oname(rs.getString("sd_oname"));
				sellDetail.setSd_img(rs.getString("sd_img"));
				sellDetail.setSd_cnt(rs.getInt("sd_cnt"));
				sellDetail.setSd_price(rs.getInt("sd_price"));
				sellDetail.setSd_dc(rs.getInt("sd_dc"));
				sellDetail.setSd_cdate(rs.getString("sd_cdate"));
				sellDetailList.add(sellDetail);
			}

		} catch (Exception e) {
			System.out.println("BuyProcDao 클래스의 getSellDetailList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return sellDetailList;
	}

	public SellInfo getSellInfo(String miid, String siid) {
		SellInfo sellInfo = new SellInfo();
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from t_sell_info where si_id = '" + siid + "' and mi_id = '" + miid + "'";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			sellInfo.setSi_id(rs.getString("si_id"));
			sellInfo.setSi_payment(rs.getString("si_payment"));
			sellInfo.setSi_pay(rs.getInt("si_pay"));
			sellInfo.setSi_upoint(rs.getInt("si_upoint"));
			sellInfo.setSi_invoice(rs.getString("si_invoice"));
			sellInfo.setSi_status(rs.getString("si_status"));
			sellInfo.setSi_memo(rs.getString("si_memo"));
			
			
		} catch (Exception e) {
			System.out.println("BuyProcDao 클래스의 getSellInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return sellInfo;
	}

	
}
