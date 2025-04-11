package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class PointListSvc {

	public ArrayList<MemberPoint> getMemberPointList(String miid) {
		ArrayList<MemberPoint> memberPointList = new ArrayList<MemberPoint>();
		Connection conn = getConnection();
		MemberProcDao memberProcDao = MemberProcDao.getInstance();
		memberProcDao.setConnection(conn);
		
		memberPointList = memberProcDao.getMemberPointList(miid);
		close(conn);
		
		return memberPointList;
	}

}
