package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/member_question_list")
public class MemberQuestionListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberQuestionListCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		if (loginInfo != null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		String miid = loginInfo.getMi_id();
		MemberQuestionListSvc memberQuestionListSvc = new MemberQuestionListSvc();
		ArrayList<MemberQuestion> memberQuestionList = memberQuestionListSvc.getMemberQuestionList(miid);

		request.setAttribute("memberQuestionList", memberQuestionList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/bbs/member_question_list.jsp");
		dispatcher.forward(request, response);


	}

}
