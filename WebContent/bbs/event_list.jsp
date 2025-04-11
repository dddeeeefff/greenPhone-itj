<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_price.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<BbsEvent> eventList = (ArrayList<BbsEvent>)request.getAttribute("eventList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage(), rcnt = pageInfo.getRcnt();
String keyword = pageInfo.getKeyword();

String schargs = "", args = "";
if (keyword != null && !keyword.equals("")) {
// 검색어(keyword)가 있으면 검색관련 쿼리스트링 생성
	schargs = "&keyword=" + keyword;
}
args = "&cpage=" + cpage + schargs;
%>
<style>
input::placeholder { font-size:20px; }
#bbs_content { width:1000px; margin:120px 0 50px 500px; }
#bbs_ctr_list{ margin:30px 0; display:flex; justify-content: center; width:1000px; text-align:center; }
.bbs_ctr{ width: 20%; text-align:center; border:1px solid #8a8a8a; padding:15px 0; color:#8a8a8a; margin-left:-1px;; }
.bbs_ctr#ov{ background:#0e9482; border:1px solid #0e9482; }
.bbs_ctr#ov a{  color:#fff; }
.guide{color:#0e9482;margin:40px 0 40px 0; font-size:2.2em; font-weight:600; text-align:center;}

#schEvent { text-align:center; }
#keyword { width:400px; height:50px; vertical-align:top; font-size:20px; }
#btnsch { width:70px; height:50px; font-size:20px; }
#tagEvent {  }
/*
ul.tabs { display:flex; justify-content: center; }
ul.tabs li {
	background: none;
	border:1px solid black; font-size:25px;
	margin:20px 20px; padding:5px;
	cursor:pointer;
}
ul.tabs li.current{
	background: #ededed;
	color: #222;
}

.tab-content{
	display: none;
	background: #ededed;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}*/
</style>
<script>
$(document).ready(function(){
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	})
})
</script>
<div id="bbs_content">
	<div id="bbs_ctr_list">
		<div class="bbs_ctr"><a href="notice_list">공지사항</a></div>
		<div class="bbs_ctr"><a href="faq">FAQ</a></div>
		<div class="bbs_ctr" id="ov"><a href="event_list"><strong>이벤트</strong></a></div>
		<div class="bbs_ctr"><a href="review_list">리뷰</a></div>
		<div class="bbs_ctr"><a href="free_list">자유 게시판</a></div>
	</div>
	<h3 class="guide">이벤트</h3>
	<form name="frmSch" method="get">
	<div id="schEvent">
		<input type="text" name="keyword" id="keyword" placeholder="&nbsp;&nbsp;제목을 입력하세요" value="<%=keyword %>" />&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="submit" value="검색" id="btnsch" />
	</div>
	</form>
	<!-- 
	<div id="tagEvent">
		<ul class="tabs">
			<li class="tab-link current" data-tab="tab-1">진행 중인 이벤트</li>
			<li class="tab-link" data-tab="tab-2">종료된 이벤트</li>
		</ul>
	</div>
	 -->
	<table width="1000" cellpadding="5" cellspacing="15" style="margin:30px;">
<%
	if (eventList.size() > 0) {
		int num = rcnt - (psize * (cpage - 1));
		int i = 0;
		for (i = 0 ; i < eventList.size() ; i++) {
			BbsEvent be = eventList.get(i);
			String lnk = "event_view?beidx=" + (num - 1) + args;
			
			if (i % 4 == 0)	out.println("<tr>");
%>
		<td width="25%" align="center" onmouseover="this.bgColor='#efefef';" onmouseout="this.bgColor='';">
			<a href="<%=lnk %>"><img src="/greenAdmin/bbs/upload/<%=be.getBe_img() %>" class="imgBlack" border="0" style='width:150px; height:180px;' /></a>
			<br /><a href="<%=lnk %>"><%=be.getBe_title() %></a>
			<br /><%=be.getBe_sdate() %>&nbsp;~&nbsp;<%=be.getBe_edate() %>
		</td>
<% 
			num--;
			if (i % 4 == 3)	out.println("<tr>");
		}
		
		if (i % 4 > 0) {
			for (int j = 0 ; j < (3 - (i % 4)) ; j++)
				out.println("<td width='25%'></td>");
			out.println("</tr>");
		}
		
	} else {
		out.print("<tr><td colspan='4' align='center'>");
		out.println("검색 결과가 없습니다.</td></tr>");
	}
%>
	</table>
	<table width="1000" cellpadding="5">
		<tr>
			<td align="center">
			<%
			if (rcnt > 0) {	// 게시글이 있으면 - 페이징 영역을 보여줌
				String lnk = "event_list?cpage=";
				pcnt = rcnt / psize;
				if (rcnt % psize > 0)	pcnt++;	// 전체 페이지 수(마지막 페이지 번호)
				
				if (cpage == 1) {
					out.println("[&lt;&lt;]&nbsp;&nbsp;&nbsp;[&lt;]&nbsp;&nbsp;");
				} else {
					out.println("<a href='" + lnk + 1 + schargs + "'>[&lt;&lt;]</a>&nbsp;&nbsp;&nbsp;");
					out.println("<a href='" + lnk + (cpage - 1) + schargs + "'>[&lt;]</a>&nbsp;&nbsp;");
				}
				
				spage = (cpage - 1) / bsize * bsize + 1;	// 현재 블록에서의 시작 페이지 번호
				for (int i = 1, j = spage ; i <= bsize && j <= pcnt ; i++, j++) {
				// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
				// j : 실제 출력할 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
					if (cpage == j) {
						out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
					} else {
						out.print("&nbsp;<a href='" + lnk + j + schargs + "'>");
						out.println(j + "</a>&nbsp;");
					}
				}
				
				if (cpage == pcnt) {
					out.println("&nbsp;&nbsp;[&gt;]&nbsp;&nbsp;&nbsp;[&gt;&gt;]");
				} else {
					out.println("&nbsp;&nbsp;<a href='" + lnk + (cpage + 1) + schargs + "'>[&gt;]</a>");
					out.println("&nbsp;&nbsp;&nbsp;<a href='" + lnk + pcnt + schargs + "'>[&gt;&gt;]</a>");
				}
			}
			%>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
