package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/review_view")
public class ReviewViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ReviewViewCtrl() { super(); }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String bridx = request.getParameter("br_idx");
				
		ReviewViewSvc reviewViewSvc = new ReviewViewSvc();
		
		reviewViewSvc.getReadUpdate(bridx);
		
		BbsReview review = reviewViewSvc.getReview(bridx);
		BbsReview PrevReview = reviewViewSvc.getPrevReview(bridx);
		BbsReview NextReview = reviewViewSvc.getNextReview(bridx);
		if (PrevReview == null) {
			PrevReview = new BbsReview();
			System.out.println(PrevReview.getBr_idx());
		}
		if (NextReview == null) {
			NextReview = new BbsReview();
			System.out.println(NextReview.getBr_idx());
		}
		request.setAttribute("PrevReview", PrevReview);
		request.setAttribute("NextReview", NextReview);
		request.setAttribute("review", review);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/bbs/review_view.jsp");
		dispatcher.forward(request, response);
		

	}

}
