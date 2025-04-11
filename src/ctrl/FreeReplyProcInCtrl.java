package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/free_reply_proc_in")
public class FreeReplyProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public FreeReplyProcInCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int bfidx = Integer.parseInt(request.getParameter("bfidx"));
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String uid = loginInfo.getMi_id();
				
		String content = request.getParameter("content");
		if (content != null)	content = getStr(content);
		
		BbsFreeReply bfr = new BbsFreeReply();
		bfr.setBf_idx(bfidx);
		bfr.setMi_id(uid);
		bfr.setBfr_content(content);
		
		FreeReplyProcInSvc freeReplyProcInSvc = new FreeReplyProcInSvc();
		int result = freeReplyProcInSvc.replyInsert(bfr);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);		// 댓글 등록 기능을 호출했던 ajax를 사용한 곳으로 결과값을 리턴
		out.close();
		
	}

	private String getStr(String str) {
	// 사용자가 입력한 문자열에 대한 처리를 해서 리턴하는 메소드
		return str.trim().replace("'", "''").replace("<", "&lt;");
	}
}
