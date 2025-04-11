package ctrl;

import java.io.*;
import java.time.LocalDate;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/sell_proc_in")
@MultipartConfig(
		fileSizeThreshold = 0,
		maxFileSize = 1024 * 1024 * 5,		// 5MB 용량 제한
		location = "/Users/chokangseok/Documents/backend/greenPhone/WebContent/sell/upload"
		//location = "../../../../webapps/greenPhone/sell/upload"
		// editor에 따라 다른 경로 말고 직접 파일이 저장될 물리적 절대 경로 지정 //	
	)
public class SellProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public SellProcInCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
    	response.setContentType("text/html; charset=utf-8"); 
    	PrintWriter out = response.getWriter();
    	
    	String piid = request.getParameter("piid");
    	String bicolor = request.getParameter("bicolor");
    	String bimemory = request.getParameter("bimemory");
    	String bidesc = request.getParameter("bidesc");
    	
    	HttpSession session = request.getSession();
    	MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
    	
    	if (loginInfo == null) {
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
    	
    	String uploadFileNameList = "";		// 업로드한 파일 이름들을 저장할 변수
    	
    	for (Part part : request.getParts()) {	// Part는 multipart/form-data로 받아온 데이터를 의미하는 클래스 // 
        	// getParts() : 사용자가 보낸 데이터(컨트롤)들을 Collection<Part>에 담아 리턴
        	// getParts()로 받아온 Part 객체들을 하나씩 Part형 인스턴스 part에 담아 루프를 돔
    		
    		if (part.getName().equals("biimg")) {
        		// part로 받아온 컨트롤의 이름이 'biimg'이면 (file 컨트롤만 작업하겠다는 의미)
        		String cd = part.getHeader("content-disposition");
        		// 예) form-data; name="file1"; filename="업로드할 파일명.확장자"
        		// file 객체가 비었으면 form-data; name="file1"; filename=""
    			
    			String uploadFileName = getUploadFileName(cd);
    			if (!uploadFileName.equals("")) {
    			// 업로드할 파일이 있으면
    				uploadFileNameList += ", " + uploadFileName;
    				part.write(uploadFileName);
    			}
        	}
    	}
    	
    	if (!uploadFileNameList.equals(""))		uploadFileNameList = uploadFileNameList.substring(2);
    	String[] fileNames = uploadFileNameList.split(", ");
    	
    	BuyInfo bi = new BuyInfo();
    	bi.setMi_id(loginInfo.getMi_id());
    	bi.setPi_id(piid);
    	bi.setBi_color(bicolor);
    	bi.setBi_memory(bimemory);
    	bi.setBi_img1(fileNames[0]);
    	bi.setBi_img2(fileNames[1]);
    	bi.setBi_img3(fileNames[2]);
    	bi.setBi_img4(fileNames[3]);
    	bi.setBi_desc(bidesc);
    	
    	SellProcInSvc sellProcInSvc = new SellProcInSvc();
    	String biid = sellProcInSvc.getNextId();
    	bi.setBi_id(biid);
    	String resultStr = sellProcInSvc.sellProcIn(bi);
    	String[] strArr = resultStr.split(",");
    	int result = Integer.parseInt(strArr[0]);
    	biid = strArr[1];
    	
    	if (result == 1) {
    		out.println("<script>");
    		out.println("alert('판매 신청이 완료되었습니다.');");
    		out.println("location.href='sell_view?biid=" + biid + "';");
    		out.println("</script>");
    		out.close();
    	} else {
    		out.println("<script>");
    		out.println("alert('신청에 실패하였습니다.\\n다시 시도하세요.');");
    		out.println("history.back();");
    		out.println("</script>");
    		out.close();
    	}
    	
	}

	private String getUploadFileName(String contentDisposition) {
		String uploadFileName = null;
    	String[] contentSplitStr = contentDisposition.split(";");
    	
    	int fIdx = contentSplitStr[2].indexOf("\"");
    	int sIdx = contentSplitStr[2].lastIndexOf("\"");
    	
    	uploadFileName = contentSplitStr[2].substring(fIdx + 1, sIdx);
    	
    	return uploadFileName;
    }
	 
}
