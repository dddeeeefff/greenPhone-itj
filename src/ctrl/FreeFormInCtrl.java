package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/free_form_in")
public class FreeFormInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public FreeFormInCtrl() { super(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	
    	HttpSession session = request.getSession();
		if (session.getAttribute("loginInfo") == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/bbs/free_form_in.jsp");
		dispatcher.forward(request, response);
    	
    }

}
