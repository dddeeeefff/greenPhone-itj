<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_price.jsp"%>
<%
request.setCharacterEncoding("utf-8");
BbsFree bf = (BbsFree)request.getAttribute("bf");
ArrayList<BbsFreeReply> replyList = (ArrayList<BbsFreeReply>)request.getAttribute("replyList");
int bfidx = bf.getBf_idx();
int cpage = 1;
if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage"));
String args = "?cpage=" + cpage;		// 링크에서 사용할 쿼리 스트링
String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
}
%>
<style>
.page-contents { width: 70%; margin: 50px auto; min-width: 1000px; }
.content-wrap { width: 90%; margin: 10px auto; }
.view_title_box{display:flex;align-items: center;background-color:#eee;padding:10px;justify-content:space-between}
h3 {font-size: 26px; font-weight:600; color:#333;  box-sizing:border-box; display:inline-block; box-sizing:border-box; }

p.view_info {font-size:1rem; font-weight:400; color:#666; width:100%;  border-bottom:1px solid #ddd; padding:12px 0; display:inline-block; box-sizing:border-box; }

p.view_info a {color:#015bac !important}
p.view_info a:hover {text-decoration:underline }

div.view_content {
	width: 100%; 
	display: inline-block; 
	border-bottom: 1px solid #ddd; 
	padding: 20px 0; 
	font-size: 20px;
}

div.view_file {width:100%; padding:15px 0 10px 0;  border-bottom:1px solid #ddd; }
div.view_file ul {width:100%; display:flex; flex-wrap:wrap;}
div.view_file ul li {display:inline-block; margin-bottom:5px; }
div.view_file ul li a {display:inline-block; font-size:0.90rem; background-color:red; color:#fff; padding:10px 15px; border-radius:5px; margin-right:10px;}

div.reple {width:100%; display:flex; border-bottom:1px solid #ddd; padding:15px 10px; font-size:15.5px; color:#666;  background-color:#f9f9f9; box-sizing:border-box;}
div.reple  b {color:#333; font-weight:600; font-size:16px; width:90px}
div.reple  p {padding-left:30px;}

.answer{border:1px solid #ddd;padding:10px;margin:15px 0}
.answer span{background:#e4f5f3;padding:10px;display:inline-block;margin-top:-12px;color:#000}

.ing{border-bottom:1px solid #ddd;padding-bottom:1%}
.reply-content { display: flex; justify-content: space-between; margin-top: 10px; }
.answer_text{ padding: 1% 0; font-size: 20px; }
.answer form { display: flex; }
input[type=button] { font-size: 20px; padding: 10px 15px; margin-left: 20px; }
textarea { font-size: 20px; }
.btn_wrap{
width: 100%;
text-align: center;
margin-top:50px

}

.no_btn_bg  a {
display:inline-block;
 line-height:43px;
border-radius:5px;
font-size:1em; 
font-weight:600;
 background-color:#585858;
 color: #fff;
 padding:5px 50px
}
</style>
<script>
	function replyIn() {
	// ajax를 이용한 댓글 등록 함수
		var content = document.frmReply.content.value;
				
		if (content != "") {		
			$.ajax({
				type : "POST", 
				url : "free_reply_proc_in", 
				data : {"bfidx" : <%=bfidx %>, "content" : content}, 
				success : function(chkRs) {
					if (chkRs == 0) {
						alert("댓글 등록에 실패하였습니다.\n다시 시도해 보세요.");
					} else {
						location.reload();
					}
				}
			});
		} else {
			alert("댓글 내용을 입력하세요.");
			document.frmReply.content.focus();
		}
	}
	
	function replyDel(bfridx) {
		if (confirm("정말 삭제하시겠습니까?")) {
			location.href="free_reply_proc_del<%=args %>&bfidx=<%=bfidx %>&bfridx=" + bfridx;
		}
	}
	
	function del() {
		if (confirm("정말 삭제하시겠습니까?")) {
			location.href="free_proc_del<%=args %>&bfidx=<%=bfidx %>";
		}
	}
</script>
		<div class="page-contents">
			<div class="content-wrap">		
				<div class="view_title_box">
					<h3><%=bf.getBf_title() %></h3>
				</div>   
				<p class="view_info">
					<span class="view_data">작성자 : <%=bf.getMi_id().substring(0, 4) + "****" %></span> &nbsp; | &nbsp;
					<span class="view_data">등록일 : <%=bf.getBf_date().substring(0, 10) %></span>  
				</p>
				
				<div class="view_content">
					<p><%=bf.getBf_content() %></p>
				</div>
			
<% 
if (replyList.size() > 0) {
	for (int i = 0; i < replyList.size(); i++) {
		BbsFreeReply bfr = replyList.get(i);	
%>
				<div class="answer">
					<p class="view_info">
						<span><%=bfr.getMi_id().substring(0, 4) + "****" %></span>
					</p>
					<div class="reply-content">
						<p class="answer_text"><%=bfr.getBfr_content() %></p>
<% if (bfr.getMi_id().equals(loginInfo.getMi_id())) { %>
						<input type="button" value="댓글 삭제" onclick="replyDel(<%=bfr.getBfr_idx() %>);" />
<% } %>
					</div>
				</div>
<% 	}
} else {
%> 
				<div class="answer">
					<p align="center">댓글이 없습니다.</p>
				</div> 
<% 
}
	%>
				<div class="answer">
					<form name="frmReply" method="post" action="free_reply_proc_in">
						<input type="hidden" name="bfidx" value="<%=bf.getBf_idx() %>" />
						<textarea name="content" rows="5" cols="200"></textarea>
						<input type="button" value="댓글 등록" onclick="replyIn();" />
					</form>
				</div>
			
				<div class="btn_wrap">
<% if (bf.getMi_id().equals(loginInfo.getMi_id())) { %>
				    <span class="no_btn_bg"><a href="free_form_up<%=args %>&bfidx=<%=bfidx %>">수정</a></span>
				    <span class="no_btn_bg"><a href="javascript:del();">삭제</a></span>
<% } %>
				    <span class="no_btn_bg"><a href="free_list<%=args %>">목록</a></span>
				</div>
			</div>
		</div>
	</section>
</body>
</html>