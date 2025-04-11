package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class ReviewListSvc {
	
	public ArrayList<BbsReview> getReviewList(int cpage, int psize) {
		ArrayList<BbsReview> reviewList = new ArrayList<BbsReview>();
		Connection conn = getConnection();
		ReviewProcDao reviewProcDao = ReviewProcDao.getInstance();
		reviewProcDao.setConnection(conn);
		
		reviewList = reviewProcDao.getReviewList(cpage, psize);
		close(conn);
		
		return reviewList;
	}

	public int getReviewListCount() {
		int rcnt = 0;
		Connection conn = getConnection();
		ReviewProcDao reviewProcDao = ReviewProcDao.getInstance();
		reviewProcDao.setConnection(conn);
		
		rcnt = reviewProcDao.getReviewListCount();
		close(conn);
		
		return rcnt;
	}
	
}
