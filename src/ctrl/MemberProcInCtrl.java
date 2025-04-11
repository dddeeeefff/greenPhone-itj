package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/member_proc_in")
public class MemberProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberProcInCtrl() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		if(request.getParameter("mi_pw").length() < 7) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('8~12 자리의 비밀번호를 입력해 주세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		if (!request.getParameter("mi_pw").trim().equals(request.getParameter("mi_pwChk"))) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('비밀번호가 일치하지 않습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		// 받아온 회원정보들을 저장할 인스턴스 생성
		MemberInfo memberInfo = new MemberInfo();		
		
		memberInfo.setMi_id(request.getParameter("mi_id").trim().toLowerCase());
		memberInfo.setMi_pw(request.getParameter("mi_pw").trim());
		memberInfo.setMi_name(request.getParameter("mi_name").trim());
		memberInfo.setMi_gender(request.getParameter("sex").trim());
		memberInfo.setMi_birth(request.getParameter("by") + "-" + 
		request.getParameter("bm") + "-" + request.getParameter("bd"));
		memberInfo.setMi_phone(request.getParameter("p1") + "-" + 
		request.getParameter("p2") + "-" + request.getParameter("p3"));
		memberInfo.setMi_email(request.getParameter("e1").trim() +
		"@" + request.getParameter("e3").trim());
		memberInfo.setMi_point(10000);
		memberInfo.setMi_zip(request.getParameter("mi_zip").trim());
		memberInfo.setMi_addr1(request.getParameter("mi_addr1").trim());
		memberInfo.setMi_addr2(request.getParameter("mi_addr2").trim());
		
		
		MemberProcInSvc memberProcInSvc = new MemberProcInSvc();
		int result = memberProcInSvc.memberProcIn(memberInfo);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		if (result == 2) {	// 정상적으로 회원가입이 이루어 졌으면
			out.println("alert('회원 가입에 성공하셨습니다.');");
			out.println("location.href='login_form'");
			out.println("</script>");
			out.close();
			
		} else { 			// 회원 가입 실패
			out.println("alert('회원 가입에 실패했습니다.\\n다시 시도하세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}

}
