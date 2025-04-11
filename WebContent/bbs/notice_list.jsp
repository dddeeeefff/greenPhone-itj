<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_price.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<BbsNotice> noticeList = (ArrayList<BbsNotice>)request.getAttribute("noticeList");

int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize();
int rcnt = pageInfo.getRcnt(), spage = pageInfo.getSpage();
int bsize = pageInfo.getBsize(), pcnt = pageInfo.getPcnt();
String keyword = pageInfo.getKeyword();
String schtype = pageInfo.getSchtype();

String args = "", sargs = "";

if (schtype != null && !schtype.equals("") &&
keyword != null && !keyword.equals("")){
sargs += "&keyword=" + keyword;
}
args = "&cpage=" + cpage + sargs;
%>
<style>
.bbs_content { margin:0 auto;  }
.bbs_ctr_list{ margin-top:100px; display:flex; justify-content: center; width: 100%; }
.bbs_ctr{ width: 10%; text-align:center; border:1px solid #8a8a8a; padding:15px 0; color:#8a8a8a; margin-left:-1px; }
.bbs_ctr#ov{ background:#0e9482; border:1px solid #0e9482; }
.bbs_ctr#ov a{  color:#fff; }
.guide{color:#0e9482;margin:70px 0 70px 0;font-size:2.2em;font-weight:600;text-align: center;}
.search{ display:flex; justify-content: center; flex-direction: column; align-content: center; flex-wrap: wrap; }
.search_bar{ }
.notice_list{ margin-top:20px; }
.schtype{ padding : 10px 20px; }
.searchKeyword{ padding : 10px 10px; width:100%; }

#schkeyword input { width:40%;  margin:0 10px; border:none;border-bottom:2px solid #777;font-size:1.1em; color:#555;padding:15px 10px;box-sizing:border-box; }
#schkeyword input:focus{ outline:none; }
#schkeyword select{ font-size:1.1em; color:#555; border:none;border-bottom:2px solid #777;  vertical-align:middle; width:15%; padding:15px 10px;box-sizing:border-box;font-weight:600; }
.searchButton{ padding : 10px 18px; width:5%; }
td,th,table{ padding:8px 0; border-left: none; border-right: none; }
table{ border-top: none; padding-bottom:0;}
th{ font-weight:500; color: #333; background:#d6f1ed; }
</style>
<script>
function makeSch() {
// 키워드 검색
	var frm = document.frm;
	
	document.frm.submit();
}


</script>
<div class="bbs_content">
	<div class = bbs_ctr_list>
		<div class="bbs_ctr" id="ov"><a href="notice_list"><strong>공지사항</strong></a></div>
		<div class="bbs_ctr"><a href="faq">FAQ</a></div>
		<div class="bbs_ctr"><a href="event_list">이벤트</a></div>
		<div class="bbs_ctr"><a href="review_list">리뷰</a></div>
		<div class="bbs_ctr"><a href="free_list">자유 게시판</a></div>
	</div>
	
	<h3 class="guide">공지사항</h3>
	
	<div class="search">
		<div class="search_bar">
			<form name="frm" action="notice_list" method="get">
				<div id="schkeyword" align="center">
						<select name="schtype" class="schtype">
							<option value="bn_title"
							<% if(schtype.equals("bn_title")) { %>selected="selected"<% } %>>제목</option>
							<option value="bn_content"
							<% if(schtype.equals("bn_content")) { %>selected="selected"<% } %>>내용</option>
						</select>
						<input type="text" style="display:none;" />
						<input type="text" class="searchKeyword" name="keyword" id="keyword" placeholder="검색어를 입력해주세요." value="" />&nbsp;&nbsp;
						<input type="button" class="searchButton" value="찾기" id="btnsch" onclick="makeSch()" style="width:9%; border:1px solid black; " />
				</div>
			</form>
		</div>
		<div class="notice_list">
			<form name="frmisview">
				<table width="1000" align="center" border="1" cellpadding="3" cellspacing="0">
					<tr>
						<th width="8%">글번호</th>
						<th width="40%">제목</th>
						<th width="7%">작성자</th>
						<th width="7%">조회수</th>
						<th width="13%">등록일</th>
			
					</tr>
					<%
					if (rcnt > 0) {	// 검색된 상품 목록이 있을 경우
						String lnk = "notice_list?cpage=";
						for (int i = 0 ; i < noticeList.size() ; i++) {
							BbsNotice bn = noticeList.get(i);
							String admin = "";
							if(bn.getAi_idx() == 1 || bn.getAi_idx() == 2)	admin = "관리자";
							pcnt = rcnt / psize;
							if (rcnt % psize > 0)	pcnt++;	// 전체 페이지 수(마지막 페이지 번호)
							
					%>
					<tr align="center">
						<td><%=bn.getBn_idx() %></td>
						<td><a href="notice_view?bnidx=<%=bn.getBn_idx() %>"><%=bn.getBn_title() %></a></td>		
						<td><%=admin %></td>
						<td><%=bn.getBn_read() %></td>
						<td><%=bn.getBn_date().substring(0, 10) %></td>
					</tr>
					<% 
						}
					
					out.println("</table>");
						
					String tmp = sargs;
					// 페이징 영역 링크에서 사용할 쿼리 스트링
					out.println("<br />");
					out.println("<p class='pageinfo' align='center'>");
					
					if (cpage == 1) {
						out.println("[&lt;&lt;]&nbsp;&nbsp;[&lt;]&nbsp;");
					} else {
						out.print("<a href=\"notice_list?cpage=1" + tmp + "\">");
						out.println("[&lt;&lt;]</a>&nbsp;&nbsp;");
						out.print("<a href=\"notice_list?cpage=" + (cpage - 1) + tmp + "\">");
						out.println("[&lt;]</a>&nbsp;");
					}
					
					for (int i = 1, j = spage ; i < bsize && j <= pcnt ; i++, j++) {
						if (cpage == j) {
							out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
						} else {
							out.print("&nbsp;<a href=\"notice_list?cpage=");
							out.println(j + tmp + "\">" + j +"</a>&nbsp;");
						}
					}
					
					if (cpage == pcnt) {
						out.println("&nbsp;[&gt;]&nbsp;&nbsp;[&gt;&gt;]");
					} else {
						out.print("&nbsp;<a href=\"notice_list?cpage=" + (cpage + 1) + tmp + "\">");
						out.println("[&gt;]</a>&nbsp;&nbsp;");
						out.print("<a href=\"notice_list?cpage=" + pcnt + tmp + "\">");
						out.println("[&gt;&gt;]</a>");
					}
						out.println("</p>");
					} else {		// 검색된 상품 목록이 없을 경우
						out.println("</table>");
						out.println("<p class='nothing' align='center'>검색 결과가 없습니다.</p>");
					} %>
				</table>
			</form>
		</div>
	</div>
	<div style="height:50px;"> </div>
</div>
</body>
</html>