package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/order_end")
public class OrderEndCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;    
    public OrderEndCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String siid = request.getParameter("siid");
		HttpSession session = request.getSession();
		MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
		String miid = mi.getMi_id();
		
		OrderEndSvc orderEndSvc = new OrderEndSvc();
		SellInfo si = orderEndSvc.getSellInfo(siid);
		
		if (si == null) {
			response.setContentType("text/html; charset=utf-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("location.replace('/greenPhone/');");
			out.println("</script>");
			out.close();
		}else {	// �ֹ� ������ ���� ���
			request.setAttribute("si", si);
			RequestDispatcher dispatcher = request.getRequestDispatcher("order/order_end.jsp");
			dispatcher.forward(request, response);
		}
	}

}
