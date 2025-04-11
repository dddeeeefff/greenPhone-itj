<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_mypage.jsp"%>
	<!-- <link rel="stylesheet" href="./src/css/member_form_up.css"> -->

<%
	String[] arrPhone = loginInfo.getMi_phone().split("-");
	String email = loginInfo.getMi_email();
	String eid = email.substring(0, email.indexOf('@'));
	String domain = email.substring(email.indexOf('@') + 1);
	String[] arrDomain = {"naver.com", "nate.com", "gmail.com"};
	String zip = loginInfo.getMi_zip();
	String addr1 = loginInfo.getMi_addr1();
	String addr2 = loginInfo.getMi_addr2();
%>
<style>

.joinForm{border-top:3px solid #0e9482;margin:20px 0 40px 0}
.joinForm .content{ display:flex;}
.joinForm .content p{padding:15px;background:#f9f9f9;width:20%;border-bottom:1px solid #ddd;font-size:1.1em;font-weight:600;text-align:center}
.joinForm .content p:last-child{background:#fff;width:80%;font-weight:500;text-align:left}
.joinForm input{
font-size: 1em;
    color: #666;
    border: 1px solid #d4d4d4;
    background-color: #fff;
    padding: 11px 5px;
    box-sizing: border-box;
}
.joinForm select{
font-size: 1em;
    color: #666;
    border: 1px solid #d4d4d4;
    background-color: #fff;
    padding: 11px 5px;
    box-sizing: border-box;
}
.submit_btn{
text-align:center;
width:100%;
}
.submit_btn input{
display: inline-block;
    cursor: pointer;
    font-size: 1.2em;
    letter-spacing: -0.3pt;
    color: #fff;
    font-weight: 600;
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
background-color:#fff;  color:#0e9482
    
}
</style>

<script>
	$(document).ready(function() {
		$("#e2").change(function() {
			if ($(this).val() == "") {
				$("#e3").val("");
			} else if ($(this).val() == "direct") {
				$("#e3").val("");
				$("#e3").focus();
			} else {
				$("#e3").val($(this).val());
			}
		});
	});
	
	function frmSubmit() {
		if (confirm(""))
	}
	
</script>
<article class="main">
	<h3 class="main_title border_none">회원정보 수정</h3>
	<form class="frmJoin" name="frmJoin" action="member_proc_up" method="post">
		<div class="joinForm">
			<div class="content">
				<p>아이디</p>
				<p><%=loginInfo.getMi_id()%></p>
			</div>
			<div class="content">
				<p>이름</p>
				<p><%=loginInfo.getMi_name()%></p>
			</div>
			<div class="content">
				<p>성별</p>
				<p><%=loginInfo.getMi_gender()%></p>
			</div>
			<div class="content">
				<p>생년월일</p>
				<p><%=loginInfo.getMi_birth()%></p>
			</div>	
			<div class="content">
				<p>휴대폰</p>
				<p>
					<select name="p1">
						<option <%if (arrPhone[0].equals("010")) {%> selected="selected"
							<%}%>>010</option>
						<option <%if (arrPhone[0].equals("011")) {%> selected="selected"
							<%}%>>011</option>
						<option <%if (arrPhone[0].equals("016")) {%> selected="selected"
							<%}%>>016</option>
						<option <%if (arrPhone[0].equals("019")) {%> selected="selected"
							<%}%>>019</option>
					</select> - 
						<input type="text" name="p2" size="4" maxlength="4" onkeyup="onlyNum(this);" value="<%=arrPhone[1]%>" /> 
						- 
						<input type="text" name="p3" size="4" maxlength="4" onkeyup="onlyNum(this);" value="<%=arrPhone[2]%>" />
								
				</p>
			</div>	
			<div class="content">
				<p>이메일</p>
				<p>
					<input type="text" name="e1" size="10" value="<%=eid%>" /> @ 
					<select name="e2" id="e2">
						<option value="">도메인 선택</option>
						<% for (int i = 0; i < arrDomain.length; i++) {	%>
						<option <% if (arrDomain[i].equals(domain)) { %>
							selected="selected" <%}%>><%=arrDomain[i]%></option>
						<% } %>
						<option value="direct">직접 입력</option>
					</select>
					<input type="text" name="e3" id="e3" size="10" value="<%=domain%>" />				
				</p>
			</div>	
			<div class="content">
				<p>주소</p>
				<p class="adr_content">
						<input type="text" name="zip" size="5" maxlength="5" value="<%=zip %>" />
						<input type="text" name="addr1" size="40" value="<%=addr1%>"/>
						<input type="text" name="addr2" size="40" value="<%=addr2%>" style="margin-top:5px"/>			
				</p>
			</div>																		
									
			
		</div>
		<div class="submit_btn">
		<input type="submit" value="정보 수정" onclick="frmSubmit();"/>
		</div>
	</form>
</article>
</section>
</body>
</html>