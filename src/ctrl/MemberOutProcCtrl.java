package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/member_out_proc")
public class MemberOutProcCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MemberOutProcCtrl() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		// 받아온 회원정보들을 저장할 인스턴스 생성
		MemberInfo memberInfo = new MemberInfo();
		memberInfo.setMi_id(loginInfo.getMi_id());
		memberInfo.setMi_status(loginInfo.getMi_status());

		MemberOutProcSvc memberOutProcSvc = new MemberOutProcSvc();
		int result = memberOutProcSvc.memberOutProc(memberInfo);
		if (result == 1) { // 정상적으로 정보수정이 이루어 졌으면
		
		session.invalidate();
		response.sendRedirect("index");


		} else { // 회원 정보수정 실패
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원 정보 수정에 실패 했습니다.\\n다시 시도하세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}

}
