package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class FreeViewSvc {
	public int readUpdate(int bfidx) {
		int result = 0;
		Connection conn = getConnection();
		FreeProcDao freeProcDao = FreeProcDao.getInstance();
		freeProcDao.setConnection(conn);
		
		result = freeProcDao.readUpdate(bfidx);
		if (result == 1)		commit(conn);
		else					rollback(conn);
		close(conn);
		
		return result;
	}
	
	public BbsFree getFreeInfo(int bfidx) {
		BbsFree bf = null;
		Connection conn = getConnection();
		FreeProcDao freeProcDao = FreeProcDao.getInstance();
		freeProcDao.setConnection(conn);
		
		bf = freeProcDao.getFreeInfo(bfidx);
		close(conn);
		
		return bf;
	}

}
