package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/review_list")
public class ReviewListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ReviewListCtrl() { super(); }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int cpage = 1, psize = 8, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		// �쁽�옱 �럹�씠吏� 踰덊샇, �럹�씠吏� �겕湲�, 釉붾줉 �겕湲�, �젅肄붾뱶(寃뚯떆湲�) 媛쒖닔, �럹�씠吏� 媛쒖닔, �떆�옉 �럹�씠吏� �벑�쓣 ���옣�븷 蹂��닔�뱾
		if (request.getParameter("cpage") != null) 
			cpage = Integer.parseInt(request.getParameter("cpage"));
		// cpage 媛믪씠 �엳�쑝硫� 諛쏆븘�꽌 int�삎�쑝濡� �삎蹂��솚 �떆�궡(蹂댁븞�긽�쓽 �씠�쑀�� �궛�닠�뿰�궛�쓣 �빐�빞 �븯湲� �븣臾�)

		
		ReviewListSvc reviewListSvc = new ReviewListSvc();
		
		rcnt = reviewListSvc.getReviewListCount();
		ArrayList<BbsReview> reviewList = reviewListSvc.getReviewList(cpage, psize);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize);
		pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);
		pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);
		pageInfo.setSpage(spage);
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("reviewList", reviewList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/bbs/review_list.jsp");
		dispatcher.forward(request, response);

	}

}
