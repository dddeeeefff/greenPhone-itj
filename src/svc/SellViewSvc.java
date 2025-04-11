package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class SellViewSvc {
	public BuyInfo getBuyInfo(String miid, String biid) {
		BuyInfo buyInfo = null;
		Connection conn = getConnection();
		SellProcDao sellProcDao = SellProcDao.getInstance();
		sellProcDao.setConnection(conn);
		buyInfo = sellProcDao.getBuyInfo(miid, biid);
		close(conn);
		
		return buyInfo;
	}
}
