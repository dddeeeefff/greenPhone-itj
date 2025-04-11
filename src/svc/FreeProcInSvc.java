package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class FreeProcInSvc {
	public int getNextIdx() {
		int nextIdx = 0;
		Connection conn = getConnection();
		FreeProcDao freeProcDao = FreeProcDao.getInstance();
		freeProcDao.setConnection(conn);
		
		nextIdx = freeProcDao.getNextIdx();
		close(conn);
		
		return nextIdx;
	}

	public int freeProcIn(BbsFree bf) {
		int result = 0;
		Connection conn = getConnection();
		FreeProcDao freeProcDao = FreeProcDao.getInstance();
		freeProcDao.setConnection(conn);
		
		result = freeProcDao.freeProcIn(bf);
		if (result == 1)		commit(conn);
		else					rollback(conn);
		close(conn);
		
		return result;
	}

}
