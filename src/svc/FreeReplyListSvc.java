package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class FreeReplyListSvc {
	public ArrayList<BbsFreeReply> getReplyList(int bfidx) {
		ArrayList<BbsFreeReply> replyList = new ArrayList<BbsFreeReply>();
		Connection conn = getConnection();
		FreeReplyProcDao freeReplyProcDao = FreeReplyProcDao.getInstance();
		freeReplyProcDao.setConnection(conn);
		
		replyList = freeReplyProcDao.getReplyList(bfidx);
		close(conn);
		
		return replyList;
	}
}
