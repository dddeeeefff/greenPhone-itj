package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class ModelPriceSvc {

	public int getModelPrice(String model) {
		int price = 0;
		Connection conn = getConnection();
		ModelPriceDao modelPriceDao = ModelPriceDao.getInstance();
		modelPriceDao.setConnection(conn);;
		
		price = modelPriceDao.getModelPrice(model);
		close(conn);
		
		return price;
	}

}
