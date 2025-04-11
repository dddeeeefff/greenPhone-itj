package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/change_pw_proc")
public class ChangePwProcCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ChangePwProcCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		// 받아온 회원정보들을 저장할 인스턴스 생성
		if (loginInfo.getMi_pw().equals(request.getParameter("old_pw"))) {
			MemberInfo memberInfo = new MemberInfo();
			memberInfo.setMi_id(loginInfo.getMi_id());
			String newPw = request.getParameter("new_pw"); 
			memberInfo.setMi_pw(newPw);
			ChangePwProcSvc changePwProcSvc = new ChangePwProcSvc();
			int result = changePwProcSvc.changePwProc(memberInfo);
			if (result == 1) { // 정상적으로 정보수정이 이루어 졌으면
				loginInfo.setMi_pw(newPw);
				session.setAttribute("loginInfo", loginInfo);
				response.sendRedirect("member_form_up");
			} else { // 회원 정보수정 실패
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('비밀번호 변경에 실패 했습니다.\\n다시 시도하세요.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			}
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('비밀번호 다름.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}


	}
}
