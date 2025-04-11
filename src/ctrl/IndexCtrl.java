package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/index")
public class IndexCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public IndexCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		IndexSvc indexSvc = new IndexSvc();
		ArrayList<ProductInfo> recentProductList = indexSvc.getRecentProductList();
		ArrayList<ProductInfo> hotProductList = indexSvc.getHotProductList();
		ArrayList<ProductInfo> dcProductList = indexSvc.getDcProductList();
		ArrayList<BbsReview> recentReviewList = indexSvc.getRecentReviewList();
		
		request.setAttribute("recentProductList", recentProductList);
		request.setAttribute("hotProductList", hotProductList);
		request.setAttribute("dcProductList", dcProductList);
		request.setAttribute("recentReviewList", recentReviewList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("real_index.jsp");
		dispatcher.forward(request, response);
	}

}
