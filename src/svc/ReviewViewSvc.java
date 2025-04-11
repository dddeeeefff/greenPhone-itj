package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class ReviewViewSvc {

	public BbsReview getReview(String bridx) {
		BbsReview review = new BbsReview();
		Connection conn = getConnection();
		ReviewProcDao reviewProcDao = ReviewProcDao.getInstance();
		reviewProcDao.setConnection(conn);
		
		review = reviewProcDao.getReview(bridx);
		close(conn);
		
		return review;

	}

	public int getReadUpdate(String bridx) {
		int result = 0;
		Connection conn = getConnection();
		ReviewProcDao reviewProcDao = ReviewProcDao.getInstance();
		reviewProcDao.setConnection(conn);
		
		result = reviewProcDao.readUpdate(bridx);
		if(result == 1)		commit(conn);
		else				rollback(conn);
		
		close(conn);
		
		return result;
	}

	public BbsReview getPrevReview(String bridx) {
		BbsReview review = new BbsReview();
		Connection conn = getConnection();
		ReviewProcDao reviewProcDao = ReviewProcDao.getInstance();
		reviewProcDao.setConnection(conn);
		
		review = reviewProcDao.getPrevReview(bridx);
		
		close(conn);
		
		return review;
	}

	public BbsReview getNextReview(String bridx) {
		BbsReview review = new BbsReview();
		Connection conn = getConnection();
		ReviewProcDao reviewProcDao = ReviewProcDao.getInstance();
		reviewProcDao.setConnection(conn);
		
		review = reviewProcDao.getNextReview(bridx);
		
		close(conn);
		
		return review;
	}
	
}

