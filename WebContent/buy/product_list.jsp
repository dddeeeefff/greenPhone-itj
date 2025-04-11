<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_price.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
//페이징과 검색 조건들을 저장하고 있는 PageInfo형 인스턴스 pageInfo를 request에서 받아옴
ArrayList<ProductInfo> productList = (ArrayList<ProductInfo>)request.getAttribute("productList");
ArrayList<ProductBrand> brandList = (ArrayList<ProductBrand>)request.getAttribute("brandList");

int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize();
int rcnt = pageInfo.getRcnt(), spage = pageInfo.getSpage();
int bsize = pageInfo.getBsize(), pcnt = pageInfo.getPcnt();

String args = "", sargs = "", oargs ="", vargs = "";
//쿼리 스트링으로 각각 상세보기, 검색, 정렬, 보기방식용 쿼리스트링을 저장할 변수

String sch = pageInfo.getSch(), o = pageInfo.getO(), v = pageInfo.getV();

if (sch != null && !sch.equals(""))	sargs += "&sch=" + sch;
if (o != null && !o.equals(""))		oargs += "&o=" + o;
if (v != null && !v.equals(""))		vargs += "&v=" + v;
args = "&cpage=" + cpage + sargs + oargs + vargs;
//상품 상세보기 링크용 쿼리스트링

String name = "", chkBrd = "", sp = "", ep = "";
if (sch != null && !sch.equals("")) {	// sch 검색조건이 있으면
// sch : n모델명,ba,p100000~200000
	String[] arrSch = sch.split(",");
	for (int i = 0 ; i < arrSch.length ; i++) {
		char c = arrSch[i].charAt(0);
		if (c == 'n') {	// 상품명 검색일 경우(n검색어)
			name = arrSch[i].substring(1);
		} else if (c == 'b') {	// 브랜드 검색일 경우
			chkBrd = arrSch[i].substring(1);
		} else if (c == 'p') {	// 가격대 검색일 경우(p시작가~종료가)
			sp = arrSch[i].substring(1, arrSch[i].indexOf('~'));
			ep = arrSch[i].substring(arrSch[i].indexOf('~') + 1);
		}
	}	
} else {
	sch = "";
}
%>
<link rel="stylesheet" href="src/css/product_list.css">
<script>
function makeSch() {
// 검색 조건들로 sch의 값을 만듦 : n모델명,bB1,p100000~200000
	var frm = document.frm2;
	var sch = "";
	
	// 모델명 검색어 조건
	var pdt = frm.pdt.value;
	if (pdt != "")	sch += "n" + pdt;
	
	// 브랜드 조건
	var arrBrd = document.frm3.brd;

	for (var i = 1 ; i < arrBrd.length ; i++) {
		if (arrBrd[i].checked) { // i 인덱스에 해당하는 체크박스가 선택되어 있다면
			if (sch != "")	sch += ",";
			sch += "b" + arrBrd[i].value;
		}
	}
	
	// 가격대 조건
	var sp = document.frm3.sp.value, ep = document.frm3.ep.value;
	if (sp != "" || ep != "") {	// 가격대 중 하나라도 값이 있으면
		if (sch != "")	sch += ",";
		sch += "p" + sp + "~" + ep;
	}
	
	if (pdt == "" && sp == "" && ep == "" && arrBrd.value == "") {
		alert("검색조건을 선택하세요.");	return;
	}
	
	document.frm1.sch.value = sch;
	document.frm1.submit();
}
</script>
<div class="productList">
	<table align="center">
		<tr align="right">
			<td colspan="2">
				<form name="frm1">
					<input type="hidden" name="o" value="<%=o %>" />
					<input type="hidden" name="v" value="<%=v %>" />
					<input type="hidden" name="sch" value="<%=sch %>" />			
				</form>
				<form name="frm2">
					<input type="text" name="pdt" placeholder="모델명을 입력하세요." value="" style="font-size:20px; padding: 5px 10px;" />&nbsp;&nbsp;&nbsp;
                        <input type="button" value="찾기" style="font-size:20px; padding: 5px 10px;" onclick="makeSch();" />
				</form>
			</td>
		</tr>
        <tr>
            <td width="15%" valign="top">
                <form name="frm3">
                    <div id="chkBox">
                        <div class="schBox">
                            <p class="selectBox">브랜드</p>
                            <input type="hidden" name="brd" value="" />
			<%
			for (int i = 0 ; i < brandList.size() ; i++) {
				ProductBrand pb1 = brandList.get(i);
			%>
							<input type="radio" name="brd" id="brd<%=i %>" value="<%=pb1.getPb_id() %>" <% if (chkBrd.indexOf(pb1.getPb_id()) >= 0 ) { %>checked="checked"<% } %> />
							<label for="brd<%=i %>"><%=pb1.getPb_name() %></label>
			<% } %>
						</div>
                        <div class="schBox">
                            <p class="selectBox">가격대</p>
                            <input type="text" name="sp" class="prices" placeholder="최소금액" onkeyup="onlyNum(this);" value="<%=sp %>" /> ~ 
                            <input type="text" name="ep" class="prices" placeholder="최대금액" onkeyup="onlyNum(this);" value="<%=ep %>" />
                        </div>
                    </div>
					<input type="button" value="적용하기" onclick="makeSch();" style="width:200px; font-size:20px;" />
                </form>
            </td>
			<td width="*">
			<%
			if (rcnt > 0) {	// 검색된 상품 목록이 있을 경우
				// 보기방식(목록형, 갤러리형) 이미지 지정
				String imgList = "src/img/ico_l.png";
				String imgGall = "src/img/ico_g.png";
				if (v.equals("g"))	imgGall = "src/img/ico_g_on.png";
				else				imgList = "src/img/ico_l_on.png";
				
				String lnk = "product_list?cpage=" + cpage + sargs;
				// 정렬 및 보기 방식용 공통 링크 부분
			%>
				<p align="right" id="schModel">
					<select name="o" onchange="location.href='<%=lnk %>&v=<%=v %>&o=' + this.value" style="font-size:20px; padding: 5px 10px;">
						<option value="a" <% if (o.equals("a")) { %>selected="selected"<% } %>>최신순</option>
						<option value="b" <% if (o.equals("b")) { %>selected="selected"<% } %>>판매량순</option>
						<option value="c" <% if (o.equals("c")) { %>selected="selected"<% } %>>할인율순</option>
						<option value="d" <% if (o.equals("d")) { %>selected="selected"<% } %>>낮은 가격순</option>
						<option value="e" <% if (o.equals("e")) { %>selected="selected"<% } %>>높은 가격순</option>
					</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="<%=lnk %>&o=<%=o %>&v=g"><img src="<%=imgGall %>" class="imgList" align="absmiddle" /></a>&nbsp;&nbsp;&nbsp;
					<a href="<%=lnk %>&o=<%=o %>&v=l"><img src="<%=imgList %>" class="imgList" align="absmiddle" /></a>
				</p>
				<table width="100%" cellpadding="5" cellspacing="0" style="margin:30px 30px 0 30px;">
				<%
					if (v.equals("g")) {	// 보기 방식이 갤러리형일 경우
						int i = 0;
						for (i = 0 ; i < productList.size() ; i++) {
							ProductInfo pi = productList.get(i);
							lnk = "product_view?piid=" + pi.getPi_id();
							String brand = "애플";
							if (pi.getPi_id().charAt(0) == 's')		brand = "삼성";
							
							if (pi.getStock() == 0) {
								lnk = "javascript:alert('재고가 없습니다.');";
							}
							
							String price = pi.getPi_min() + " 원 ~";
							if (pi.getPi_dc() > 0) {
								price = pi.getPi_min() * (100 - pi.getPi_dc()) / 100 + " 원 ~";
								price = "<del>" + pi.getPi_min() + "</del>&nbsp;&nbsp;&nbsp;" + price;
							}
							
							if (i % 3 == 0)	out.println("<tr>");
				%>
					<td width="33.3%" align="center" class="items-wrapper">
						<a href="<%=lnk %>">
							<img src="buy/pdt_img/<%=pi.getPi_img1() %>" class="imgBlack" border="0" />
							<p class="items">
								<%=brand %>
								<%=pi.getPi_name() %>
								<%=price %>
							</p>
						</a>
					</td>
				<%
							if (i % 3 == 2)	out.println("</tr>");
						}
						
						if (i % 3 > 0) {
							for (int j = 0 ; j < (3 - (i % 3)) ; j++)
								out.println("<td width='33.3%'></td>");
							out.println("</tr>");
						}
						
					} else {	// 보기 방식이 목록형일 경우
						for (int i = 0 ; i < productList.size() ; i++) {
							ProductInfo pi = productList.get(i);
							lnk = "product_view?piid=" + pi.getPi_id();

							String brand = "애플";
							if (pi.getPi_id().charAt(0) == 's')		brand = "삼성";
							
							if (pi.getStock() == 0) {
								lnk = "javascript:alert('재고가 없습니다.');";
							}
							
							String price = pi.getPi_min() + "원";
							if (pi.getPi_dc() > 0) {	// 할인율이 있으면
								price = pi.getPi_min() * (100 - pi.getPi_dc()) / 100 + "원";
								price = "<del>" + pi.getPi_min() + "</del><br />" + price;
							}
				%>
					<a href="<%=lnk %>">
						<tr align="center" class="items-wrapper">
							<td style="padding: 20px 14px;"><a href="<%=lnk %>"><img src="buy/pdt_img/<%=pi.getPi_img1() %>" class="imgBlack" width="100" height="100"/></a></td>
							<td width="10%" align="left">&nbsp;&nbsp;<a href="<%=lnk %>"><%=brand %></a></td>
							<td width="*" align="left">&nbsp;&nbsp;<a href="<%=lnk %>"><%=pi.getPi_name() %></a></td>
							<td><% if (pi.getPi_dc() > 0) { %><%=pi.getPi_dc() %>&nbsp;%<% } %></td>
							<td><% if (pi.getStock() > 0) { %><%=pi.getStock() %>&nbsp;개<% } %></td>
							<td><%=price %> ~</td>
						</tr>
					</a>
					<tr style="height:10px;"></tr>
				<%
						}
					}
				
					out.println("</table>");
					
					String tmp = sargs + oargs + vargs;
					// 페이징 영역 링크에서 사용할 쿼리 스트링
					
					out.println("<p align='center' style='padding: 30px 0;'>");
		
					if (cpage == 1) {
						out.println("[&lt;&lt;]&nbsp;&nbsp;[&lt;]&nbsp;");
					} else {
						out.print("<a href=\"product_list?cpage=1" + tmp + "\">");
						out.println("[&lt;&lt;]</a>&nbsp;&nbsp;");
						out.print("<a href=\"product_list?cpage=" + (cpage - 1) + tmp + "\">");
						out.println("[&lt;]</a>&nbsp;");
					}
					
					for (int i = 1, j = spage ; i < bsize && j <= pcnt ; i++, j++) {
						if (cpage == j) {
							out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
						} else {
							out.print("&nbsp;<a href=\"product_list?cpage=");
							out.println(j + tmp + "\">" + j +"</a>&nbsp;");
						}
					}
					
					if (cpage == pcnt) {
						out.println("&nbsp;[&gt;]&nbsp;&nbsp;[&gt;&gt;]");
					} else {
						out.print("&nbsp;<a href=\"product_list?cpage=" + (cpage + 1) + tmp + "\">");
						out.println("[&gt;]</a>&nbsp;&nbsp;");
						out.print("<a href=\"product_list?cpage=" + pcnt + tmp + "\">");
						out.println("[&gt;&gt;]</a>");
					}
					
					out.println("</p>");
				%>
				
			<% } else {		// 검색된 상품 목록이 없을 경우
					out.println("<p align='center'>검색 결과가 없습니다.</p>");
				}
			%>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
