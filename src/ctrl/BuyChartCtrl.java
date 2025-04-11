package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/buy_chart")
public class BuyChartCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public BuyChartCtrl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String model = request.getParameter("model");
		if (model == null)	model = "";
		model = model.trim().toLowerCase();
		
		int cpage = 1, psize = 15, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(게시글) 개수, 페이지 개수, 시작 페이지 등을 저장할 변수들
		
		if (request.getParameter("cpage") != null) 
			cpage = Integer.parseInt(request.getParameter("cpage"));
		
		BuyChartSvc buyChartSvc = new BuyChartSvc();
		rcnt = buyChartSvc.getBuyChartCount(model);
		ArrayList<BuyChart> buyChartList = buyChartSvc.getBuyChartList(model, cpage, psize);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize);
		pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);
		pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);
		pageInfo.setSpage(spage);
		pageInfo.setKeyword(model);
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("buyChartList", buyChartList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("buy_chart.jsp");
		dispatcher.forward(request, response);
		
	}

}
