package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class EventListSvc {
	public int getEventListCount(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		EventProcDao eventProcDao = EventProcDao.getInstance();
		eventProcDao.setConnection(conn);
		
		rcnt = eventProcDao.getEventListCount(where);
		close(conn);
		
		return rcnt;
	}
	
	public ArrayList<BbsEvent> getEventList(String where, int cpage, int psize) {
		ArrayList<BbsEvent> eventList = new ArrayList<BbsEvent>();
		Connection conn = getConnection();
		EventProcDao eventProcDao = EventProcDao.getInstance();
		eventProcDao.setConnection(conn);
		
		eventList = eventProcDao.getEventList(where, cpage, psize);
		close(conn);
		
		return eventList;
	}
}
