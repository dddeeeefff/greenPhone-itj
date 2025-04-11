package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class OrderEndSvc {
	public SellInfo getSellInfo(String siid) {
		SellInfo si = null;
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		
		si = orderProcDao.getSellInfo(siid);
		close(conn);
		
		return si;
	}
}
