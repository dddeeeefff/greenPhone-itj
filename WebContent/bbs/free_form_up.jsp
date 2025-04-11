<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_mypage.jsp"%>
<%
request.setCharacterEncoding("utf-8");
BbsFree bf = (BbsFree)request.getAttribute("bf");
int cpage = 1;
if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage"));
String schtype = request.getParameter("schtype"), keyword = request.getParameter("keyword");
if (schtype == null)		schtype = "";
if (keyword != null)		keyword = "";
%>
<style>
.main {	font-size: 20px; }
.sub{ width: 100%; min-width: 1600px; }
.mypage{ max-width: 1200px; margin: 0 auto; }

.write { width: 100%; display: flex; justify-content: space-between; flex-wrap: wrap; }
.write li { width: 100%;  display: flex; align-items: center;  padding: 11px 0; border-bottom: 1px solid #ddd; }
.write li:last-child { border-bottom: none; }

 
.write li  input[type="text"] {
	width: 100%;
    padding: 15px 0;
    font-size: 1.2em;
    border-radius: 5px;
    text-indent: 20px;  
	border: 1px solid #ddd; box-sizing: border-box; 
}

.write li  input[type="file"] { font-size: .97em; width: 100%; box-sizing: border-box;  }

.textarea1 {
    font-size: 1.2em;
    line-height: 1.4em;
    width: 100%;
    height: 200px;
    box-sizing: border-box;
    color: #666;
    border: 1px solid #ddd;
    background-color: #fff;
    padding: 15px;
}
    
.btn_wrap{
	width: 100%;
	text-align: center;
	margin-top: 10px;
}

.yes_btn_bg {
	line-height: 43px;
	border-radius: 5px;
	font-size: 1em; 
	font-weight: 600;
	background-color: #0e9482; 
	color: #fff;
	padding: 5px 50px;
	border: none;
	cursor: pointer; 
}
.no_btn_bg a {
	display: inline-block;
	line-height: 43px;
	border-radius: 5px;
	font-size: 1em; 
	font-weight: 600;
	background-color: #333;
	color: #fff;
	padding: 5px 50px;
}
</style>
<script>
	function validation(file) {
		var file_path = file.value;
		var reg = /(.*?)\.(jpg|bmp|jpeg|png)$/;
		
		// 허용되지 않은 확장자일 경우
		if (file_path != "" && (file_path.match(reg) == null || reg.test(file_path) == false)) {
			if ($.browser.msie) {		// ie 일때 
				$(this).replaceWith($(this).clone(true));
			} else {
				file.value = "";
			}		
			alert("이미지 파일만 업로드 가능합니다.");
			return;
		}
		
		// 파일의 크기가 5MB 이상일 경우
		var maxSize = 5 * 1024 * 1024;
		var fileSize = file.files[0].size;
	
		if(fileSize > maxSize){
			alert("첨부파일 사이즈는 5MB 이내로 등록 가능합니다.");
			file.value = "";
			return;
		}
	}
</script>
<article class="main">
<h3 class="main_title">게시글 수정</h3>
	<form name="frm" action="free_proc_up" method="post" enctype="multipart/form-data">
		<input type="hidden" name="cpage" value="<%=cpage %>" />
		<input type="hidden" name="schtype" value="<%=schtype %>" />
		<input type="hidden" name="keyword" value="<%=keyword %>" />
		<input type="hidden" name="bfidx" value="<%=bf.getBf_idx() %>" />
		<ul class="write">
			<li>
				<input type="text" id="title" name="title" value="<%=bf.getBf_title() %>" alt="제목" maxlength="50" placeholder="제목을 입력하세요." />
			</li>
			<li>
				<input type="file" name="bfimg" accept="image/*" onchange="validation(this);" />
			</li> 
			<li>
				<textarea name="content" class="textarea1" placeholder="내용을 입력하세요."><%=bf.getBf_content() %></textarea>
			</li>
		</ul>

		<div class="btn_wrap">
			<span class="no_btn_bg"><a href="#">취소</a> </span>
			<input class="yes_btn_bg" type="submit" value="수정 하기" />
		</div>
	</form>
</article>
</section>
</body>
</html>