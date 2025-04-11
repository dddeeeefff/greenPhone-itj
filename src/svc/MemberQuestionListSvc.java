package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class MemberQuestionListSvc {

	public ArrayList<MemberQuestion> getMemberQuestionList(String miid) {
		ArrayList<MemberQuestion> buyList = new ArrayList<MemberQuestion>();
		Connection conn = getConnection();
		MemberQuestionProcDao memberQuestionProcDao = MemberQuestionProcDao.getInstance();
		memberQuestionProcDao.setConnection(conn);;
		
		buyList = memberQuestionProcDao.getMemberQuestionList(miid);
		close(conn);
		
		return buyList;
	}

}
