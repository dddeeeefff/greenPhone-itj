package ctrl;

import java.io.*;
import java.time.LocalDate;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/free_proc_del")
public class FreeProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public FreeProcDelCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

    	HttpSession session = request.getSession();
    	MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");

    	response.setContentType("text/html; charset=utf-8"); 
    	PrintWriter out = response.getWriter();
    	if (loginInfo == null) {
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
    	
		int cpage = 1;
		if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage"));
		String schtype = request.getParameter("schtype"), keyword = request.getParameter("keyword");
		
		String args = "?cpage=" + cpage;
		
		if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
			args += "&schtype=" + schtype + "&keyword=" + keyword;
		}
		
		int bfidx = Integer.parseInt(request.getParameter("bfidx"));
		
		FreeProcDelSvc freeProcDelSvc = new FreeProcDelSvc();
		int result = freeProcDelSvc.freeProcDel(bfidx);
		
    	if (result == 1) {
    		out.println("<script>");
    		out.println("alert('게시글이 삭제되었습니다.');");
    		out.println("location.href='free_list" + args + "';");
    		out.println("</script>");
    		out.close();
    	} else {
    		out.println("<script>");
    		out.println("alert('게시글 삭제에 실패하였습니다.\\n다시 시도하세요.');");
    		out.println("history.back();");
    		out.println("</script>");
    		out.close();
    	}
    	
	}

}
