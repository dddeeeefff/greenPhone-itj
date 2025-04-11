<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_price.jsp" %>
	<link rel="stylesheet" href="src/css/sell_index.css">
	<script>
		function toForm() {
<% if (!isLogin) { %>
			alert("로그인 후 이용 가능합니다.");
			location.href="login_form?url=sell_index";
<% } else { %>
			location.href="sell_form";
<% } %>
		}
	</script>
    <div class="page-contents">
    	<h2>내 폰 팔기</h2>
    	<div class="contents">
	        <div class="progress">
	            <h3>진행 절차</h3>
	            <div class="first">
	                <h4>1. 접수</h4>
	            </div>
	            <div class="second">
	                <h4>5. 판매 완료</h4>
	                <h4>2. 1차 검수</h4>
	            </div>
	            <div class="third">
	                <h4>4. 2차 검수</h4>
	                <h4>3. 배송</h4>
	            </div>
	        </div>
	        <p>
	            <input type="button" value="신청하기" onclick="toForm();">
	        </p>
		</div>
    </div>
</body>
</html>