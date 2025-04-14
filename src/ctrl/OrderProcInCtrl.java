package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/order_proc_in")
public class OrderProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public OrderProcInCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo) session.getAttribute("loginInfo");

		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용이 가능합니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return;
		}

		String miid = loginInfo.getMi_id();
		String kind = request.getParameter("kind");
		int total = Integer.parseInt(request.getParameter("total"));

		// 결제정보
		String siid = request.getParameter("siid");
		String siname = loginInfo.getMi_name();
		String siphone = loginInfo.getMi_phone();
		String sizip = loginInfo.getMi_zip();
		String siaddr1 = loginInfo.getMi_addr1();
		String siaddr2 = loginInfo.getMi_addr2();
		String simemo = request.getParameter("memoBox");
		if (simemo.equals("write"))	simemo = request.getParameter("simemo");
		String sipayment = request.getParameter("si_payment");
		int sipay = Integer.parseInt(request.getParameter("totalPrice"));
		int siupoint = Integer.parseInt(request.getParameter("uPoint"));
		int sispoint = Integer.parseInt(request.getParameter("sPoint"));
		String siinvoice = request.getParameter("si_invoice");
		String sistatus = request.getParameter("si_status");

		SellInfo si = new SellInfo();
		si.setSi_id(siid);			si.setMi_id(miid);
		si.setSi_name(siname);
		si.setSi_phone(siphone);	si.setSi_zip(sizip);
		si.setSi_addr1(siaddr1);	si.setSi_addr2(siaddr2);
		si.setSi_memo(simemo);		si.setSi_payment(sipayment);
		si.setSi_pay(total);		si.setSi_upoint(siupoint);
		si.setSi_spoint(sispoint); 	si.setSi_invoice(siinvoice);
		si.setSi_status(sipayment.equals("c") ? "a" : "b");

		String result = null;
		String temp = "";

		if (kind.equals("c")) {
			// 장바구니 구매일 경우
			temp = request.getParameter("scidxs");

		} else {
			// 바로구매일 경우
			String piid = request.getParameter("pi_id");
			String poidx = request.getParameter("po_idx");
			String cnt = request.getParameter("cnt");

			if (piid == null || poidx == null || cnt == null ||
					piid.isEmpty() || poidx.isEmpty() || cnt.isEmpty()) {
				response.setContentType("text/html; charset=utf-8;");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('바로구매 정보가 올바르지 않습니다.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
				return;
			}

			temp = piid + "," + poidx + "," + cnt;
		}

		OrderProcInSvc orderProcInSvc = new OrderProcInSvc();
		result = orderProcInSvc.orderInsert(kind, si, temp);
		String[] arr = result.split(",");

		if (arr[1].equals(arr[2])) {
			response.sendRedirect("order_end?siid=" + arr[0]);
		} else {
			response.setContentType("text/html; charset=utf-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('구매가 정상적으로 처리되지 않았습니다.\\n고객 센터에 문의 하세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}
}