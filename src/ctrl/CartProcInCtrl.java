package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;


@WebServlet("/cart_proc_in")
public class CartProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;      
    public CartProcInCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String piid = request.getParameter("piid");
		int poidx = Integer.parseInt(request.getParameter("poidx"));
		// System.out.println("poidx : " + poidx);
		int cnt = Integer.parseInt(request.getParameter("cnt"));
		// System.out.println("cnt : " + cnt);
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		
		SellCart sc = new SellCart();
		sc.setMi_id(miid);		sc.setPi_id(piid);
		sc.setPo_idx(poidx);	sc.setSc_cnt(cnt);
		
		CartProcInSvc cartProcInSvc = new CartProcInSvc();
		int result = cartProcInSvc.cartInsert(sc);
		
		response.setContentType("text/html; charset=utf-8;");
		PrintWriter out = response.getWriter();
		out.println(result);
		// 장바구니 담기 기능을 호출했던 ajax를 사용한 곳으로 결과값을 리턴
	}

}
