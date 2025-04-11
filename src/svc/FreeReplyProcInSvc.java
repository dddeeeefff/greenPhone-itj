package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class FreeReplyProcInSvc {
	public int replyInsert(BbsFreeReply bfr) {
		int result = 0;
		Connection conn = getConnection();
		FreeReplyProcDao freeReplyProcDao = FreeReplyProcDao.getInstance();
		freeReplyProcDao.setConnection(conn);
		
		result = freeReplyProcDao.replyInsert(bfr);
		if(result == 1)			commit(conn);
		else					rollback(conn);
		close(conn);
		
		return result;
	}
}
