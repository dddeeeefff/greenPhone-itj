package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class EventViewSvc {
	public int readUpdate(int beidx) {
		int result = 0;
		Connection conn = getConnection();
		EventProcDao eventProcDao = EventProcDao.getInstance();
		eventProcDao.setConnection(conn);
		
		result = eventProcDao.readUpdate(beidx);
		if (result == 1)	commit(conn);
		else				rollback(conn);
		close(conn);
		
		return result;
	}
	
	public BbsEvent getEventInfo(int beidx) {
		BbsEvent be = new BbsEvent();
		Connection conn = getConnection();
		EventProcDao eventProcDao = EventProcDao.getInstance();
		eventProcDao.setConnection(conn);
		
		be = eventProcDao.getEventInfo(beidx);
		close(conn);
		
		return be;
	}
}
