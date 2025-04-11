<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_inc/inc_price.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<BuyChart> buyChartList = (ArrayList<BuyChart>)request.getAttribute("buyChartList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
String model = pageInfo.getKeyword();
int cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize();
int bsize = pageInfo.getBsize();
int rcnt = pageInfo.getRcnt();
int pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage();
%>
<link rel="stylesheet" href="src/css/buy_chart.css">
    <div class="page-contents">
        <div class="form-wrap">
            <form name="sch">
                <input type="text" name="model" value="<%=model %>" placeholder="모델명을 입력하세요." />
                <input type="submit" value="검색" />
            </form>
        </div>
        <div class="chart">
            <table cellpadding="5" cellspacing="0">
                <tr>
<%
if (rcnt > 0) {
%>
                    <th width="*">모델 명</th>
                    <th width="15%">용량</th>
                    <th width="15%">등급</th>
                    <th width="20%">가격</th>
                    <th width="20%">거래일</th>
                </tr>
                <tr>
<%
	for (int i = 0; i < buyChartList.size(); i++) {
		BuyChart bc = buyChartList.get(i);
		String[] options = bc.getOname().split(" / ");

%>
                    <td width="*"><%=bc.getMname() %></td>
                    <td width="15%"><%=options[0] %></td>
                    <td width="15%"><%=options[2] %></td>
                    <td width="20%"><%=String.format("%,d", bc.getPrice()) %> 원</td>
                    <td width="20%"><%=bc.getDate() %></td>
                </tr>
<%
	}
%>
			</table>
			<div class="pagination">
<%
	String lnk = "buy_chart?cpage=";
	pcnt = rcnt / psize;
	if (rcnt % psize > 0)		pcnt++;		// 전체 페이지 수(마지막 페이지 번호)
	
	if (!model.equals(""))		model = "&model=" + model;
	
	if (cpage == 1) {
		out.println("<p>[처음]</p><p>[이전]</p>");
	} else {
		out.println("<a href='" + lnk + 1 + model + "'>[처음]</a>");
		out.println("<a href='" + lnk + (cpage - 1) + model + "'>[이전]</a>");
	}
	
	spage = (cpage - 1) / bsize * bsize + 1;		// 현재 블록에서의 시작 페이지 번호
	for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
	// i : 블록에서 보여줄 페이지의 개수 만큼 루프를 돌릴 조건으로 사용되는 변수
	// j : 실제 출력할 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
		if (cpage == j)		out.println("<strong>" + j + "</strong>");
		else 				out.println("<a href='" + lnk + j + model + "'>" + j + "</a>");
	}
	
	if (cpage == pcnt) {
		out.println("<p>[다음]</p><p>[마지막]</p>");	
	} else {
		out.println("<a href='" + lnk + (cpage + 1) + model + "'>[다음]</a>");
		out.println("<a href='" + lnk + pcnt + model + "'>[마지막]</a>");
	}
	out.println("</div>");
} else {
%>
					<td colspan="5" >검색 결과가 없습니다.</td>
				</tr>
			</table>
<%
}
%>
		</div>
	</div>
</body>
</html>