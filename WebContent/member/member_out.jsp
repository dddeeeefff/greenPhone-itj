<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_mypage.jsp"%>

<style>

.content {
	
	width:100%;
	height: 100%;
	text-align: center;
	line-height:2;
    border: 2px solid #0e9482;
    padding:70px 100px; 
    font-size:1.4em;
}

.submit_btn{
text-align:center;
width:100%;
margin-top:30px
}
.submit_btn input{
display: inline-block;
    cursor: pointer;
    font-size: 1.2em;
    font-weight:600;
    letter-spacing: -0.3pt;
    color: #fff;
    border: 2px solid #0e9482;
    padding: 0 30px;
    width: 230px;
    line-height: 76px;
    box-sizing: border-box;
    background: #0e9482;
    text-align: center;
    transition: all 0.3s ease-out;
}
.submit_btn input:hover{
background-color:#fff;  color:#0e9482;

    
}
</style>
<article class="main">
<h3 class="main_title border_none">회원 탈퇴</h3>
	<form class="frmJoin" name="frmJoin" action="member_out_proc" method="post">
		<div class="content">
		회원 탈퇴시 동일한 아이디로 재가입이 불가능 합니다.<br>
		정말로 회원을 탈퇴 하시겠습니까 ?
		</div>
		<div class="submit_btn">
			<input type="submit" value="회원 탈퇴" />
		</div>			
	</form>
</article>
</section>
</body>
</html>