package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/event_view")
public class EventViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public EventViewCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int beidx = Integer.parseInt(request.getParameter("beidx"));
		
		EventViewSvc eventViewSvc = new EventViewSvc();
		int result = eventViewSvc.readUpdate(beidx);
		// 게시글의 조회수를 증가시키는 메소드 호출
		BbsEvent be = eventViewSvc.getEventInfo(beidx);
		// 게시글의 내용들을 BbsEvent형 인스턴스로 받아옴
		
		if (be == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		} else {
			request.setAttribute("be", be);			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/bbs/event_view.jsp");
			dispatcher.forward(request, response);
		}
	}
}
