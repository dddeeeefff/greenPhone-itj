package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/sell_form")
public class SellFormCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public SellFormCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		SellFormSvc sellFormSvc = new SellFormSvc();
		ArrayList<ProductBrand> brandList = sellFormSvc.getBrandList();
		ArrayList<ProductSeries> seriesList = sellFormSvc.getSeriesList();
		ArrayList<ProductInfo> productList = sellFormSvc.getProductList();
		
		request.setAttribute("brandList", brandList);
		request.setAttribute("seriesList", seriesList);
		request.setAttribute("productList", productList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("sell/sell_form.jsp");
		dispatcher.forward(request, response);
			
	}

}
