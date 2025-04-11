<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_mypage.jsp"%>
<%@page import="java.text.DecimalFormat"%>
<%
request.setCharacterEncoding("utf-8");
ArrayList<MemberPoint> memberPointList = (ArrayList<MemberPoint>)request.getAttribute("memberPointList");
%>

<style>
.sub {
	width: 100%;
	min-width: 1600px;
}

.mypage {
	max-width: 1200px;
	margin: 8% auto;
}

.point_get {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 20px;
}

.point_tit {
	font-size: 1.5em;
	font-weight: 600;
	border-radius: 30px;
	background: #333;
	color: #fff;
	padding: 13px 25px
}

.point_num {
	font-size: 2.4em;
	font-weight: 600;
	color: #0e9482;
	border-bottom: 4px solid #0e9482;
}

.point_list {
	width: 100%;
	display: table;
	border: 2px solid #0e9482;
	margin-top: 50px
}

.point_list .point_box {
	display: table-row;
	background: #fff;
}

.point_list .point_head {
	font-weight: 600;
	font-size: 1.2em;
	color: #fff;
	background: #0e9482
}

.point_list .text {
	display: table-cell;
	vertical-align: middle;
	text-align: Center;
	padding: 17px 0
}

.point_list .point_body:nth-child(odd) {
	background: #d6f1ed
}

.point_list .point_body .text {
	color: #333;
	font-size: 1.1em
}
</style>
<%
if (memberPointList.size() > 0) {
	DecimalFormat formatter = new DecimalFormat("###,###");
	int RetentionPoint = 0;
	for (int i = 0; i < memberPointList.size(); i++) {
		MemberPoint memberPoint = memberPointList.get(i);
		int point = memberPoint.getMp_point();
		String status = memberPoint.getMp_su();
		if (status.equals("u"))		point *= -1;
		RetentionPoint += point;
	}
%>






<article class="main">
	<div class="point_get">
		<div class="point_tit">보유 포인트</div>
		<div class="point_num"><%=formatter.format(RetentionPoint) %> P</div>
	</div>
<% } %>
	<div class="point_list">

		<div class="point_box point_head">
			<div class="text">구분</div>
			<div class="text">사유</div>
			<div class="text">변동내용</div>
			<div class="text">합계</div>
			<div class="text">상세 내역</div>
		</div>
<%
if (memberPointList.size() > 0) {
	ArrayList<MemberPoint> memberPointList_temp = new ArrayList<MemberPoint>();
	MemberPoint memberPoint_temp = null;
	DecimalFormat formatter = new DecimalFormat("###,###");
	int changePoint = 0;

	for (int i = 0; i < memberPointList.size(); i++) {

		MemberPoint memberPoint = memberPointList.get(i);
		
		String status = memberPoint.getMp_su();
		int point = memberPoint.getMp_point();
		int idx = memberPoint.getMp_idx();
		switch (status) {
			case "u":
				status = "사용";
				point = point * -1;
				break;
			case "s":
				status = "적립";
				break;
		}
		changePoint += point;
		memberPoint_temp = new MemberPoint();
		memberPoint_temp.setMp_su(status);
		memberPoint_temp.setMp_desc(memberPoint.getMp_desc());
		memberPoint_temp.setMp_point(point);
		memberPoint_temp.setMp_changePoint(changePoint);
		memberPoint_temp.setMp_detail(memberPoint.getMp_detail());
		memberPointList_temp.add(memberPoint_temp);
	}
	for (int i = 0 ; i < memberPointList_temp.size() ; i++) {
		MemberPoint memberPoint = memberPointList_temp.get(memberPointList_temp.size() - i - 1);
		
	
	
	

%>
		<div class="point_box point_body">
			<div class="text"><%=memberPoint.getMp_su() %></div>
			<div class="text"><%=memberPoint.getMp_desc() %></div>
			<div class="text"><%=formatter.format(memberPoint.getMp_point()) %></div>
			<div class="text"><%=formatter.format(memberPoint.getMp_changePoint()) %></div>
			<div class="text"><%=memberPoint.getMp_detail() %></div>
		</div>
<%
	}
} else {
out.println("<p style='text-align: center; margin-top: 30px;'>포인트 내역이 없습니다.</p>");
}
%>

	</div>
	<!--point_list end-->

</article>
</section>
</body>
</html>