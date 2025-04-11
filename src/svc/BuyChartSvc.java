package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class BuyChartSvc {
	public ArrayList<BuyChart> getBuyChartList(String model, int cpage, int psize) {
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		
		ArrayList<BuyChart> buyChartList = orderProcDao.getBuyChartList(model, cpage, psize);
		close(conn);
		
		return buyChartList;
		
	}

	public int getBuyChartCount(String model) {
		int rcnt = 0;
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		
		rcnt = orderProcDao.getBuyChartCount(model);
		close(conn);
		
		return rcnt;
	}

}
