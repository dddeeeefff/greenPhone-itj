package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class SellListSvc {

	public ArrayList<BuyInfo> getSellList(String miid, int cpage, int psize) {
		ArrayList<BuyInfo> sellList = new ArrayList<BuyInfo>();
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);;
		
		sellList = orderProcDao.getSellList(miid, cpage, psize);
		close(conn);
		
		return sellList;
	}

	public int getSellListCount(String miid) {
		int rcnt = 0;
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);;
		
		rcnt = orderProcDao.getSellListCount(miid);
		close(conn);
		
		return rcnt;
	}
	
}
