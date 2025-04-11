package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class MemberQuestionProcSvc {

	public int memberQuestionProc(String uid, String title, String content) {
		int result = 0;
		Connection conn = getConnection();
		MemberQuestionProcDao memberQuestionProcDao = MemberQuestionProcDao.getInstance();
		memberQuestionProcDao.setConnection(conn);
		
		result = memberQuestionProcDao.memberQuestionProcIn(uid, title, content);
		if (result == 1) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}
}