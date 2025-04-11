package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class BuyListSvc {
	
	public ArrayList<SellInfo> getBuyList(String miid, int cpage, int psize) {
		ArrayList<SellInfo> buyList = new ArrayList<SellInfo>();
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);;
		
		buyList = orderProcDao.getBuyList(miid, cpage, psize);
		close(conn);
		
		return buyList;
	}

	public int getBuyListCount(String miid) {
		int rcnt = 0;
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);;
		
		rcnt = orderProcDao.getBuyListCount(miid);
		close(conn);
		
		return rcnt;
	}
}
