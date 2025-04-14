<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_mypage.jsp"%>
	<link rel="stylesheet" href="./src/css/buy_list.css">
<%@page import="java.text.DecimalFormat"%>
<%
request.setCharacterEncoding("utf-8");
DecimalFormat formatter = new DecimalFormat("###,###");
ArrayList<SellCart> cartList = (ArrayList<SellCart>)request.getAttribute("cartList");
// 장바구니 화면에서 보여줄 상품 목록을 받아옴
%>
<script>
function onlyNum(obj) {
	if (isNaN(obj.value)) {
		obj.value = "";
	}
}

function chkAll(all) {
	var chk = document.frmCart.chk;
	for (var i = 0; i < chk.length; i++){
		chk[i].checked = all.checked;
	}
}

function getSelectedValues() {
// 체크박스 중 선택된 체크박스 값들을 쉼표로 구분하여 문자열로 리턴
	var chk = document.frmCart.chk;
	var idxs = "";	// chk 컨트롤 배열에서 선택된 체크박스의 값들을 누적 저장 변수
	for (var i = 1; i < chk.length; i++) {
		if (chk[i].checked)	idxs += "," + chk[i].value;
	}
	return idxs.substring(1);
}

function cartDel(scidx) {
// 장바구니 내 특정 상품을 삭제하는 함수
	if (confirm("정말 삭제하시겠습니까?")) {
		// cart_proc_del <-> CartProcDelCtrl
		$.ajax({
			type : "POST",
			url : "/cart_proc_del",
			data : { "scidx" : scidx },
			success : function(chkRs) {
				if (chkRs == 0){
					alert("상품 삭제에 실패했습니다.\n다시 시도하세요.");
				}
				location.reload();
			}
		});
	}
}

function cartUp(scidx, cnt) {
// 장바구니 내 수량 변경
	$.ajax({
		type : "POST",
		url : "/greenPhone/cart_proc_up",
		data : {"scidx" : scidx, "cnt" : cnt},
		success : function(chkRs) {
			if (chkRs == 0) {
				alert("상품 변경에 실패했습니다.\n다시 시도하세요.");
			}
			location.reload();
		}
	});
}

function setCnt(chk, scidx) {
// 버튼 수량 변경
	var frm = document.frmCart;
	var cnt = parseInt(eval("frm.cnt" + scidx + ".value"));
	
	if (chk == "+" && cnt < 9){
		cartUp(scidx, cnt + 1)
	} else if (chk == "-" && cnt > 1) {
		cartUp(scidx, cnt - 1);
	}
}

function chkDel() {
// 체크박스 선택 상품 삭제
	var scidx = getSelectedValues();
	if (scidx == "")	alert("삭제할 상품을 선택하세요.");
	else				cartDel(scidx);
}

function chkBuy() {
// 선택 상품 구매
	var scidx = getSelectedValues();
	if (scidx == "")		alert("구매할 상품을 선택하세요.");
	else				document.frmCart.submit();
}

function allBuy() {
// 전체 상품 구매
	var chk = document.frmCart.chk;
	var scidx = getSelectedValues();
	if (scidx == ""){
		for (var i = 0; i < chk.length; i++){
			chk[i].checked = all.checked;	
		}
	}
	document.frmCart.submit();	
}
</script>
<style>
table{ margin:0 auto; border-collapse: collapse; width:1000px;}
.tableHead, .tPrice{ border-top:1px solid #0e9482; border-bottom:1px solid #0e9482;; padding:8px; }
.tPrice, .cartButton { width:1000px; margin:0 auto; }
.cartButton{ display:flex; justify-content: space-evenly; }
.tPrice { padding: 15px 30px; }
.center img {
	width:"33%";
}
th{ padding: 10px 5px; }
td{ padding: 10px 5px; vertical-align: middle; }
.pm{ width:30px; height:30px; font-size: 22px; background: #d6f1ed; border: 1px solid #0e9482; }
.cartCnt{ width:30px; height:30px; font-size: 22px; border: 1px solid #0e9482; }
.del{ width:35px; height:25px; background: #d6f1ed; border: 1px solid #0e9482; }
.sub_btn{ width:85px; height:37px; background: #d6f1ed; border: 1px solid #0e9482; }
</style>
<article class="main">

	<form name="frmCart" action="order_form" method="post" width="700">
	<input type="hidden" name="chk" value="" />
	<input type="hidden" name="kind" value="c" />
		<table width="1000" cellpadding="8" class="topTable">
				<tr class="tableHead" align="center">
					<th width="17%"><input type="checkbox" name="all" id="all" checked="checked" onclick="chkAll(this);" /></th>
					<th width="22%">제품명</th>
					<th width="26%">옵션</th>
					<th width="16%">수량</th>
					<th width="25%">가격</th>
				</tr>
<%
if (cartList.size() > 0) {	// 장바구니에 담긴 상품이 있을 경우
	int total = 0;	// 총 구매 가격의 누적값을 저장할 변수
	for (int i = 0 ; i < cartList.size() ; i++) {
		SellCart sc = cartList.get(i);
		int scidx = sc.getSc_idx();
		
		int price = sc.getPi_min();		// 할인율, 증가율 적용시킨 가격
%>

			<!-- 장바구니에 담긴 상품 -->

			<tr align="center" height="80">
				<td width="12%">
					<input type="checkbox" name="chk" value="<%=scidx %>" checked="checked" />
					<img src="/buy/pdt_img/<%=sc.getPi_img1() %>"  height="67" style="width:33%" />
				</td>
				<td width="17%">
					<a href="product_view?piid=<%=sc.getPi_id() %>"><%=sc.getPi_name() %></a>
				</td>
				<td width="26%">
					<%=sc.getPo_name() %>
				</td>
				<td width="16%">
					<input class="pm" type="button" value="-" onclick="setCnt(this.value, <%=scidx %>);" />
					<input class="cartCnt" type="text" name="cnt<%=scidx %>" id="cnt" style="width:20px; text-align:right;" 
						value="<%=sc.getSc_cnt() %>" readonly="readonly" />
					<input class="pm" type="button" value="+" onclick="setCnt(this.value, <%=scidx %>);" />
				</td>
				<td width="25%" >
					<span style="font-size:0.9em;"><%=formatter.format(price) %>원</span>
					<input class="del" type="button" value="삭제" onclick="cartDel(<%=scidx %>);" />
				</td>
			</tr>
<%	
		total += price;
	}
%>
		</table>
		<p class="tPrice" align="right" style="font-size:1.0em; ">총&nbsp;<%=formatter.format(total) %>원</p>
		<br />
		<div class="cartButton">
			<input class="sub_btn" type="button" value="선택 삭제" onclick="chkDel();" />
			<input class="sub_btn" type="button" value="선택 상품 구매" onclick="chkBuy();" />
			<input class="sub_btn" type="button" value="전체 구매" onclick="allBuy();" />
		</div>
<%
} else {	// 장바구니에 담긴 상품이 없을 경우
	out.println("<tr><td><br /></td></tr>");
	out.println("<tr><td></td>");
	out.println("<td></td>");
	out.println("<td align='center'>장바구니에 상품이  <br />없습니다.</td>");
	out.println("<td></td>");
	out.println("<td></td></tr></table>");
}
%>
	</form>
</article>
</body>
</html>