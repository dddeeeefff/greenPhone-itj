package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class CartProcInSvc {
	public int cartInsert (SellCart sc) {
		int result = 0;
		Connection conn = getConnection();
		CartDao cartDao = CartDao.getInstance();
		cartDao.setConnection(conn);
		
		result = cartDao.cartInsert(sc);
		if (result == 1)	commit(conn);
		else				rollback(conn);	
		close(conn);
		
		return result;
	}
}
