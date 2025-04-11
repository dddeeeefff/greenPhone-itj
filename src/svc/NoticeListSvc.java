package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class NoticeListSvc {
	public ArrayList<BbsNotice> getNoticeList(int cpage, int psize, String where){
		ArrayList<BbsNotice> noticeList = new ArrayList<BbsNotice>();
		Connection conn = getConnection();
		NoticeProcDao noticeProcDao = NoticeProcDao.getInstance();
		noticeProcDao.setConnection(conn);
		
		noticeList = noticeProcDao.getNoticeList(cpage, psize, where);
		close(conn);
		
		return noticeList;
	}
	
	public int getNoticeListCount(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		NoticeProcDao noticeProcDao = NoticeProcDao.getInstance();
		noticeProcDao.setConnection(conn);
		
		rcnt = noticeProcDao.getNoticeListCount(where);
		close(conn);
		
		return rcnt;
	}
}
