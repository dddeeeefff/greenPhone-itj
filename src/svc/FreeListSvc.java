package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class FreeListSvc {
	public int getFreeListCount(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		FreeProcDao freeProcDao = FreeProcDao.getInstance();
		freeProcDao.setConnection(conn);
		
		rcnt = freeProcDao.getFreeListCount(where);
		close(conn);
		
		return rcnt;
	}
	public ArrayList<BbsFree> getFreeList(String where, int cpage, int psize) {
		ArrayList<BbsFree> freeList = new ArrayList<BbsFree>();
		Connection conn = getConnection();
		FreeProcDao freeProcDao = FreeProcDao.getInstance();
		freeProcDao.setConnection(conn);
		
		freeList = freeProcDao.getFreeList(where, cpage, psize);
		close(conn);
		
		return freeList;
	}
}
