package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ProductViewCalSvc {
	public String getProductViewCal(ProductOption po) {
		String option = "";
		Connection conn = getConnection();
		ProductProcDao productProcDao = ProductProcDao.getInstance();
		productProcDao.setConnection(conn);
		
		option = productProcDao.getProductViewCal(po);
		
		return option;
	}
}
