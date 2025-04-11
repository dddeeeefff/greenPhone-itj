<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_price.jsp" %>
<%
request.setCharacterEncoding("utf-8");
BbsNotice noticeDetail = (BbsNotice)request.getAttribute("noticeDetail");
String ad = "";
if (noticeDetail.getAi_idx() == 1 || noticeDetail.getAi_idx() == 2)	ad = "관리자";
%>
<style>
.bbs_content { margin:0 auto;  }
.bbs_ctr_list{ margin-top:100px; display:flex; justify-content: center; width: 100%; }
.bbs_ctr{ width: 10%;text-align: center;border: 1px solid #8a8a8a;padding:15px 0;color:#8a8a8a;margin-left:-1px; }
.bbs_ctr#ov{ background:#0e9482;color: #fff;border:1px solid #0e9482; }
.bbs_ctr#ov a { color:#fff; }
.view_content{ margin:0 auto; width:1000px; }
.n1{ padding:12px 7px; }
.go_list{ width:70px; height:40px; }
</style>
<div class="bbs_content">
	<div class = bbs_ctr_list>
		<div class="bbs_ctr" id="ov"><a href="notice_list"><strong>공지사항</strong></a></div>
		<div class="bbs_ctr"><a href="faq">FAQ</a></div>
		<div class="bbs_ctr"><a href="event_list">이벤트</a></div>
		<div class="bbs_ctr"><a href="review_list">리뷰</a></div>
		<div class="bbs_ctr"><a href="free_list">자유 게시판</a></div>
	</div>
	<br /><br />
	<div class="view_content">
		<div class="n1">글번호 : <span><%=noticeDetail.getBn_idx() %></span></div>
		<div class="n1" style="border-top:1px solid black;"><span><%=noticeDetail.getBn_title() %></span></div>
		<div class="n1" style="display:flex; justify-content: space-between; border-top:1px solid black; border-bottom:1px solid black;">
			<div>작성자 : <span><%=ad %></span></div>
			<div>등록일 : <span><%=noticeDetail.getBn_date().substring(0, 10) %></span></div>
		</div>
		<div class="n1" style="display:flex; justify-content: flex-end;">조회수 : <span>&nbsp;<%=noticeDetail.getBn_read() %></span></div>
		<div class="n1"><img src="../../greenAdmin/bbs/notice_img/<%=noticeDetail.getBn_img() %>" /></div>
		<div class="n1"><pre><%=noticeDetail.getBn_content() %></pre></div>
		<div style="display:flex; justify-content: flex-end;"><button class="go_list" onclick="location.href='/greenPhone/notice_list';">목록</button></div>
	</div>
	<div style="height:50px;"> </div>
</div>
</body>
</html>