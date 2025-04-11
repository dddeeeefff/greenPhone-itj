package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class OrderListSvc {
	
	public ArrayList<OrderInfo> getOrderList(String miid, int cpage, int psize) {
		ArrayList<OrderInfo> orderList = new ArrayList<OrderInfo>();
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);;
		
		orderList = orderProcDao.getOrderList(miid, cpage, psize);
		close(conn);
		
		return orderList;
	}

	public int getOrderListCount(String miid) {
		int rcnt = 0;
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);;
		
		rcnt = orderProcDao.getOrderListCount(miid);
		close(conn);
		
		return rcnt;
	}
}
