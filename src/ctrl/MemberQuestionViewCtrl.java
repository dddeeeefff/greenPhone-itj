package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/member_question_view")
public class MemberQuestionViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberQuestionViewCtrl() { super(); }

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
		int idx = Integer.parseInt(request.getParameter("bmqidx"));
		MemberQuestionViewSvc memberQuestionViewSvc = new MemberQuestionViewSvc();
		MemberQuestion memberQuestion = memberQuestionViewSvc.getMemberQuestion(miid,idx);
		
		
		request.setAttribute("memberQuestion", memberQuestion);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/bbs/member_question_view.jsp");
		dispatcher.forward(request, response);

	}

}
