package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/order_addr_form")
public class OrderAddrProcCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	
    public OrderAddrProcCtrl() {  super();  }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String def = request.getParameter("checked");	// 기본배송지 변경(y), 주문화면만 변경(n) 구분자
		String miid = request.getParameter("miid");
		String name = request.getParameter("name");
		String miphone = request.getParameter("phone");		
		String mizip = request.getParameter("zip");
		String miaddr1 = request.getParameter("addr1");
		String miaddr2 = request.getParameter("addr2");
		System.out.println(miid);
		System.out.println(def);
		System.out.println(miphone);
		System.out.println(mizip);
		System.out.println(miaddr1);
		System.out.println(miaddr2);
		MemberInfo memberInfo = new MemberInfo();
		memberInfo.setMi_id(miid);
		memberInfo.setMi_name(name);	memberInfo.setMi_phone(miphone);
		memberInfo.setMi_zip(mizip);	memberInfo.setMi_addr1(miaddr1);
		memberInfo.setMi_addr2(miaddr2);
		
		OrderAddrProcSvc orderAddrProcSvc = new OrderAddrProcSvc();
		int result = OrderAddrProcSvc.orderAddrProc(memberInfo, def);
		
		response.setContentType("text/html; charset=utf-8;");
		PrintWriter out = response.getWriter();
		out.println(result);
	}

}

