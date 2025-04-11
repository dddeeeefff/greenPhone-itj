<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_price.jsp" %>
<%
request.setCharacterEncoding("utf-8");
BbsReview review = (BbsReview)request.getAttribute("review");
BbsReview PrevReview = (BbsReview)request.getAttribute("PrevReview");
BbsReview NextReview = (BbsReview)request.getAttribute("NextReview");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
@font-face {
	font-family: 'Pretendard-Regular';
	src:
		url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-weight: 400;
	font-style: normal;
}

* {
	font-family: 'Pretendard-Regular';
	margin: 0;
	padding: 0
}

.sub {
	width: 100%;
	min-width: 1600px;
}

.mypage {
	max-width: 1200px;
	margin: 8% auto;
}

/*뷰페이지*/
.view_title_box {
	display: flex;
	align-items: center;
	background-color: #eee;
	padding: 10px;
	justify-content: space-between
}

p.view_title {
	font-size: 1.2rem;
	font-weight: 600;
	color: #333;
	box-sizing: border-box;
	display: inline-block;
	box-sizing: border-box;
}

.op {
	background: #0e9482;
	color: #fff;
	padding: 8px 15px;
	float: right;
	font-weight: 500;
}

p.view_info {
	font-size: 1rem;
	font-weight: 400;
	color: #666;
	width: 100%;
	border-bottom: 1px solid #ddd;
	padding: 12px 0;
	display: inline-block;
	box-sizing: border-box;
}

.other {
	display: flex;
    justify-content: space-between;
    margin: 10px 0;
}

p.view_info a {
	color: #015bac !important
}

p.view_info a:hover {
	text-decoration: underline
}
.read {
	text-align: right;
	margin: 10px 10px 10px 0;
}
div.view_content {
	width: 100%;
	display: inline-block;
	border-bottom: 1px solid #ddd;
	padding: 20px 0;
}

div.view_file {
	width: 100%;
	padding: 15px 0 10px 0;
	border-bottom: 1px solid #ddd;
}

div.view_file ul {
	width: 100%;
	display: flex;
	flex-wrap: wrap;
}

div.view_file ul li {
	display: inline-block;
	margin-bottom: 5px;
}

div.view_file ul li a {
	display: inline-block;
	font-size: 0.90rem;
	background-color: red;
	color: #fff;
	padding: 10px 15px;
	border-radius: 5px;
	margin-right: 10px;
}

div.reple {
	width: 100%;
	display: flex;
	border-bottom: 1px solid #ddd;
	padding: 15px 10px;
	font-size: 15.5px;
	color: #666;
	background-color: #f9f9f9;
	box-sizing: border-box;
}

div.reple  b {
	color: #333;
	font-weight: 600;
	font-size: 16px;
	width: 90px
}

div.reple  p {
	padding-left: 30px;
}

.answer {
	border: 1px solid #ddd;
	padding: 0 10px;
	margin: 15px 0
}

.answer span {
	background: #e4f5f3;
	padding: 10px;
	display: inline-block;
	margin-top: -12px;
	color: #000
}

.ing {
	border-bottom: 1px solid #ddd;
	padding-bottom: 1%
}

.answer_text {
	padding: 1% 0
}

.btn_wrap {
	width: 100%;
	text-align: center;
	margin-top: 50px
}

.no_btn_bg  a {
	display: inline-block;
	line-height: 43px;
	border-radius: 5px;
	font-size: 1em;
	font-weight: 600;
	background-color: #585858;
	color: #fff;
	padding: 5px 50px
}
.tab {
	margin-bottom: 70px;
}
.tab ul {
	display: flex;
	width: 100%;
}

.tab li {
	width: 20%;
	text-align: center;
	border: 1px solid #8a8a8a;
	padding: 15px 0;
	color: #8a8a8a;
	margin-left: -1px
}

.tab li.ov {
	background: #0e9482;
	color: #fff;
	border: 1px solid #0e9482
}
</style>
<body>

	<div class="page-contents">
		<section class="mypage">

			<div class="tab">
				<ul>
					<li>자유게시판</li>
					<li>FAQ</li>
					<li>이벤트</li>
					<li class="ov">리뷰</li>
					<li>자유게시판</li>
				</ul>
			</div>
			<div class="view_title_box">
				<p class="view_title">(<%=review.getBr_name() %>) <%=review.getBr_title() %></p>
			</div>
			<p class="view_info">
				<span class="view_data">작성자 : <%=review.getMi_id() %></span> &nbsp; | &nbsp;
				<span class="view_data">작성일 : <%=review.getBr_date().substring(0,11) %></span>
			</p>
			<p class="read">조회수 : <%=review.getBr_read() %></p>

			<img src="./bbs/review_img/<%=review.getBr_img() %>" alt="" style="width:250px;">
			<div class="view_content"><%=review.getBr_content() %></div>

			<div class="answer">
				<div class="other">
<%
if (PrevReview.getBr_idx() == 0) {
%>
<p>다음 글이 없습니다.</p>
<% } else { %>
					<p>다음글</p>
					<p><a href="review_view?br_idx=<%=PrevReview.getBr_idx()%>"><%=PrevReview.getBr_title() %></a></p>
					<p><%=PrevReview.getBr_date().substring(0,11) %></p>
<% } %>
				</div>
				<div class="other">
<%
if (NextReview.getBr_idx() == 0) {
%>
<p>이전 글이 없습니다.</p>
<% } else { %>
					<p>이전글</p>
					<p><a href="review_view?br_idx=<%=NextReview.getBr_idx()%>"><%=NextReview.getBr_title() %></a></p>
					<p><%=NextReview.getBr_date().substring(0,11) %></p>
<% } %>
				</div>
			</div>


			<div class="btn_wrap">
				<span class="no_btn_bg"><a href="review_list">목록</a></span>
			</div>
			</section>
			</div>
			</body>
			
</html>