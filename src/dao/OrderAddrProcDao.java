package dao;

import static db.JdbcUtil.*;	// JdbcUtil 클래스의 모든 멤버들을 자유롭게 사용
import java.util.*;
import java.sql.*;
import vo.*;

public class OrderAddrProcDao {

	private static OrderAddrProcDao orderAddrProcDao;
	private Connection conn;
	private OrderAddrProcDao() {}
	
	public static OrderAddrProcDao getInstance() {
		if (orderAddrProcDao == null) { 
			orderAddrProcDao = new OrderAddrProcDao();
		}
		return orderAddrProcDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public int orderAddrProcUp(MemberInfo memberInfo, String def) {
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "update t_sell_info set " + 
			" si_name = '"	+ memberInfo.getMi_name()	+ "', " +
			" si_phone = '"	+ memberInfo.getMi_phone()	+ "', " +
			" si_zip = '"	+ memberInfo.getMi_zip()	+ "', " +
			" si_addr1 = '"	+ memberInfo.getMi_addr1()	+ "', " +
			" si_addr2 = '"	+ memberInfo.getMi_addr2()	+ "', " +
			" where mi_id = '" + memberInfo.getMi_id()	+ "' ";
			System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			if (def.equals("true")) {
				sql = "update t_member_info set " + 
				" mi_phone = '"	+ memberInfo.getMi_phone()	+ "', " +
				" mi_zip = '"	+ memberInfo.getMi_zip()	+ "', " +
				" mi_addr1 = '"	+ memberInfo.getMi_addr1()	+ "', " +
				" mi_addr2 = '"	+ memberInfo.getMi_addr2()	+ "', " +
				" where mi_id = '" + memberInfo.getMi_id()	+ "' ";
				Statement stmt2 = conn.createStatement();
				stmt2.executeUpdate(sql);
			}
		} catch (Exception e) {
			System.out.println("OrderAddrProcDao 클래스의 orderAddrProcUp() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}	
}
