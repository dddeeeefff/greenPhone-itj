package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class BuyViewProcSvc {
	public int cancelStatus(SellInfo si) {
		int result = 0;
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		
		result = orderProcDao.cancelStatus(si);
		if(result > 0)		commit(conn);
		else				rollback(conn);
		close(conn);
		
		return result;
		
	}
}
