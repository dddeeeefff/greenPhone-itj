package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/cart_proc_up")
public class CartProcUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;       
    public CartProcUpCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int scidx = Integer.parseInt(request.getParameter("scidx"));
		// ����� where ������ �������� ����� ��ٱ��� ���̺� PK
		int cnt = Integer.parseInt(request.getParameter("cnt"));
		// cnt : ���� ����
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�α��� �� ����Ͻ� �� �ֽ��ϴ�.');");
			out.println("location.replace('login_form.jsp?url=cart_view');");
			out.println("</script>");
			out.close();
		}
		String miid = loginInfo.getMi_id();
		
		SellCart sc = new SellCart();
		sc.setSc_idx(scidx);	sc.setMi_id(miid);
		sc.setSc_cnt(cnt);
		CartProcUpSvc cartProcUpSvc = new CartProcUpSvc();
		int result = cartProcUpSvc.cartUpdate(sc);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
	}

}
