package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/sell_view")
public class SellViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public SellViewCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String biid = request.getParameter("biid");
		
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
		
		SellViewSvc sellViewSvc = new SellViewSvc();
		BuyInfo buyInfo = sellViewSvc.getBuyInfo(miid, biid);
		
		System.out.println(buyInfo);
		
		if (buyInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		request.setAttribute("buyInfo", buyInfo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("order/sell_view.jsp");
		dispatcher.forward(request, response);
		
	}

}
