package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/point_list")
public class PointListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PointListCtrl() { super(); }

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
		}
		
		String miid = loginInfo.getMi_id();
		PointListSvc pointListSvc = new PointListSvc();
		ArrayList<MemberPoint> memberPointList = pointListSvc.getMemberPointList(miid);
		
		request.setAttribute("memberPointList", memberPointList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/member/point_list.jsp");
		dispatcher.forward(request, response);


	}

}
