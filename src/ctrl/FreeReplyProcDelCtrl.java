package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/free_reply_proc_del")
public class FreeReplyProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public FreeReplyProcDelCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		int bfidx = Integer.parseInt(request.getParameter("bfidx"));
		int bfridx = Integer.parseInt(request.getParameter("bfridx"));
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		response.setContentType("text/html; charset=utf-8");
		if (loginInfo == null) {
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 접근하셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		BbsFreeReply bfr = new BbsFreeReply();
		bfr.setBf_idx(bfidx);
		bfr.setBfr_idx(bfridx);
		bfr.setMi_id(loginInfo.getMi_id());
			
		int cpage = Integer.parseInt(request.getParameter("cpage"));
		String args = "?cpage=" + cpage;		// 링크에서 사용할 쿼리 스트링
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
			args += "&schtype=" + schtype + "&keyword=" + keyword;
		}
		
		FreeReplyProcDelSvc freeReplyProcDelSvc = new FreeReplyProcDelSvc();
		int result = freeReplyProcDelSvc.replyDelete(bfr);
		
		if (result == 1) {		// 정상적으로 삭제되었을 경우
			response.sendRedirect("free_view" + args + "&bfidx=" + bfidx);
		} else {		// 정상적으로 삭제되지 않았을 경우
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('댓글 삭제에 실패하였습니다.\\n다시 시도하세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
	}

}
