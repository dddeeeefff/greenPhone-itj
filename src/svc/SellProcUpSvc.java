package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class SellProcUpSvc {
	public int sellProcUp(BuyInfo bi, String status) {
		int result = 0;
		Connection conn = getConnection();
		SellProcDao sellProcDao = SellProcDao.getInstance();
		sellProcDao.setConnection(conn);
		
		result = sellProcDao.sellProcUp(bi, status);
		if (status.equals("b") || status.equals("e") || status.equals("i") || status.equals("j") || status.equals("f")) {
			if (result == 1)		commit(conn);
			else					rollback(conn);
		} else if (status.equals("k")) {
			if (result == 4)		commit(conn);
			else					rollback(conn);
		}
		close(conn);
		
		return result;
	}

}
