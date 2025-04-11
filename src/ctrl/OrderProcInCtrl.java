package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/order_proc_in")
public class OrderProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public OrderProcInCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용이 가능합니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		String miid = loginInfo.getMi_id();
		String kind = request.getParameter("kind");
		int total = Integer.parseInt(request.getParameter("total"));
		String scidxs = request.getParameter("scidxs");
		
		
		
		
		
		
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
		
		String result = null, temp = "";
		OrderProcInSvc orderProcInSvc = new OrderProcInSvc();
		if (kind.equals("c")) {	// 장바구니를 통한 구매일 경우
			temp = request.getParameter("scidxs");
			// 장바구니에서 구매할 상품들의 인덱스번호들(쉼표로 구분)
		} else {	// 바로 구매일 경우
			
		}
		result = orderProcInSvc.orderInsert(kind, si, temp);
		String[] arr = result.split(",");
		if (arr[1].equals(arr[2])) {	// 정상적으로 구매가 이루어졌으면
			response.sendRedirect("order_end?siid=" + arr[0]);
		} else {	// 정상적으로 구매가 이루어지지 않았으면
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
