package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/product_list")
public class ProductListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ProductListCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	int cpage = 1, psize = 9, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
    	// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(상품) 개수, 전체 페이지 개수, 시작 페이지 번호 등을 저장할 변수들 선언
    	if (request.getParameter("cpage") != null) 
			cpage = Integer.parseInt(request.getParameter("cpage"));
    	
    	// 검색 조건 where절 생성
		String where = "";

		String sch = request.getParameter("sch");	// 검색조건(가격대, 상품명, 브랜드)

		if (sch != null && !sch.equals("")) {
		// 검색조건 : &sch=n모델명,ba,p100000~200000
			String[] arrSch = sch.split(",");
			for (int i = 0 ; i < arrSch.length ; i++) {
				char c = arrSch[i].charAt(0);
				if (c == 'n') {			// 상품명 검색일 경우(n검색어)
					where += " and a.pi_name like '%" + arrSch[i].substring(1) + "%' ";
				} else if (c == 'b') {	// 브랜드 검색일 경우
					String arr = arrSch[i].substring(1);
					where += " and a.pb_id = '" + arr + "' ";
					
				} else if (c == 'p') {	// 가격대 검색일 경우(p시작가~종료가)
					String sp = arrSch[i].substring(1, arrSch[i].indexOf('~'));
					if(sp != null && !sp.equals("")) 
						where += " and if(a.pi_dc > 0, ceil(a.pi_min * ((100 - a.pi_dc) / 100)), a.pi_min) >= " + sp;
					
					String ep = arrSch[i].substring(arrSch[i].indexOf('~') + 1);
					if(ep != null && !ep.equals("")) 
						where += " and if(a.pi_dc > 0, ceil(a.pi_min * ((100 - a.pi_dc) / 100)), a.pi_min) <= " + ep;
				}
			}
		}
		
		String orderBy = "";
		String o = request.getParameter("o");	// 정렬 조건
		// a : 기본값으로 최신순, b : 판매량순, c: 할인율순, d : 낮은 가격순, e : 높은 가격순
		if (o == null || o.equals(""))	o = "a";
		
		switch (o) {
			case "a" : 	// 최신순
				orderBy = " order by a.pi_date desc";	break;
			case "b" : 	// 판매량순
				orderBy = " order by a.pi_sale desc";	break;
			case "c" : 	// 할인율순
				orderBy = " order by a.pi_dc desc";		break;
			case "d" : 	// 낮은 가격순
				orderBy = " order by if(a.pi_dc > 0, ceil(a.pi_min * ((100 - a.pi_dc) / 100)), a.pi_min) asc";	break;
			case "e" : 	// 높은 가격순
				orderBy = " order by if(a.pi_dc > 0, ceil(a.pi_min * ((100 - a.pi_dc) / 100)), a.pi_min) desc";	break;
		}
		
		String v = request.getParameter("v");	// 보기 방식
		if (v == null)	v = "g";
		
		ProductListSvc productListSvc = new ProductListSvc();
		
		rcnt = productListSvc.getProductCount(where);
		// 검색된 상품의 총 개수로 전체 페이지수를 구할 때 사용
		
		ArrayList<ProductInfo> productList = productListSvc.getProductList(cpage, psize, where, orderBy);
		// 검색된 상품들 중 현재 페이지에서 보여줄 상품 목록을 받아옴
		
		ArrayList<ProductBrand> brandList = productListSvc.getBrandList();
		

		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0)	pcnt++;	// 전체 페이지 수(마지막 페이지 번호)
		spage = (cpage - 1) / psize * psize + 1;	// 블록 시작 페이지 번호
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize);	pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);		pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);		pageInfo.setSpage(spage);

		pageInfo.setSch(sch);		pageInfo.setO(o);
		pageInfo.setV(v);
		// 페이징 관련 정보들과 검색 및 정렬 정보들을 PageInfo 인스턴스에 저장
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("productList", productList);
		request.setAttribute("brandList", brandList);

		// dispatcher 방식으로 view를 보여주므로 request객체에 필요한 정보를 담아 넘겨줌
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/buy/product_list.jsp");
		dispatcher.forward(request, response);
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
}
