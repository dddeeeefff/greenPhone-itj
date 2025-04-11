<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ProductInfo pi = (ProductInfo)request.getAttribute("pi");
// 화면에서 보여줄 상품 정보들을 저장한 ProductInfo형 인스턴스 pi를 받아옴
ProductOption po = (ProductOption)request.getAttribute("po");

// priceA : 할인율이 없을시 최종가격 / 할인율이 있을시 할인율 적용 후 가격
// priceB : 할인율이 없을시 아무것도 나오지 않음 / 할인율이 있을시 할인율 적용 전 가격
int priceA = pi.getPi_min();   // priceA = 400000;
int priceB = 0;

if (pi.getPi_dc() > 0) {      // 할인율이 있을시
   priceB = pi.getPi_min();   // 할인율 적용전 가격
   priceA = priceB * (100 - pi.getPi_dc()) / 100;   // 할인율이 적용시 가격
}
%>
<link rel="stylesheet" href="/src/css/product_view.css">

<script>
function showPic(obj) {
   var pic = document.getElementById("buyimg");
   pic.src = "/greenPhone/buy/pdt_img/" + obj;
}

function setCnt(chk) {   
   var frm = document.frm;
   var cnt = parseInt(frm.cnt.value);
   
   if (chk == "+" && cnt < 9)         frm.cnt.value = cnt + 1;
   else if (chk == "-" && cnt > 1)      frm.cnt.value = cnt - 1;
   
   $("#total").text(parseInt(frm.total.value) * frm.cnt.value);
<% if (pi.getPi_dc() > 0) { %>
   $("#totalB").text(parseInt(frm.totalB.value) * frm.cnt.value);
<% } %>
}

function buy(chk) {
   var frm = document.frm;
<% if (isLogin) { %>
   var color = frm.color.value;
   var memory = frm.memory.value;
   var rank = frm.rank.value;
   var poidx = frm.poidx.value;

   // alert("poidx : " + poidx);
   
   if (color == "" || rank == "" || memory == "" || poidx == "") {
      alert("옵션을 선택하고 '옵션 선택' 버튼을 눌러주세요.");   return;
   }
   
   if (poidx == 0) {
      alert("재고가 없습니다.");   return;
   }
   
   if (chk == "c") {   // 장바구니 담기일 경우
      var cnt = frm.cnt.value;
      $.ajax({
         type : "POST", 
         url : "/cart_proc_in",
         data : {"piid" : "<%=pi.getPi_id() %>", "poidx" : poidx, "cnt" : cnt}, 
         success : function(chkRs) {
            // alert("poidx : " + poidx +  " cnt : " + cnt);
            if (chkRs == 0) {   // 장바구니 담기에 실패했을 경우
               alert("장바구니 담기에 실패했습니다.\n다시 시도해 보세요.");
               return;
            } else {   // 장바구니 담기에 성공했을 경우
               if (confirm("장바구니에 담았습니다.\n장바구니로 이동하시겠습니까?")) {
                  location.href="cart_view";
               }
            }
         }
      });
   } else {   // 바로 구매일 경우
      frm.action = "order_form";
      frm.submit();
   }
   
<% } else { %>
   alert("로그인 후 이용 가능합니다.");
   location.href="login_form?url=/greenPhone/product_view?piid=<%=pi.getPi_id() %>";
<% } %>
}

function totalPrice() {
   var frm = document.frm;
   var cnt = frm.cnt.value;
   var color = frm.color.value;
   var memory = frm.memory.value;
   var rank = frm.rank.value;
   
   if (color == "" || rank == "" || memory == "") {
      alert("옵션을 모두 선택하세요.");   return;
   } else {
      $.ajax({
         type : "POST",
         url : "product_view_cal",
         data : { "piid" : "<%=pi.getPi_id() %>", "color" : color, "rank" : rank, "memory" : memory },
         success : function(chkRs) {      // chkRs = 16:30
            var option = chkRs.split(":");
            var poidx = option[0];
            document.frm.poidx.value = poidx;
            var inc = parseInt(option[1]);
            // alert("chkRs = " + chkRs + "poidx = " + poidx + "inc = " + inc);
            
            if (chkRs == "" || isNaN(inc)) {
               document.getElementById("totalhidden").style.display = "none";
               option = chkRs.split(":");
               poidx = option[0];
               document.frm.poidx.value = poidx;
               poidx = 0;
               alert("선택하신 상품의 재고가 없습니다.");   return;
            } else {
               document.getElementById("totalhidden").style.display = "block";
               option = chkRs.split(":");
               poidx = option[0];
               document.frm.poidx.value = poidx;
               // alert("poidx = " + poidx + ", inc = " + inc);
               inc = parseInt(option[1]);
               
   <% if (pi.getPi_dc() > 0) { %>
               var priceB = <%=priceB %> * (1 + inc / 100) * cnt;
               frm.totalB.value = priceB;
               $("#totalB").text(priceB);
               frm.totalB.value = priceB / cnt;
   <% } %>
               var priceA = <%=priceA %> * (1 + inc / 100) * cnt;
               frm.total.value = priceA;      
               $("#total").text(priceA);
               frm.total.value = priceA / cnt;
            }
         }
      })
   }
}
</script>

<form name="frm" method="post">
<div id="buypage">
   <input type="hidden" name="piid" value="<%=pi.getPi_id() %>" />
   <input type="hidden" name="poidx" value="" />
   <input type="hidden" name="kind" value="d" />
   <div id="buymenu">
      <div id="imgsrc">
         <img src="/buy/pdt_img/<%=pi.getPi_img1() %>" id="buyimg">
         <br />
         <div id=imgcl>
            <div class="bselect" onclick="showPic('<%=pi.getPi_img1() %>');"></div>&nbsp;&nbsp;
            <div class="wselect" onclick="showPic('<%=pi.getPi_img2() %>');"></div>
         </div>
      </div>
      <p>위 이미지는 등급별로 <br/>차이가 있을 수 있습니다.</p>
      <div id="btn">
         <input type="button" id="btnsz" value="장바구니에 담기" onclick="buy('c');" />
         <input type="button" id="btnsz" value="바로 구매" onclick="buy('d');" />
      </div>
   </div>
   <div id="buyoption">
      <h2><%=pi.getPi_name() %></h2>
      <hr /><br />
      <li>
         <p>가격</p>
         <p><%=pi.getPi_min() %>&nbsp;원</p>
      </li><br />
      <li>
         <p>색상</p>
         <p>
            <select name="color" id="color" >
               <option value="">색상 선택</option>
               <option value="b">블랙</option>
               <option value="w">화이트</option>
            </select>
         </p>
      </li><br />
      <li>
         <p>등급</p>
         <p>
            <select name="rank" id="rank" >
               <option value="">등급 선택</option>
               <option value="b">B</option>
               <option value="a">A</option>
               <option value="s">S</option>
            </select>
         </p>
      </li><br />
      <li>
         <p>용량</p>
         <p>
            <select name="memory" id="memory" >
               <option value="">용량 선택</option>
               <option value="128">128 GB</option>
               <option value="256">256 GB</option>
               <option value="512">512 GB</option>
            </select>
         </p>
      </li><br />
      <li>
         <p></p>
         <p>
            <input type="button" name="btncl" id="btncl" value="옵션 선택" onclick="totalPrice();" />
         </p>
      </li><br />
      <li>
         <p>수량</p>
         <p>
            <input type="button" style="width:30px;" value="-" id="btnpm" onclick="setCnt(this.value);" />&nbsp;
            <input type="text" style="width:30px;text-align:right;" name="cnt" id="cnt" value="1" readonly="readonly" />&nbsp;
            <input type="button" style="width:30px;" value="+" id="btnpm" onclick="setCnt(this.value);" />
         </p>
      </li><br />
      <hr /><br />
      <div id="totalhidden">
      <% if (pi.getPi_dc() > 0) { %>
         <li>
            <p></p>
            <p id="before">
               <input type="hidden" name="totalB" value="" />
               <span id="totalB"><%=priceB %></span>&nbsp;원      <!-- 할인율이 있을때만 적용전 가격 -->
            </p>
         </li>
      <% } %>
         <li>
            <p></p>
            <p id="after">가격&nbsp;&nbsp;&nbsp;
               <input type="hidden" name="total" value="" />
               <span id="total"><%=priceA %></span>&nbsp;원      <!-- 할인율이 0일시 그대로 적용 / 할인율이 있을시 계산되어 적용됨 -->
            </p>
         </li>
      </div>
   </div>
</div>
</form>
</body>
</html>