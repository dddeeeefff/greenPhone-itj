<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_price.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
	ArrayList<BbsReview> reviewList = (ArrayList<BbsReview>) request.getAttribute("reviewList");
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
	int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
	int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
	int spage = pageInfo.getSpage(), rcnt = pageInfo.getRcnt();
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

.mypage {
	max-width: 1200px;
	margin: 8% auto;
}

li {
	list-style: none;
}

a:link {
	text-decoration: none;
	color: #000;
}

a:visited {
	text-decoration: none;
	color: #000;
}

a:active {
	text-decoration: none;
	color: #000;
}

.ov a strong{ color:#fff; }

.guide {
	color: #0e9482;
	margin: 70px 0 70px 0;
	font-size: 2.2em;
	font-weight: 600;
	text-align: center;
}

/*서치*/
.search {
	margin: 40px 0 60px 0;
	width: 100%;
	display: flex;
	justify-content: center;
	align-items: center
}

.search  input {
	width: 40%;
	margin: 0 10px;
	border: none;
	border-bottom: 2px solid #777;
	font-size: 1.1em;
	color: #555;
	padding: 15px 10px;
	box-sizing: border-box;
}

.search  input:focus {
	outline: none;
}

.search  select {
	font-size: 1.1em;
	color: #555;
	border: none;
	border-bottom: 2px solid #777;
	vertical-align: middle;
	width: 15%;
	padding: 15px 10px;
	box-sizing: border-box;
	font-weight: 600
}

.search a {
	font-size: 2em;
	font-weight: 500;
	margin-left: 10px;
	color: #555
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

a.basic_btn {
	text-align: center;
	display: inline-block;
	line-height: 50px;
	width: 40%;
	max-width: 200px;
	font-weight: 500;
	font-size: 1.1rem;
	margin-top: 30px;
	background-color: #004274;
	border-radius: 3px;
	color: #fff !important;
}

a.s_btn {
	text-align: center;
	display: inline-block;
	line-height: 35px;
	padding: 0 20px;
	font-weight: 500;
	font-size: 1rem;
	background-color: #fff;
	border: 1px solid #004274;
	border-radius: 3px;
	box-shadow: 2px 2px 2px #ddd;
	color: #004274 !important;
}

.review_list{display: flex;gap:66px;flex-wrap:wrap;}
.review_list li{width: 250px;}
.review_list .img{background:#eee;padding-bottom:100%;}
.review_list:first-of-type{margin-bottom:30px}
.review_list p{text-align: center;}
.review_list p:first-child{font-size:20px;font-weight:600;margin-top:10px;margin-bottom:5px}
</style>
<body>
	<div class="page-contents">
		<section class="mypage">


			<div class="tab">
				<ul>
					<li><a href="notice_list">공지사항</a></li>
					<li><a href="faq">FAQ</a></li>
					<li><a href="event_list">이벤트</a></li>
					<li class="ov"><a href="review_list"><strong>리뷰</strong></a></li>
					<li><a href="free_list">자유 게시판</a></li>
				</ul>
			</div>


			<h3 class="guide">리뷰</h3>
			<div class="search">
				<select>
					<option>제목</option>
					<option>내용</option>
				</select> <input type="text" placeholder="검색어를 입력하세요."> <a href="#"
					title=""><i class="fa-solid fa-search"></i></a>
			</div>
			
			<ul class="review_list">
<%
				if (reviewList.size() > 0) {
					for (int i = 0; i < reviewList.size(); i++) {
						BbsReview review = reviewList.get(i);
						String date = review.getBr_date().substring(0,11);
%>

				<li>
					<a href="review_view?br_idx=<%=review.getBr_idx() %>" title="">
						<img src="./bbs/review_img/<%=review.getBr_img() %>" alt="" width="100%" height="250px">
						<div>
							<p><%=review.getBr_title() %></p>
							<p><%=review.getBr_name() %></p>
							<p>작성자 : <%=review.getMi_id() %></p>
						</div>
					</a>
				</li>
<%
					}
				}
%>
			</ul>

			<table width="100%" cellpadding="5" class="page">
				<tr>
					<td width="80%">
						<%
							String lnk = "review_list?cpage=";
							pcnt = rcnt / psize;
							if (rcnt % psize > 0)
								pcnt++;

							if (cpage == 1) {
								out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
							} else {
								out.println("<a href='" + lnk + 1 + "'>[처음]</a>&nbsp;&nbsp;&nbsp;");
								out.println("<a href='" + lnk + (cpage - 1) + "'>[이전]</a>&nbsp;&nbsp;");
							}

							spage = (cpage - 1) / bsize * bsize + 1;
							for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
								if (cpage == j) {
									out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
								} else {
									out.print("&nbsp;<a href='" + lnk + j + "'>");
									out.println(j + "</a>&nbsp;");
								}
							}

							if (cpage == pcnt) {
								out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
							} else {
								out.println("&nbsp;&nbsp;<a href='" + lnk + (cpage + 1) + "'>[다음]</a>");
								out.println("&nbsp;&nbsp;&nbsp;<a href='" + lnk + pcnt + "'>[마지막]</a>");
							}
						%>
					
			</table>
		</section>
	</div>
	<script src='https://kit.fontawesome.com/77ad8525ff.js'
		crossorigin="anonymous"></script>
</body>
</html>
</section>
</div>

</body>
</html>