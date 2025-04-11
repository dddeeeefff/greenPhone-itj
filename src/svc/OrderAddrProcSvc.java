package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;


public class OrderAddrProcSvc {
	public static int orderAddrProc(MemberInfo memberInfo, String def) {
		int result = 0;
		Connection conn = getConnection();
		OrderAddrProcDao orderAddrProcDao = OrderAddrProcDao.getInstance();
		orderAddrProcDao.setConnection(conn);
		
		result = orderAddrProcDao.orderAddrProcUp(memberInfo, def);
		if (result == 1) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}




	
}
