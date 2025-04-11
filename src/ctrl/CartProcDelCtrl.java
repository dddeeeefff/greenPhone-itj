package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/cart_proc_del")
public class CartProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public CartProcDelCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String scidx = request.getParameter("scidx");
		// ���� ��ǰ �ε��� ��ȣ
		
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
		
		String where = " where mi_id = '" + miid + "' ";
		if (scidx.indexOf(',') > 0) {	// ���� ��ǰ ����
			String[] arr = scidx.split(",");
			for (int i = 0; i < arr.length; i++) {
				if (i == 0) where += " and (sc_idx = " + arr[i];
				else		where += " or sc_idx = " + arr[i];
			}
			where += ")";
		} else {	// ��ǰ �Ѱ� ����
			where += " and sc_idx = " + scidx;
		}
		
		CartProcDelSvc cartProcDelSvc = new CartProcDelSvc();
		int result = cartProcDelSvc.cartDelete(where);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
	}

}
