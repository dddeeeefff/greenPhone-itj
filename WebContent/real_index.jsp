<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="_inc/inc_price.jsp" %>
	<link rel="stylesheet" href="src/css/index.css">
	<div class="page-contents">
		<div class="e-banner">
		
		</div>
		<div class="wrapper">
<%
request.setCharacterEncoding("utf-8");
ArrayList<ProductInfo> recentProductList = (ArrayList<ProductInfo>)request.getAttribute("recentProductList");
ArrayList<ProductInfo> hotProductList = (ArrayList<ProductInfo>)request.getAttribute("hotProductList");
ArrayList<ProductInfo> dcProductList = (ArrayList<ProductInfo>)request.getAttribute("dcProductList");
ArrayList<BbsReview> recentReviewList = (ArrayList<BbsReview>)request.getAttribute("recentReviewList");
%>
			<div class="title-wrapper">
				<p class="category">최신 상품</p>
				<p class="more"><a href="product_list">더 보기...</a></p>
			</div>
			<div class="content-wrapper">
				<ul>
<% for (int i = 0; i < recentProductList.size(); i++) { 
		ProductInfo productInfo = recentProductList.get(i);
		String lnk = "product_view?piid=" + productInfo.getPi_id();
		if (productInfo.getStock() == 0)		lnk = "javascript:alert('해당 상품은 현재 품절입니다.');";
%>
					<li class="item">
						<div class="hover">
							<a href="<%=lnk %>">
								<figure class="item-img">
									<img src="buy/pdt_img/<%=productInfo.getPi_img1() %>" />
								</figure>
								<p class="item-text">
									<%=productInfo.getPi_name() %>
									<%=String.format("%,d", productInfo.getPi_min()) %> ~
								</p>
							</a>
						</div>
					</li>
<% } %>
				</ul>
			</div>
		</div>
		<div class="wrapper">
			<div class="title-wrapper">
				<p class="category">인기 상품</p>
				<p class="more"><a href="product_list?o=b">더 보기...</a></p>
			</div>
			<div class="content-wrapper">
				<ul>
<% for (int i = 0; i < hotProductList.size(); i++) { 
		ProductInfo productInfo = hotProductList.get(i);
		String lnk = "product_view?piid=" + productInfo.getPi_id();
		if (productInfo.getStock() == 0)		lnk = "javascript:alert('해당 상품은 현재 품절입니다.');";
%>
					<li class="item">
						<a href="<%=lnk %>">
							<div class="hover">
								<figure class="item-img">
									<img src="buy/pdt_img/<%=productInfo.getPi_img1() %>" />
								</figure>
								<p class="item-text">
									<%=productInfo.getPi_name() %>
									<%=String.format("%,d", productInfo.getPi_min()) %> ~
								</p>
							</div>
						</a>
					</li>
<% } %>
				</ul>
			</div>
		</div>
		<div class="wrapper">
			<div class="title-wrapper">
				<p class="category">할인 상품</p>
				<p class="more"><a href="product_list?o=c">더 보기...</a></p>
			</div>
			<div class="content-wrapper">
				<ul>
<% for (int i = 0; i < dcProductList.size(); i++) { 
		ProductInfo productInfo = dcProductList.get(i);
		String lnk = "product_view?piid=" + productInfo.getPi_id();
		if (productInfo.getStock() == 0)		lnk = "javascript:alert('해당 상품은 현재 품절입니다.');";
%>
					<li class="item">
						<a href="<%=lnk %>">
							<div class="hover">
								<figure class="item-img">
									<img src="buy/pdt_img/<%=productInfo.getPi_img1() %>" />
								</figure>
								<p class="item-text">
									<%=productInfo.getPi_name() %>
									<%=productInfo.getPi_dc() %>%&nbsp;&nbsp;&nbsp;<%=String.format("%,d", productInfo.getPi_min()) %> ~
								</p>
							</div>
						</a>
					</li>
<% } %>
				</ul>
			</div>
		</div>
		<div class="wrapper">
			<div class="title-wrapper">
				<p class="category">최근 리뷰</p>
				<p class="more"><a href="review_list">더 보기...</a></p>
			</div>
			<div class="content-wrapper">
				<ul>
<% for (int i = 0; i < recentReviewList.size(); i++) { 
		BbsReview bbsReview = recentReviewList.get(i);
		String lnk = "review_view?br_idx=" + bbsReview.getBr_idx();
%>
					<li class="item">
						<a href="<%=lnk %>">
							<div class="hover">
								<figure class="item-img">
									<img src="./bbs/review_img/<%=bbsReview.getBr_img() %>" >
								</figure>
							</div>
						</a>
					</li>
<% } %>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>