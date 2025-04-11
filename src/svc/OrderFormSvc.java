package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class OrderFormSvc {
	public ArrayList<SellCart> getCartList(String kind, String sql) {
		ArrayList<SellCart> cartList = new ArrayList<SellCart>();
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		
		cartList = orderProcDao.getCartList(kind, sql);
		close(conn);
		
		return cartList;
	}
	
	public MemberInfo getMemberPoint(String miid) {
		MemberInfo pointInfo = new MemberInfo();
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		
		pointInfo = orderProcDao.getMemberPoint(miid);
		close(conn);
		
		return pointInfo;
	}
}
