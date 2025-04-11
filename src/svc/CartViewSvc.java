package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class CartViewSvc {
	public ArrayList<SellCart> getCartList(String miid) {
		ArrayList<SellCart> cartList = new ArrayList<SellCart>();
		Connection conn = getConnection();
		CartDao cartDao = CartDao.getInstance();
		cartDao.setConnection(conn);
		
		cartList = cartDao.getCartList(miid);
		close(conn);
		
		return cartList;
	}
}
