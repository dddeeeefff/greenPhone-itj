<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_price.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<BbsFree> freeList = (ArrayList<BbsFree>)request.getAttribute("freeList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");

int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage(), psize = pageInfo.getPsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();
String schtype = pageInfo.getSchtype(), keyword = pageInfo.getKeyword();

String schargs = "", args = "";
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {		// 검색 조건(schtype)과 검색어(keyword)가 있으면 검색관련 쿼리스트링 생성
	schargs = "&schtype=" + schtype + "&keyword=" + keyword;	
}
args = "&cpage=" + cpage + schargs;
%>
<script>
	function sub() {
	    var frm = document.sch;
	    var schtype = frm.schtype.value;
	    var keyword = frm.keyword.value;
	    if (schtype == "" || keyword == "") {
	        alert("검색 항목과 검색어를 확인하세요.");
	        return false;
	    }
	    frm.submit();
	}
</script>
<link rel="stylesheet" href="src/css/free_list.css">
<script src='https://kit.fontawesome.com/77ad8525ff.js' crossorigin="anonymous"></script>
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>
    <div class="tab">
        <ul>
            <li>
                <a href="notice_list">공지사항</a>
            </li>
            <li>
                <a href="faq">FAQ</a>
            </li>
            <li>
                <a href="event_list">이벤트</a>
            </li>
            <li>
                <a href="review_list">리뷰</a>
            </li>
            <li class="active">
                <a href="free_list">자유 게시판</a>
            </li>
        </ul>
    </div>
    <div class="page-contents">
        <h3 class="guide">자유 게시판</h3>
        <div class="form-wrap">
            <form name="sch">
                <select name="schtype">
                    <option value="">검색 항목</option>
                    <option value="title" <% if (schtype.equals("title")) { %>selected="selected"<% } %>>제목</option>
                    <option value="content" <% if (schtype.equals("content")) { %>selected="selected"<% } %>>내용</option>
                    <option value="writer" <% if (schtype.equals("writer")) { %>selected="selected"<% } %>>작성자</option>
                </select>
                <input type="text" name="keyword" value="<%=keyword %>" placeholder="검색어를 입력하세요." />
                <span onclick="return sub();"><i class="fa-solid fa-search"></i></span>
            </form>
        </div>
        <div class="content">
            <table cellpadding="5" cellspacing="0">
                <tr>
                    <th width="10%">글 번호</th>
                    <th width="*">제목</th>
                    <th width="20%">작성자</th>
                    <th width="10%">조회수</th>
                    <th width="20%">등록일</th>
                </tr>
<%
if (freeList.size() > 0) {		// 게시글 목록이 있으면
	int num = rcnt - (psize * (cpage - 1));
	for (int i = 0; i < freeList.size(); i++) {
		BbsFree bf = freeList.get(i);
		
		String title = bf.getBf_title();
		if (title.length() > 30)		title = title.substring(0, 24) + "...";
		title = "<a href='free_view?bfidx=" + bf.getBf_idx() + args + "'>" + title + "</a>";
		if (bf.getBf_reply() > 0)		title += "  <span>[" + bf.getBf_reply() + "]</span>";
		
		String writer = bf.getMi_id().substring(0, 4) + "****";
%>
                <tr>
                    <td><%=num %></td>
                    <td><%=title %></td>
                    <td><%=writer %></td>
                    <td><%=bf.getBf_read() %></td>
                    <td><%=bf.getBf_date() %></td>
                </tr>
<%
		num--;
	}
} else {		// 게시글 목록이 없으면
	out.println("<tr><td colspan='5' align='center'>검색 결과가 없습니다.</td></tr>");
}
%>
			</table>
<% 
String lnk = "free_form_in";
if (!isLogin) {
	lnk = "login_form?url=free_form_in";
%>
<% } %>
            <div class="btn">
                <p>
                    <input type="button" value="글 등록" onclick="location.href='<%=lnk %>'" />
                </p>
            </div>
			<div class="pagination">
                <ul>
<%
if (rcnt > 0) {		// 게시글이 있으면 - 페이징 영역을 보여줌
	lnk = "free_list?cpage=";
	pcnt = rcnt / psize;
	if (rcnt % psize > 0)		pcnt++;		// 전체 페이지 수(마지막 페이지 번호)
	
	if (cpage == 1) {
		out.println("<li><i class='fa-regular fa-angles-left'></i></li>");
		out.println("<li><i class='fa-regular fa-angle-left'></i></li>");
	} else {
		out.println("<li><a href='" + lnk + 1 + schargs + "'><i class='fa-regular fa-angles-left'></i></li>");
		out.println("<li><a href='" + lnk + (cpage - 1) + schargs + "'><i class='fa-regular fa-angle-left'></i></li>");
	}
	
	spage = (cpage - 1) / bsize * bsize + 1;		// 현재 블록에서의 시작 페이지 번호
	for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
	// i : 블록에서 보여줄 페이지의 개수 만큼 루프를 돌릴 조건으로 사용되는 변수
	// j : 실제 출력할 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
		if (cpage == j)		out.println("<li><a href='' class='active' onclick='return false;'>" + j + "</a></li>");
		else 				out.println("<li><a href='" + lnk + j + schargs + "'>" + j + "</a></li>");
	}
	
	if (cpage == pcnt) {
		out.println("<li><i class='fa-regular fa-angle-right'></i></li>");
		out.println("<li><i class='fa-regular fa-angles-right'></i></li>");	
	} else {
		out.println("<li><a href='" + lnk + (cpage + 1) + schargs + "'><i class='fa-regular fa-angle-right'></i></a></li>");
		out.println("<li><a href='" + lnk + pcnt + schargs + "'><i class='fa-regular fa-angles-right'></i></a></li>");
	}
}
%>
                </ul>
            </div>
		</div>
	</div>
</body>
</html>