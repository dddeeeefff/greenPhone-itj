package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class MemberQuestionViewSvc {

	public MemberQuestion getMemberQuestion(String miid, int idx) {
		MemberQuestion memberQuestion = null;
		Connection conn = getConnection();
		MemberQuestionProcDao memberQuestionProcDao = MemberQuestionProcDao.getInstance();
		memberQuestionProcDao.setConnection(conn);

		memberQuestion = memberQuestionProcDao.getMemberQuestion(miid,idx);
		close(conn);

		return memberQuestion;
	}

}
