package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/buy_view")
public class BuyViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BuyViewCtrl() { super(); }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String siid = request.getParameter("siid");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");

		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		String miid = loginInfo.getMi_id();
		
		BuyViewSvc buyViewSvc = new BuyViewSvc();
		ArrayList<SellDetail> sellDetailList = buyViewSvc.getSellDetailList(miid, siid);
		SellInfo sellInfo = buyViewSvc.getSellInfo(miid, siid);
		
		if (sellInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		request.setAttribute("sellDetailList", sellDetailList);
		request.setAttribute("sellInfo", sellInfo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("order/buy_view.jsp");
		dispatcher.forward(request, response);
		
		
	}
}
