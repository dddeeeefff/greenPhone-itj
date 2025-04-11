package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/product_view")
public class ProductViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ProductViewCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String piid = request.getParameter("piid");
		ProductViewSvc productViewSvc = new ProductViewSvc();
		
		ProductInfo pi = productViewSvc.getProductInfo(piid);
		if (pi == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('상품 정보가 없습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		request.setAttribute("pi", pi);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/buy/product_view.jsp");
		dispatcher.forward(request, response);
	}
}
