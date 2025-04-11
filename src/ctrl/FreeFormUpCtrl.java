package ctrl;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/free_form_up")
public class FreeFormUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public FreeFormUpCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int bfidx = Integer.parseInt(request.getParameter("bfidx"));
		
		FreeViewSvc freeViewSvc = new FreeViewSvc();
		
		BbsFree bf = freeViewSvc.getFreeInfo(bfidx);		// 사용자가 선택한 게시글의 내용들을 BbsFree 형 인스턴스로 받아옴
		
		if (bf == null) {		// 보여줄 게시글이 없으면
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.);");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		
		} else {		// 보여줄 게시글이 있으면
			request.setAttribute("bf", bf);
			RequestDispatcher dispatcher = request.getRequestDispatcher("bbs/free_form_up.jsp");
			dispatcher.forward(request, response);
		
		}	
		
	}

}
