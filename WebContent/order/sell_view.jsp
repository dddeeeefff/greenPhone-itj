<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_mypage.jsp" %>
<% 
request.setCharacterEncoding("utf-8");
BuyInfo buyInfo = (BuyInfo)request.getAttribute("buyInfo");
String next = "";				// 승인 버튼의 동작을 위한 상태 구분자
String status = buyInfo.getBi_status();
if (status.equals("d"))				next = "e";
else if (status.equals("h"))		next = "i";
String brand = "";		// 판매 주문 번호로 구분되는 브랜드 이름
if (buyInfo.getBi_id().charAt(0) == 'a')		brand = "애플";
else											brand = "삼성";
String rank = "-";		// 판매 상태에 따른 책정 등급
if (!buyInfo.getBi_rank().equals(""))		rank = buyInfo.getBi_rank().toUpperCase();
String predict = "-";		// 1차 검수 후 예상 가격
if (buyInfo.getBi_predict() != 0)		predict = String.format("%,d", buyInfo.getBi_predict());
String fixed = "-";			// 2차 검수 후 최종 가격
if (buyInfo.getBi_pay() > 0)			fixed = String.format("%,d", buyInfo.getBi_pay());
String color = buyInfo.getBi_color();
if (color.equals("b"))		color = "블랙";
else						color = "화이트";
%>
		<link rel="stylesheet" href="src/css/sell_view.css">
		<script>
			function frmSub(status) {
			// b, e, f, i, j, k
				if (status == "f") {		// 송장 번호 입력시 배송대기 -> 배송중 상태 변경
					var frm = document.frm1;
					if (frm.biinvoice.value == "") {
						alert("송장 번호를 입력해 주세요.");
						return;
					}
					if (confirm('송장 번호를 등록하시겠습니까?')) {
						frm.action = "sell_proc_up";
						frm.method = "post";
						frm.submit();
					}
					
				} else if (status == "j") {		// 대금 수령 선택 단계에서 계좌이체로 받기 선택 후 계좌번호 입력 시 
					var frm = document.frm2;
					if (frm.bibank.value == "" || frm.biaccount.value == "") {
						alert("은행과 계좌번호를 입력해 주세요.");
						return;
					}
					if (confirm('계좌 번호를 등록하시겠습니까?')) {
						frm.action = "sell_proc_up";
						frm.method = "post";
						frm.submit();
					}
					
				} else if (status == "e") {		// 1차 검수 완료 단계에서 승인 시
					if (confirm('승인하시겠습니까?')) {
						frmSubmit(status);
					}
				} else if (status == "b") {		// 1차, 2차 검수 완료 단계에서 취소 시
					if (confirm('판매를 취소하시겠습니까?')) {
						frmSubmit(status);
					}
				} else if (status == "i") {		// 2차 검수 완료 단계에서 승인 시
					if (confirm('최종 승인하시겠습니까?')) {
						frmSubmit(status);
					}
				} else if (status == "k") {		// 대금 수령 단계에서 포인트로 받기 선택 시
					if (confirm('포인트로 받으시겠습니까?')) {
						frmSubmit(status);
					}
				}
			}
			
			function frmSubmit(status) {
				var frm = document.frm;
				frm.status.value = status;
				frm.submit();
			}
			
			function onlyNum(obj) {
				if (isNaN(obj.value)) {
					obj.value = "";
				}
			}
			
			function frmOpen() {
				$(".btns").removeClass("block");
				$(".frm2").addClass("block");
			}
			
		</script>
	    <div class="page-contents">
	        <div class="content-wrapper">
	            <h3>판매 상세 내역</h3>
	            <div class="content-info">
	                <div class="steps">
	                    <div class="step">
	                        <figure>
	                            <img src="src/img/sell_register.jpg" alt="register" />
	                        </figure>
	                        <p class="txt <% if (status.charAt(0) >= 'a' || !status.equals("b") || !status.equals("c")) { %>active-txt <% } %>">판매 신청</p>
	                    </div>
	                    <div class="step-arrow">
	                        <figure>
	                            <img src="src/img/right_arrow.png" alt="arrow" />
	                        </figure>
	                    </div>
	                    <div class="step">
	                        <figure>
	                            <img src="src/img/sell_inspect.jpg" alt="inspect1" />
	                        </figure>
	                        <p class="txt <% if (status.charAt(0) >= 'd') { %>active-txt <% } %>">1차 검수 완료</p>
	                    </div>
	                    <div class="step-arrow">
	                        <figure>
	                            <img src="src/img/right_arrow.png" alt="arrow" />
	                        </figure>
	                    </div>
	                    <div class="step">
	                        <figure>
	                            <img src="src/img/sell_ship.jpg" alt="ship" />
	                        </figure>
	                        <p <% if (status.charAt(0) >= 'e') { %>class="active-txt" <% } %>>배송 대기</p>
	                        <p <% if (status.charAt(0) >= 'f') { %>class="active-txt" <% } %>>배송중</p>
	                        <p <% if (status.charAt(0) >= 'g') { %>class="active-txt" <% } %>>상품 도착</p>
	                    </div>
	                    <div class="step-arrow">
	                        <figure>
	                            <img src="src/img/right_arrow.png" alt="arrow" />
	                        </figure>
	                    </div>
	                    <div class="step">
	                        <figure>
	                            <img src="src/img/sell_inspect.jpg" alt="inspect2" />
	                        </figure>
	                        <p class="txt <% if (status.charAt(0) >= 'h') { %>active-txt <% } %>">2차 검수 완료</p>
	                    </div>
	                    <div class="step-arrow">
	                        <figure>
	                            <img src="src/img/right_arrow.png" alt="arrow" />
	                        </figure>
	                    </div>
	                    <div class="step">
	                        <figure>
	                            <img src="src/img/sell_done.jpg" alt="done" />
	                        </figure>
	                        <p <% if (status.charAt(0) >= 'i') { %>class="active-txt" <% } %>>대금 수령 선택</p>
	                        <p <% if (status.charAt(0) >= 'j') { %>class="active-txt" <% } %>>입금 대기</p>
	                        <p <% if (status.charAt(0) >= 'k') { %>class="active-txt" <% } %>>판매 완료</p>
	                    </div>
	                </div>
	                <div class="info">
	                    <div class="imgs">
	                        <div class="img-row">
	                            <figure>
	                                <img src="sell/upload/<%=buyInfo.getBi_img1() %>" alt="img1" />
	                            </figure>
	                            <figure>
	                                <img src="sell/upload/<%=buyInfo.getBi_img2() %>" alt="img2" />
	                            </figure>
	                        </div>
	                        <div class="img-row">
	                            <figure>
	                                <img src="sell/upload/<%=buyInfo.getBi_img3() %>" alt="img3" />
	                            </figure>
	                            <figure>
	                                <img src="sell/upload/<%=buyInfo.getBi_img4() %>" alt="img4" />
	                            </figure>
	                        </div>
	                    </div>
	                    <div class="texts">
	                        <div class="text">
	                            <div class="key">
	                                <p>판매 번호</p>
	                                <p>브랜드</p>
	                                <p>모델</p>
	                                <p>색상</p>
	                                <p>용량</p>
	                                <p>등급</p>
	                            </div>
	                            <div class="value">
	                                <p><%=buyInfo.getBi_id() %></p>
	                                <p><%=brand  %></p>
	                                <p><%=buyInfo.getPi_name() %></p>
	                                <p><%=color %></p>
	                                <p><%=buyInfo.getBi_memory() %></p>
	                                <p><%=rank %></p>
	                            </div>
	                        </div>
	                        <div class="prices">
	                            <div class="price-left">
	                                <p>예상 가격</p>
	                                <p>최종 가격</p>
	                            </div>
	                            <div class="price-right">
	                                <p><%=predict %> 원</p>
	                                <p><%=fixed %> 원</p>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            <form name="frm" action="sell_proc_up" method="post">
	            	<input type="hidden" name="status" value="" />
	            	<input type="hidden" name="bipay" value="<%=buyInfo.getBi_pay() %>" />
	            	<input type="hidden" name="biid" value="<%=buyInfo.getBi_id() %>" />
<% if (status.equals("i")) { %>
					<input type="hidden" name="bioption" value="<%=buyInfo.getBi_option() %>" />
<% } %>
	            </form>
	            <div class="btns <% if (status.equals("d") || status.equals("h")) { %>block<% } %>">
	                <input type="button" value="승인" onclick="frmSub('<%=next %>');" />
	                <input type="button" value="취소" onclick="frmSub('b');"/>
	            </div>
	            <div class="form <% if (status.equals("e")) { %>block<% } %>">
	                <form name="frm1">
	            		<input type="hidden" name="biid" value="<%=buyInfo.getBi_id() %>" />
		                <input type="hidden" name="status" value="f" />
	                    <p>송장 번호 : </p>
	                    <input type="text" name="biinvoice" placeholder="송장 번호를 입력하세요." />
	                    <input type="button" value="등록" onclick="frmSub('f');" />
	                </form>
	            </div>
	            <div class="print multi <% if (status.equals("f")) { %>flex<% } %>">
	                <p>송장 번호 : 230125329418</p>
	                <p>배송중</p>
	            </div>
	            <div class="btns <% if (status.equals("i")) { %>block<% } %>">
	                <input type="button" value="포인트로 받기" onclick="frmSub('k');" />
	                <input type="button" value="계좌이체로 받기" onclick="frmOpen();" />
	            </div>
	            <div class="form frm2">
	                <form name="frm2">
	            		<input type="hidden" name="biid" value="<%=buyInfo.getBi_id() %>" />
	                    <p>-를 제외한 계좌번호를 입력하세요.</p>
	                    <div class="ctrl">
		                    <select name="bibank">
		                        <option value="">은행</option>
		                        <option value="신한">신한</option>
		                        <option value="우리">우리</option>
		                    </select>
		                    <input type="hidden" name="status" value="j" />
		                    <input type="text" name="biaccount" placeholder="계좌 번호를 입력하세요." onkeyup="onlyNum(this);" />
		                    <input type="button" value="확인" onclick="frmSub('j');" />
						</div>
	                </form>
	            </div>
	            <div class="print multi2 <% if (status.equals("j")) { %>flex<% } %>">
	                <p><%=buyInfo.getBi_bank() %></p>
	                <p><%=buyInfo.getBi_account() %></p>
	            </div>
	            <div class="print mono <% if (status.equals("k")) { %>block<% } %>">
	                <p>판매 완료</p>
	            </div>
	            <div class="reject <% if (status.equals("b")) { %>block<% } %>">
	                <p>판매가 취소되었습니다.</p>
	            </div>
	            <div class="reject <% if (status.equals("c")) { %>block<% } %>">
	                <p>판매 승인이 거절되었습니다.</p>
	            </div>
	        </div>
	    </div>
	</section>
</body>
</html>