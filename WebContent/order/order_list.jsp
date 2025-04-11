<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_mypage.jsp"%>
<%@page import="java.text.DecimalFormat"%>
	<link rel="stylesheet" href="src/css/buy_list.css">
<%
request.setCharacterEncoding("utf-8");
ArrayList<OrderInfo> orderList = (ArrayList<OrderInfo>)request.getAttribute("orderList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage(), rcnt = pageInfo.getRcnt();
%>

<article class="main">

<h3 class="main_title border_none">거래 내역</h3>
<table width="100%" cellpadding="0" cellspacing="0" id="list">
<tr>
<th width="10%">구분</th><th width="*">주문 번호</th>
<th width="25%">제품명</th><th width="15%">가격</th>
<th width="15%">상태</th><th width="15%">날짜</th>
</tr>


<%
if (orderList.size() > 0) {
	DecimalFormat formatter = new DecimalFormat("###,###");
	for (int i = 0; i < orderList.size(); i++) {
		OrderInfo orderInfo = orderList.get(i);
		
		
		String status = orderInfo.getOi_status();
		String oi_id = orderInfo.getOi_id().substring(1,2);
		if (oi_id.equals("s")) {
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
		} else {
			switch (status) {
			case "a":
				status = "판매 신청";
				break;
			case "b":
				status = "판매 취소";
				break;
			case "c":
				status = "승인 거절";
				break;
			case "d":
				status = "1차검수 완료";
				break;
			case "e":
				status = "배송 대기";
				break;
			case "f":
				status = "배송중";
				break;
			case "g":
				status = "상품 도착";
				break;
			case "h":
				status = "2차검수 완료";
				break;
			case "i":
				status = "대금 수령 선택";
				break;
			case "j":
				status = "입금 대기";
				break;
			case "k":
				status = "판매 완료";
				break;
			}
		}
		String date = (orderInfo.getOi_date()).substring(0,10);
		String lnk = "buy_view?siid=" + orderInfo.getOi_id();
		if (orderInfo.getOi_id().charAt(1) == 'b')		lnk = "sell_view?biid=" + orderInfo.getOi_id();
%>
<tr align="center">
	<td width="10%"><%=orderInfo.getOi_kind() %></td>
	<td width="*"><a href="<%=lnk %>"><%=orderInfo.getOi_id() %></a></td>
	<td width="25%"><%=orderInfo.getOi_name() %></td>
	<td width="15%"><%=formatter.format(orderInfo.getOi_pay()) %> 원</td>
	<td width="15%"><%=status %></td>
	<td width="15%"><%=date %></td>
</tr>
<%} %>
<%
} else { %>
</table>
<%
	out.println("<p style='text-align: center; margin-top: 30px;'>판매 내역이 없습니다.</p>");
}
%>


<br />
<table width="100%" cellpadding="5" class="page">
<tr>
<td width="80%">
<%
	String lnk = "sell_list?cpage=";
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