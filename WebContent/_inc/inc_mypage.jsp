<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<link rel="stylesheet" href="src/css/inc_mypage.css">
<section>
	<article class="mypage">
		<h2>마이 페이지</h2>
		<ul>
			<li>
				<a href="member_form_up">정보 수정</a>
				<ul class="mypage_sub">
					<li><a href="change_pw_form"> - 비밀번호 변경</a></li>
					<li><a href="member_out"> - 회원 탈퇴</a></li>
				</ul>
			</li>
			
			<li>
				<a href="order_list">거래 현황</a>
				<ul class="mypage_sub">
					<li><a href="buy_list"> - 구매 내역</a></li>
					<li><a href="sell_list"> - 판매 내역</a></li>
				</ul>
			</li>
			
			<li><a href="point_list">포인트 내역</a></li>
			<li><a href="cart_view">장바구니</a></li>
			<li><a href="member_question_list">1:1 문의</a></li>
		</ul>
	</article>