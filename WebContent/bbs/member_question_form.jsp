<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_mypage.jsp"%>
<style>
.main {

	font-size: 20px;
}
.sub{width:100%;min-width: 1600px;}
.mypage{max-width:1200px;margin: 0 auto;}

.write {width:100%; display:flex;  justify-content:space-between; flex-wrap:wrap;}
.write li { width:100%;  display:flex; align-items:center;  padding:11px 0; border-bottom:1px solid #ddd}
.write li:last-child {border-bottom: none;}

 
.write li  input[type="text"] {
	width: 100%;
    padding:15px 0;
    font-size: 1.2em;
    border-radius: 5px;
    text-indent: 20px;  
	border:1px solid #ddd; box-sizing:border-box; 
}

.write li  input[type="file"] {font-size:.97em; width:100%; box-sizing:border-box;  }

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
margin-top:10px

}

     .yes_btn_bg {
 line-height:43px;
 border-radius:5px;
font-size:1em; 
font-weight:600;
 background-color:#0e9482; 
 color: #fff;
 padding:5px 50px;
 border:none;
cursor: pointer; 

}
.no_btn_bg  a {
display:inline-block;
 line-height:43px;
border-radius:5px;
font-size:1em; 
font-weight:600;
 background-color:#333333;
 color: #fff;
 padding:5px 50px
}
</style>
<script>
	function chkSub() {
		var title = document.frmJoin.title.value;
		var content = document.frmJoin.content.value;
		
		if (title == '' || content == '') {
			alert('제목과 내용을 모두 입력하세요.');
			return false;
		}
		return true;
	}
</script>
<article class="main">
<h3 class="main_title">문의 하기</h3>
	<form name="frmJoin" action="member_question_proc" method="post" onsubmit="return chkSub();">
		<ul class="write">
			<li class="">
				<input type="text" id="title" name="title" value="" alt="제목" maxlength="50" placeholder="제목을 입력하세요." />
			</li>
			<li class="">
				<input type="file" name="file1" class="file1" />
			</li> 

			<li class="" >
				<textarea name="content" id="content" class="textarea1" placeholder="내용을 입력하세요."></textarea>
			</li>
		</ul>

		<div class="btn_wrap">
			<span class="no_btn_bg"><a href="#">취소</a> </span>
			<input class="yes_btn_bg" type="submit" value="문의 하기" />
		</div>
	</form>
</article>
</section>
</body>
</html>