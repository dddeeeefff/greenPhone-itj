/*
package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/order_addr_form")
public class OrderAddrFormCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;     
    public OrderAddrFormCtrl() {  super();  }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String def = request.getParameter("def");	// 기본배송지 변경(y), 주문화면만 변경(n) 구분자
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		String miphone = request.getParameter("miphone");
		String mizip = request.getParameter("mizip");
		String miaddr1 = request.getParameter("miaddr1");
		String miaddr2 = request.getParameter("miaddr2");

		MemberInfo mi = new MemberInfo();
		mi.setMi_name(miid);	mi.setMi_phone(miphone);
		mi.setMi_zip(mizip);	mi.setMi_addr1(miaddr1);
		mi.setMi_addr2(miaddr2);
		
		OrderAddrProcSvc orderAddrProcSvc = new OrderAddrProcSvc();
		MemberInfo mi = OrderAddrProcSvc.upAddrInfo(miid)
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("order/order_addr_form.jsp");
		dispatcher.forward(request, response);
	}

}

*/
