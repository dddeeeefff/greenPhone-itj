package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;


@WebServlet("/buy_view_proc")
public class BuyViewProcCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;     
    public BuyViewProcCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String siid = request.getParameter("si_id");
		int siupoint = Integer.parseInt(request.getParameter("si_upoint"));
		String sistatus = request.getParameter("si_status");
		
		SellInfo si = new SellInfo();
		si.setSi_id(siid);
		si.setSi_upoint(siupoint);
		si.setSi_status(sistatus);
		
		
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
		
		BuyViewProcSvc buyViewProcSvc = new BuyViewProcSvc();
		
		int result = buyViewProcSvc.cancelStatus(si);
		
		if (result > 0) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
    		out.println("<script>");
    		out.println("alert('주문취소가 완료되었습니다.');");
    		out.println("location.href='buy_view?siid=" + siid + "';");
    		out.println("</script>");
    		out.close();
    	} 
	}

}
