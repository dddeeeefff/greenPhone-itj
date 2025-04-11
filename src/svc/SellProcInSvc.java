package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class SellProcInSvc {
	public String sellProcIn(BuyInfo bi) {
		int result = 0;
		String resultStr = "";
		Connection conn = getConnection();
		SellProcDao sellProcDao = SellProcDao.getInstance();
		sellProcDao.setConnection(conn);
		
		resultStr = sellProcDao.sellProcIn(bi);
		String[] arr = resultStr.split(",");
		result = Integer.parseInt(arr[0]);
		if (result == 1)		commit(conn);
		else					rollback(conn);
		close(conn);
		
		return resultStr;
	}
	
	public String getNextId() {
		String nextId = "";
		Connection conn = getConnection();
		SellProcDao sellProcDao = SellProcDao.getInstance();
		sellProcDao.setConnection(conn);
		
		nextId = sellProcDao.getNextId();
		close(conn);
		
		return nextId;
	}
	
}
