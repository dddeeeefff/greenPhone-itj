package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/member_form_in")
public class MemberFormIn extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MemberFormIn() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		
		HttpSession session = request.getSession();
		// JSP가 아니므로 세션 객체를 사용하려면 직접 HttpSession 클래스의 인스턴스를 생성해야 함
		if (session.getAttribute("loginInfo") != null) {
		// 현재 로그인이 되어 있는 상태라면
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/member/member_form_in.jsp");
		dispatcher.forward(request, response);
	}
		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
