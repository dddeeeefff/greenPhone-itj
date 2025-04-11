package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.time.*;
import java.sql.*;
import vo.*;

public class ModelPriceDao {
	private static ModelPriceDao modelPriceDao;
	private Connection conn;
	private ModelPriceDao() {}
	
	public static ModelPriceDao getInstance() {
		
		if (modelPriceDao == null)	modelPriceDao = new ModelPriceDao();
		
		return modelPriceDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public int getModelPrice(String model) {
		Statement stmt = null;
		ResultSet rs = null;
		int price = 0;
		
		try {
			String sql = "select pi_max from t_product_info where pi_id = '" + model +"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			System.out.println(sql);
			rs.next();
			price = rs.getInt("pi_max");
		} catch (Exception e) {
			System.out.println("ModelPriceDao 클래스의 getModelPrice() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return price;
	}

	

}
