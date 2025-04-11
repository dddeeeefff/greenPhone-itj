package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class BuyViewSvc {

	public SellInfo getSellInfo(String miid, String siid) {
		SellInfo sellInfo = null;
		Connection conn = getConnection();
		BuyProcDao buyProcDao = BuyProcDao.getInstance();
		buyProcDao.setConnection(conn);
		sellInfo = buyProcDao.getSellInfo(miid, siid);
		close(conn);
		
		return sellInfo;
	}

	public ArrayList<SellDetail> getSellDetailList(String miid, String siid) {
		ArrayList<SellDetail> sellDetail = null;
		Connection conn = getConnection();
		BuyProcDao buyProcDao = BuyProcDao.getInstance();
		buyProcDao.setConnection(conn);
		sellDetail = buyProcDao.getSellDetailList(miid, siid);
		close(conn);
		
		return sellDetail;
	}

}
