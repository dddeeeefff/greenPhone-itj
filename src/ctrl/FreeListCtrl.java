package ctrl;

import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/free_list")
public class FreeListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public FreeListCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(게시글) 개수, 페이지 개수, 시작 페이지 등을 저장할 변수들
		if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage"));
		String schtype = request.getParameter("schtype");		// 검색 조건(제목, 내용, 작성자)
		String keyword = request.getParameter("keyword");		// 검색어
		String where = " where bf_isdel = 'n' ";		// 검색 조건이 있을 경우 where 절을 저장할 변수
		
		if (schtype == null || keyword == null) {
			schtype = "";		keyword = "";
			 
		} else if (!schtype.equals("") && !keyword.equals("")) {		// 검색 조건과 검색어가 모두 있을 경우
			URLEncoder.encode(keyword, "UTF-8");		// 쿼리 스트링으로 주고 받는 검색어가 한글 일 경우 브라우저에 따라 문제가 발생할 수 있으므로 유니코드로 변환
			if (schtype.equals("writer")) {		// 검색 조건이 '작성자'일 경우
				where += " and mi_id like '%" + keyword + "%' ";
			} else {		// 검색 조건이 '제목'이나 '내용'일 경우
				where += " and bf_" + schtype + " like '%" + keyword + "%'";
			}
			
		}
				
		FreeListSvc freeListSvc = new FreeListSvc();
		rcnt = freeListSvc.getFreeListCount(where);
		ArrayList<BbsFree> freeList = freeListSvc.getFreeList(where, cpage, psize);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setCpage(cpage);
		pageInfo.setPsize(psize);
		pageInfo.setBsize(bsize);
		pageInfo.setRcnt(rcnt);
		pageInfo.setPcnt(pcnt);
		pageInfo.setSpage(spage);
		pageInfo.setSchtype(schtype);
		pageInfo.setKeyword(keyword);
		
		request.setAttribute("freeList", freeList);
		request.setAttribute("pageInfo", pageInfo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("bbs/free_list.jsp");
		dispatcher.forward(request, response);
	}

}
