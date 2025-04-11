package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/sell_proc_up")
public class SellProcUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public SellProcUpCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String biid = request.getParameter("biid");
		String status = request.getParameter("status");
		String biinvoice = request.getParameter("biinvoice");
		String bibank = request.getParameter("bibank");
		String biaccount = request.getParameter("biaccount");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (loginInfo == null) {
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.);");
			out.println("history.back();");
			out.println("</script>");
		}

		String miid = loginInfo.getMi_id();
		String where = " where bi_id = '" + biid + "' and mi_id = '" + miid + "'";
		
		BuyInfo bi = new BuyInfo();
		bi.setBi_id(biid);
		bi.setBi_status(status);
		bi.setBi_invoice(biinvoice);
		bi.setBi_bank(bibank);
		bi.setBi_account(biaccount);
		bi.setMi_id(miid);
		if (status.equals("k")) {
			int bipay = Integer.parseInt(request.getParameter("bipay"));
			bi.setBi_pay(bipay);
			int bioption = Integer.parseInt(request.getParameter("bioption"));
			bi.setBi_option(bioption);
		}
		
		SellProcUpSvc sellProcUpSvc = new SellProcUpSvc();
		int result = sellProcUpSvc.sellProcUp(bi, status);
		
		boolean isUp = false;
		if ((status.equals("b") || status.equals("e") || status.equals("i") || status.equals("j") || status.equals("f")) 
				&& result == 1) {
			isUp = true;
		} else if (status.equals("k") && result == 4) {
			isUp = true;
		} 
		
		if (isUp) {
    		out.println("<script>");
    		out.println("alert('정상적으로 처리되었습니다.');");
    		out.println("location.href='sell_view?biid=" + biid + "';");
    		out.println("</script>");
    		out.close();
		} else {
    		out.println("<script>");
    		out.println("alert('처리에 실패하였습니다.\\n다시 시도하세요.');");
    		out.println("history.back();");
    		out.println("</script>");
    		out.close();
    	}
		
	}

}
