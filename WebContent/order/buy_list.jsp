<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_mypage.jsp"%>
<%@page import="java.text.DecimalFormat"%>
	<link rel="stylesheet" href="src/css/buy_list.css">
<%
	request.setCharacterEncoding("utf-8");
ArrayList<SellInfo> buyList = (ArrayList<SellInfo>)request.getAttribute("buyList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage(), rcnt = pageInfo.getRcnt();
%>

<article class="main">

<h3 class="main_title border_none">구매 내역</h3>
<table width="100%" cellpadding="0" cellspacing="0" id="list">
<tr>
<th width="10%">구분</th><th width="*">주문 번호</th>
<th width="25%">제품명</th><th width="15%">가격</th>
<th width="15%">상태</th><th width="15%">날짜</th>
</tr>


<%
	if (buyList.size() > 0) {
	DecimalFormat formatter = new DecimalFormat("###,###");
	for (int i = 0; i < buyList.size(); i++) {
		SellInfo buyInfo = buyList.get(i);
		
		
		String status = buyInfo.getSi_status();
		switch (status) {
	case "a":
		status = "입금대기중";
		break;
	case "b":
		status = "배송준비중";
		break;
	case "c":
		status = "배송중";
		break;
	case "d":
		status = "배송완료";
		break;
	case "e":
		status = "구매 완료 ";
		break;
	case "f":
		status = "주문취소";
		break;
		}
		String date = (buyInfo.getSi_date()).substring(0,10);
%>
<tr aling="center">
	<td width="10%">구매</td>
	<td width="*"><a href="buy_view?siid=<%=buyInfo.getSi_id() %>"><%=buyInfo.getSi_id() %></td>
	<td width="25%"><%=buyInfo.getSd_mname() %></td>
	<td width="15%"><%=formatter.format(buyInfo.getSi_pay()) %> 원</td>
	<td width="15%"><%=status %></td>
	<td width="15%"><%=date %></td>
</tr>
<%} %>
<%
} else { %>
</table>
<%
	out.println("<p style='text-align: center;margin-top: 30px;'>구매 내역이 없습니다.</p>");
}
%>
   <br />
<table width="100%" cellpadding="5" class="page">
<tr>
<td width="80%">
<%
	String lnk = "buy_list?cpage=";
	pcnt = rcnt / psize;
	if (rcnt % psize > 0)	pcnt++;	
	
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='" + lnk + 1 + "'>[처음]</a>&nbsp;&nbsp;&nbsp;");
		out.println("<a href='" + lnk + (cpage - 1) + "'>[이전]</a>&nbsp;&nbsp;");
	}
	
	spage = (cpage - 1) / bsize * bsize + 1;
	for (int i = 1, j = spage ; i <= bsize && j <= pcnt ; i++, j++) {
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.print("&nbsp;<a href='" + lnk + j +"'>");
			out.println(j + "</a>&nbsp;");
		}
	}
	
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("&nbsp;&nbsp;<a href='" + lnk + (cpage + 1) + "'>[다음]</a>");
		out.println("&nbsp;&nbsp;&nbsp;<a href='" + lnk + pcnt + "'>[마지막]</a>");
	}
%>
</table>
</article>
</section>
</body>
</html>