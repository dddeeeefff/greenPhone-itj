<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="vo.*" %>
<%
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
boolean isLogin = false;
if (loginInfo != null)	isLogin = true;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="src/css/inc_head.css">
<script src="src/js/jquery-3.6.1.js"></script>
<script>
	//jQuery import 바로아래에 넣어 주면 됩니다.
	//Cannot read property 'msie' of undefined 에러 나올때
	jQuery.browser = {};
	(function () {
		jQuery.browser.msie = false;
		jQuery.browser.version = 0;
		if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
			jQuery.browser.msie = true;
			jQuery.browser.version = RegExp.$1;
		}
	})();

	function onlyNum(obj) {
		if (isNaN(obj.value)) {
			obj.value = "";
		}
	}
	function active() {
		document.getElementById('sub').classList.add('active');
	}
	
	function remove() {
		document.getElementById('sub').classList.remove("active");
	}
    
</script>
<!-- 
<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" /><script>
 -->
</head>
<body>
	<header class="page-header" onmouseleave="remove()">
		<div id="login-wrapper">
<% if (!isLogin) { %>
			<ul class="logout">
				<li><a href="login_form">로그인</a></li>
				<li><a href="member_form_in">회원가입</a></li>
				<li><a href="login_form?url=order_cart">장바구니</a></li>
			</ul>

<% } else { %>
			<ul class="login">
				<li><a href="logout.jsp">로그아웃</a></li>
				<li><a href="member_form_up">마이페이지</a></li>
				<li><a href="cart_view">장바구니</a></li>
			</ul>
<% } %>
		</div>
		<div class="header">
			<a class="logo" href="index"><img src="src/img/greenLogo.png" width="150" /></a>
			<ul class="menu">
				<li><a href="product_list">내 폰 사기</a></li>
				<li><a href="sell_index">내 폰 팔기</a></li>
				<li><a href="buy_chart">시세</a></li>
				<li id="board" onmouseover="active()" ><a href="notice_list">게시판</a></li>
			</ul>
		</div>
		<div id="sub" class="sub">
			<ul>
				<li>
					<a href="notice_list">공지 사항</a>
				</li>
				<li>
					<a href="faq">FAQ</a>
				</li>
				<li>
					<a href="event_list">이벤트</a>
				</li>
				<li>
					<a href="review_list">리뷰</a>
				</li>
				<li>
					<a href="free_list">자유 게시판</a>
				</li>
			</ul>
		</div>
	</header>
