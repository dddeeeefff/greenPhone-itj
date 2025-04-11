package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class SellFormSvc {
	public ArrayList<ProductBrand> getBrandList() {
		ArrayList<ProductBrand> brandList = new ArrayList<ProductBrand>();
		Connection conn = getConnection();
		SellProcDao sellProcDao = SellProcDao.getInstance();
		sellProcDao.setConnection(conn);
		brandList = sellProcDao.getBrandList();
		close(conn);
		
		return brandList;
	}

	public ArrayList<ProductSeries> getSeriesList() {
		ArrayList<ProductSeries> seriesList = new ArrayList<ProductSeries>();
		Connection conn = getConnection();
		SellProcDao sellProcDao = SellProcDao.getInstance();
		sellProcDao.setConnection(conn);
		seriesList = sellProcDao.getSeriesList();
		close(conn);
		
		return seriesList;
	}

	public ArrayList<ProductInfo> getProductList() {
		ArrayList<ProductInfo> productList = new ArrayList<ProductInfo>();
		Connection conn = getConnection();
		SellProcDao sellProcDao = SellProcDao.getInstance();
		sellProcDao.setConnection(conn);
		productList = sellProcDao.getProductList();
		close(conn);
		
		return productList;
	}
}
