<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
SellInfo si = (SellInfo)request.getAttribute("si");
%>

<style>
.frame{ margin:0 10% 0 10%; }
.oe_title { text-align:center; }
.t1{ display:flex; justify-content: center;  }
.t2{ display:flex; justify-content: center; flex-direction: column; }
.t1-1{ display:flex; flex-direction: column; width:20%;}
.t1-2, .t1-3, .t2-2, .t2-3{ border:1px solid #000; vertical-align: middle;}
.t1-2{ height:40px; display:flex; align-items: center}
.t1-3{ height:100px; display:flex; align-items: center; }
.t2-1{ display:flex; justify-content: center;}
.t2-2{ width:14%; height:40px; }
.t2-3{ width:46%; height:40px; }
.btn-b{ width:100px; height:60px; }
.btn{ display: flex; justify-content: center; }
</style>
<div class="frame">
<div class="oe_title"><h2>결제 완료</h2></div><br />
<hr />
<br />
<br />
<div class="oe_title"><h2>주문이 완료되었습니다.</h2></div><br /><br />
	<div class="t1">
		<div class="t1-1">
			<div class="t1-2">총  금액</div>
			<div class="t1-3"><span><%=si.getSi_pay() + si.getSi_upoint() %></span>원</div>
		</div>
		<div class="t1-1">
			<div class="t1-2">포인트 할인</div>
			<div class="t1-3">-<span><%=si.getSi_upoint() %></span>원</div>
		</div>
		<div class="t1-1">
			<div class="t1-2">최종 결제 금액</div>
			<div class="t1-3"><span><%=si.getSi_pay() %></span>원</div>
		</div>
	</div>
	<br />
	<h3 style="padding:0 20%; text-align:center;">결제정보</h3>
	<div class="t2">
	<br />
<%
String payment = "카드결제";
String account = "";
if (si.getSi_payment().equals("b"))		payment = "휴대폰결제";
else if(si.getSi_payment().equals("c"))	{payment = "무통장입금"; account = "신한은행 / 123-12345-1234-12 (예금주 : 그린폰계좌1)";}
else if(si.getSi_payment().equals("d"))	payment = "포인트결제";




%>
		<div class="t2-1">
			<div class="t2-2">결제수단</div>
			<div class="t2-3"><span><%=payment %></span></div>
		</div>
		<div class="t2-1">
			<div class="t2-2">입금계좌</div>
			<div class="t2-3"><span><%=account %></span></div>
		</div>
		<div class="t2-1">
			<div class="t2-2">입금액</div>
			<div class="t2-3"><span><%=si.getSi_pay() %></span>원</div>
		</div>
	</div>
	<br />
	<h3 style="padding:0 20%; text-align:center;">적립예정포인트</h3>
	<br />
	<div class="t2">
		<div class="t2-1">
			<div class="t2-2">적립포인트</div>
			<div class="t2-3"><span><%=si.getSi_pay() / 100 %></span>P</div>
		</div>
	<br />
	<div class="btn">
		
		<input type="button" class="btn-b" value="주문내역보기" onclick="location.href='buy_list'" />&nbsp;&nbsp;&nbsp;
		<input type="button" class="btn-b" value="메인으로" onclick="location.href='/index';" />
	</div>
	</div>
</div>
</body>
</html>