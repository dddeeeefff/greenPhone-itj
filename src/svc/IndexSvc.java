package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class IndexSvc {
	public ArrayList<ProductInfo> getRecentProductList() {
		ArrayList<ProductInfo> recentProductList = new ArrayList<ProductInfo>();
		Connection conn = getConnection();
		IndexDao indexDao = IndexDao.getInstance();
		indexDao.setConnection(conn);
		recentProductList = indexDao.getRecentProductList();
		close(conn);
		
		return recentProductList;
	}

	public ArrayList<ProductInfo> getHotProductList() {
		ArrayList<ProductInfo> hotProductList = new ArrayList<ProductInfo>();
		Connection conn = getConnection();
		IndexDao indexDao = IndexDao.getInstance();
		indexDao.setConnection(conn);
		hotProductList = indexDao.getHotProductList();
		close(conn);
		
		return hotProductList;
	}

	public ArrayList<ProductInfo> getDcProductList() {
		ArrayList<ProductInfo> dcProductList = new ArrayList<ProductInfo>();
		Connection conn = getConnection();
		IndexDao indexDao = IndexDao.getInstance();
		indexDao.setConnection(conn);
		dcProductList = indexDao.getDcProductList();
		close(conn);
		
		return dcProductList;
	}
	
	public ArrayList<BbsReview> getRecentReviewList() {
		ArrayList<BbsReview> recentReviewList = new ArrayList<BbsReview>();
		Connection conn = getConnection();
		IndexDao indexDao = IndexDao.getInstance();
		indexDao.setConnection(conn);
		recentReviewList = indexDao.getRecentReviewList();
		close(conn);
		
		return recentReviewList;
	}
	
}
