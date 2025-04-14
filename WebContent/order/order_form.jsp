<%@page import="java.lang.reflect.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@page import="java.text.DecimalFormat"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%

int min = 1000;
int unit = 1000;
request.setCharacterEncoding("utf-8");
DecimalFormat formatter = new DecimalFormat("###,###");
ArrayList<SellCart> cartList = (ArrayList<SellCart>)request.getAttribute("cartList");
MemberInfo pointInfo = (MemberInfo)request.getAttribute("pointInfo");


if (!isLogin || cartList.size() == 0) {
// 로그인이 안되어 있거나 구매할 상품 정보가 하나도 없으면
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}
%>
<style>
body{ margin:0 5% 0 5%; font-size:15px; }
table{ border-top:1.2px solid blue; border-bottom:1px solid blue; margin:0 auto; border-collapse: collapse; z-index:9;}
td{ padding: 17px 30px; }
.addr {  margin:0 5% 0 5%; z-index:10; border-top:1px solid blue; padding: 17px 30px;}
.p1_name{ font-size:21px; }
.p1{ font-size:15px;  margin: 5px 0 5px 0; }
.p2{ font-size:15px;  margin: 1px 0 1px 0; }
.addr1 { display:flex; justify-content: space-between; }
.orderPrice { padding: 17px 30px; display:flex; justify-content: space-between; align-items: center; border-top:1px solid blue; border-bottom:1px solid blue; margin:0 auto; width:90%; }
.usePoint { border-bottom:1px solid blue; margin:0 auto; width:90%; padding: 17px 30px;}
.usePoint1 { display:flex; justify-content: space-between; }
.usePoint2 { display:flex; justify-content: flex-end; font-size:13px; padding:5px 0 0 0;}
.payment{ border-bottom:1px solid blue; margin:0 auto; width:90%; padding: 17px 30px; }
.finalPay{ margin:0 auto; width:90%; padding: 17px 30px; }
.fp{ border-bottom:1px solid #E0E0E0; display:flex; justify-content: space-between; font-size:19px; padding:10px 0;}
.order_btn{ padding:10px; font-size:25px; margin:60px; background: #d6f1ed; border: 1px solid #0e9482; }
</style>
<script src="http://code.jquery.com/jquery-3.1.1.js"></script>
<script>
function popup(){
    var url = "/greenPhone/order/order_addr_form.jsp";
    var name = "popup";
    var option = "width = 550, height = 500, top = 50%, left = 50%";
    awin = window.open(url, name, option);
}

$(document).ready(function(){
	var initUsePoint = 0;
	var initTotalPrice = parseInt(document.getElementById("total_price").innerHTML);
	var initGetPoint = initTotalPrice / 100;

	$("#uPoint").val(initUsePoint);
	$("#totalPrice").val(initTotalPrice);
	$("#sPoint").val(initGetPoint);

})


function usePoint() {
	var use = parseInt(document.frmOrder.use_pnt.value);	// 사용할 포인트값
	var cpoint = parseInt(document.getElementById("cpoint").innerHTML);	// 보유 포인트값
	var total_price = parseInt(document.getElementById("total_price").innerHTML);	// 결제 금액
	var get_point = parseInt(document.getElementById("get_point").innerHTML); // 적립 포인트
	if (use > cpoint) {
		alert("보유 포인트 이하의 값을 입력해 주세요.");
		return;
		}
	if(use < 1000 && use > 0){
		alert("1000포인트 이상 사용가능합니다.");
		return;
	} else if (use < 0){
		alert("다시 입력해 주세요.");
		return;
	}
	$("#total_point").text(use);
	$("#result_price").text(total_price - use);
	$("#get_point").text((total_price - use)/100);

	$("#uPoint").val(use);
	$("#totalPrice").val(total_price + use);
	$("#sPoint").val((total_price - use)/100);

}

function useAll() {
	var all = parseInt($("#cpoint").text());	// 보유 포인트
	var currentPrice = $("#currentPrice").val();	// 주문 가격
	if(currentPrice <= all){	// 보유 포인트가 주문가격 이상일 경우
		document.frmOrder.use_pnt.value = currentPrice;	// 주문 가격 만큼의 포인트 사용
	}else{
		document.frmOrder.use_pnt.value = all;	// 보유 포인트 모두 사용
	}

}



$(function(){
	$(document).on("change", "select[name=memoBox]", function(){
		var value = $(this).find("option:selected").val();
		var flag = true;
		if (value == "write") {
			flag = false;
			$("#simemo").text('');
			$("#simemo").attr("disabled", flag);
			value = $("#simemo").val();
		}

	});
})




function isCheck(){
	var radioChk = null;
	var radioButton = document.getElementsByName("si_payment");
	for(var i = 0; i < radioButton.length; i++){
		if(radioButton[i].checked == true)
			radioChk = radioButton[i]
	}
	if (radioChk == null) {
		alert("결제수단를 선택하세요.");
		event.preventDefault();
	}


	var memoBox = document.frmOrder.memoBox.value;
	if (memoBox == "") {
		alert("배송메모를 선택하세요.");
		event.preventDefault();
		return;

	}

}
</script>
<br /><br /><br />
<h2 style="text-align: center; font-size:40px;">상품 주문</h2>
<br /><br /><br />
<table width="90%" cellpadding="5" >
<%
int total = 0;		// 총 구매 가격의 누적치 저장 변수
String scidxs = "";	// 장바구니 인덱스 번호들을 저장할 변수
String siid = ((SellCart)cartList.get(0)).getPi_id().charAt(0) + "s";

String kind = request.getParameter("kind");
String temp = "";
if ("d".equals(kind)) {
	SellCart sc = cartList.get(0);  // 바로구매는 무조건 1개
	temp = sc.getPi_id() + "," + sc.getPo_idx() + "," + sc.getSc_cnt();
}

for (int i = 0; i < cartList.size(); i++) {
	SellCart sc = cartList.get(i);
	scidxs += "," + sc.getSc_idx();
	/*int realPrice = sc.getPi_min() * sc.getSc_cnt();
	if (sc.getPi_dc() > 0)
		realPrice = sc.getPi_min() * (100 - sc.getPi_dc()) / 100 * sc.getSc_cnt();
	*/
	int realPrice = sc.getPi_min();
%>
<tr align="left" style="border-bottom:1px solid #E0E0E0;">
	<td width="10%" style="text-align: center;"><img src="/buy/pdt_img/<%=sc.getPi_img1() %>" style="height:90; width:80%; "  /></td>
	<td>
		<p class="p1_name"><%=sc.getPi_name() %></p>
		<p class="p1"><%=sc.getPo_name() %></p>
		<p class="p1">수량&nbsp;<%=sc.getSc_cnt() %>개</p>
	</td>
	<td style="text-align: right; font-size:19px; "><%=formatter.format(realPrice) %>원</td>
</tr>
<%
	total += realPrice;
}	// 상품목록 for문
scidxs = (scidxs.indexOf(',') >= 0) ? scidxs.substring(1) : scidxs;
%>
</table>
<form name="frmOrder" action="order_proc_in" method="post">

	<% if ("d".equals(kind)) { SellCart sc = cartList.get(0); %>
	<input type="hidden" name="pi_id" value="<%= sc.getPi_id() %>" />
	<input type="hidden" name="po_idx" value="<%= sc.getPo_idx() %>" />
	<input type="hidden" name="cnt" value="<%= sc.getSc_cnt() %>" />
	<% } %>

<input type="hidden" name="total" value="<%=total %>" />
<input type="hidden" name="kind" value="<%=request.getParameter("kind") %>" />		<!-- 장바구니 or 바로구매 구분자 -->
<input type="hidden" name="scidxs" value="<%= "c".equals(kind) ? scidxs : temp %>" />

<input type="hidden" name="uPoint" id="uPoint" value="" />	<!-- 사용포인트 -->
<input type="hidden" name="totalPrice" id="totalPrice" value="" /> <!-- 결제금액 -->
<input type="hidden" name="sPoint" id="sPoint" value="" /> <!-- 적립포인트 -->

<input type="hidden" name="siid" id="siid" value="<%=siid %>" />
<div class="addr">
	<div class="addr1">
	<div>
		<h3 style="margin:3px 0; font-size:21px; margin-bottom:10px;">배송지</h3>
		<p class="p2">&nbsp;<%=loginInfo.getMi_name() %></p>
		<p class="p2">&nbsp;<%=loginInfo.getMi_phone() %></p>
		<p class="p2">&nbsp;<%=loginInfo.getMi_addr1() %></p>
		<p class="p2">&nbsp;<%=loginInfo.getMi_addr2() %></p>

	</div>
	<div>
		<input type="button" value="배송지 변경" onclick="popup();" />
	</div>
	</div>
	<div class="selectBox" style="margin-top:10px;">
	<select name="memoBox" style="width:100%; height:30px; font-size:17px;" id="memoBox">
		<option id="ro" value="">선택하세요.</option>
		<option id="ro" value="배송전에 미리 연락바랍니다.">배송전에 미리 연락바랍니다.</option>
		<option id="ro" value="부재시 경비실에 맡겨주세요.">부재시 경비실에 맡겨주세요.</option>
		<option id="ro" value="문앞에다 놓아주세요.">문앞에다 놓아주세요.</option>
		<option id="ro" value="부재시 전화하거나 문자 남겨주세요.">부재시 전화하거나 문자 남겨주세요.</option>
		<option id="write" name="write" value="write">직접입력</option>
	</select>
	</div>
	<div><textarea name="simemo" class='inputText' id="simemo" style="width:100%; height:90px; vertical-align:top;" disabled="disabled" ></textarea></div>
</div><br />
<div class="orderPrice">
	<div><h3 style="margin:3px 0; font-size:21px;">주문금액</h3></div>
	<div style="font-size:19px;" ><%=formatter.format(total) %>원</div>
</div>
<div class="usePoint">
	<div class="usePoint1">
		<div><h3 style="margin:3px 0; font-size:21px;">포인트</h3></div>
		<div style="font-size:19px;"><input style="font-size:19px; background: #d6f1ed; border: 1px solid #0e9482;" type="button" id="click_use" value="모두 사용" onclick="useAll();" />&nbsp;&nbsp;보유 : <span id="cpoint"><%=pointInfo.getMi_point() %></span>P</div>
		<input type="hidden" id="currentPrice" value="<%=total %>" />
	</div>
	<div class="usePoint2" style="font-size:19px; margin-top:20px;">
		*&nbsp;사용&nbsp;<input type="text" id="use_pnt" value="0" style="width:88%; text-align:right; font-size:19px;" />P&nbsp;<input style="font-size:19px; background: #d6f1ed; border: 1px solid #0e9482;" type="button" value="적용" onclick="usePoint();" />
	</div>
</div>
<div class="payment">
	<h3 style="margin:3px 0; font-size:21px;">결제수단</h3><br />
	<input type="radio" name="si_payment" value="a" id="payA" />
	<label for="payA" style="font-size:19px;">카드 결제</label>&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="radio" name="si_payment" value="b" id="payB" />
	<label for="payB" style="font-size:19px;">휴대폰 결제</label>&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="radio" name="si_payment" value="c" id="payC" />
	<label for="payC" style="font-size:19px;">무통장 입금</label>&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<div class="finalPay">
	<h3 style="margin:3px 0; font-size:21px;">최종 결제 금액</h3><br />
	<div class="fp">
		<div>&nbsp;상품금액</div><div><span id="total_price"><%=total %></span>원</div>
	</div>
	<div class="fp" id="u_point">
		<div>&nbsp;사용 포인트</div><div><span id="total_point">0</span>P</div>
	</div>
	<div class="fp">
		<div>&nbsp;결제금액</div><div><span id="result_price"><%=total %></span>원</div>
	</div>
	<div class="fp">
		<div>&nbsp;적립 예정 포인트(결제 금액의 1%)</div><div><span id="get_point"><%=total/100 %></span>P</div>
	</div>
</div>
<p text-align="center" style="display:flex; justify-content: center;">
	<input class="order_btn" type="submit" onclick="isCheck();" value="구매 하기" />
</p>
</form>
</body>
</html>