package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class NoticeViewSvc {
	public BbsNotice getNoticeDetail(int bnidx) {
		BbsNotice noticeDetail = null;
		Connection conn = getConnection();
		NoticeProcDao noticeProcDao = NoticeProcDao.getInstance();
		noticeProcDao.setConnection(conn);
		
		noticeDetail = noticeProcDao.getNoticeDetail(bnidx);
		close(conn);
		
		return noticeDetail;
	}
	
	public int readUpdate(int bnidx) {
		int result = 0;
		Connection conn = getConnection();
		NoticeProcDao noticeProcDao = NoticeProcDao.getInstance();
		noticeProcDao.setConnection(conn);
		
		result = noticeProcDao.readUpdate(bnidx);
		if (result == 1)	commit(conn);
		else				rollback(conn);
		close(conn);
		
		return result;
	}
}
