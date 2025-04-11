package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/notice_view")
public class NoticeViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public NoticeViewCtrl() {  super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	int bnidx = Integer.parseInt(request.getParameter("bnidx"));
    	System.out.println(bnidx);
    	
    	
    	NoticeViewSvc noticeViewSvc = new NoticeViewSvc();
    	BbsNotice noticeDetail = noticeViewSvc.getNoticeDetail(bnidx);
    	int result = noticeViewSvc.readUpdate(bnidx);
    	
    	request.setAttribute("noticeDetail", noticeDetail);
    	
    	
    	RequestDispatcher dispatcher = request.getRequestDispatcher("/bbs/notice_view.jsp");
		dispatcher.forward(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
