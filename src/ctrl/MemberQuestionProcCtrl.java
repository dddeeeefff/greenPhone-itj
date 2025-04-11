package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/member_question_proc")
public class MemberQuestionProcCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberQuestionProcCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용하실 수 있습니다.');");
			out.println("location.replace('login_form?url=member_question_list');");
			out.println("</script>");
		}

		String uid = loginInfo.getMi_id();
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		// 받아온 회원정보들을 저장할 인스턴스 생성
		
		MemberQuestionProcSvc memberQuestionProcSvc = new MemberQuestionProcSvc();
		int result = memberQuestionProcSvc.memberQuestionProc(uid, title, content);
		if (result == 1) { // 정상적으로 정보수정이 이루어 졌으면
			response.sendRedirect("member_question_list");
		}
				
	}

}
