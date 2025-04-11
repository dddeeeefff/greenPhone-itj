<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ include file="../_inc/inc_head.jsp"%>
<%
LocalDate today = LocalDate.now();	// 오늘 날짜
int cyear = today.getYear();
int cmonth = today.getMonthValue();
int cday = today.getDayOfMonth();
int last = today.lengthOfMonth();

String[] arrDomain = {"naver.com", "nate.com", "gmail.com"};
%>
<script src="src/js/date_change.js"></script>

<style>
.main {
	width:1500px;
	margin:100px auto;
}

.main_title{font-size: 3em; margin-bottom: 100px; color: #0e9482; text-align: center; }
textarea {
	width: 100%;
	height: 200px;
}

.tm50 {
	margin-top: 50px;
}

.tm80 {
	margin-top: 80px;
}

.agree {
	font-size: 1em;
}

.agree input {
	margin-right: 5px;
	width: 20px;
	height: 20px;
	vertical-align: bottom;
}

.agree input[type=checkbox] {
	accent-color: #0e9482;
}

.all {
	text-align: center;
	margin-top: 70px;
}

.joinForm {
	border-top: 3px solid #0e9482;
	margin: 20px 0 40px 0;
}

.joinForm .content {
	display: flex;
	align-items: center;
	border-bottom: 1px solid #ddd;
	background: #f9f9f9;
}

.joinForm .content p {
	padding: 15px;
	width: 20%;
	font-size: 1.1em;
	font-weight: 600;
	text-align: center;
}

.joinForm .content p:last-child {
	background: #fff;
	width: 80%;
	font-weight: 500;
	text-align: left;
}

.joinForm input[type=radio] {
	accent-color: #0e9482;
}

.joinForm input {
	font-size: 1em;
	color: #333;
	border: 1px solid #d4d4d4;
	background-color: #fff;
	padding: 11px 5px;
	box-sizing: border-box;
}

.joinForm select {
	font-size: 1em;
	color: #333;
	border: 1px solid #d4d4d4;
	background-color: #fff;
	padding: 11px 5px;
	box-sizing: border-box;
}

.submit_btn {
	text-align: center;
	width: 100%;
}

.submit_btn input {
	display: inline-block;
	cursor: pointer;
	font-size: 1.2em;
	letter-spacing: -0.3pt;
	color: #fff;
	font-weight: 600;
	border: 2px solid #333;
	padding: 0 30px;
	width: 200px;
	line-height: 76px;
	box-sizing: border-box;
	background: #333;
	text-align: center;
	transition: all 0.3s ease-out;
}

.submit_btn input:hover {
	background-color: #fff;
	color: #333;
}

.submit_btn input:last-child {
	display: inline-block;
	cursor: pointer;
	font-size: 1.2em;
	letter-spacing: -0.3pt;
	color: #fff;
	font-weight: 600;
	border: 2px solid #0e9482;
	padding: 0 30px;
	width: 200px;
	line-height: 76px;
	box-sizing: border-box;
	background: #0e9482;
	text-align: center;
	transition: all 0.3s ease-out;
	margin-left: 20px;
}

.submit_btn input:last-child:hover {
	background-color: #fff;
	color: #0e9482;
}

.must {
	color: red;
	font-size: .9em;
}

.id input {
	width: 300px;
	margin-right: 10px;
}

.id .id_ok {
	color: blue;
}

.id .id_no {
	color: red;
}

.pw input {
	width: 300px;
}

.plus {
	font-size: .8em;
	margin-top: 5px;
	display: inline-block;
}

.man {
	margin-right: 10px;
}

.man input {
	margin-right: 5px;
}

.woman input {
	margin-right: 5px;
}

.birth label {
	margin-right: 10px;
}

.adr_content input {
	margin-top: 10px;
}

.adr_content input:first-child {
	margin-top: 0px;
}
#fontBlue { font-weight: bold; color: blue; }
#fontRed { font-weight: bold; color: Red; }

</style>

<script>
$(document).ready(function() {
	$("#e2").change(function() {
		if ($(this).val() == "") {
			$("#e3").val("");
		} else if($(this).val() == "direct") {
			$("#e3").val("");
			$("#e3").focus();
		} else {
			$("#e3").val($(this).val());
		}
	});
});
function onlyNum(obj) {
	if (isNaN(obj.value)) {
		obj.value = "";
	}
}
function chkDupId(uid) {
	//ajax를 이용한 아이디 중복체크를 위한 함수
	if (uid.length >= 4) {	// 사용자가 입력한 아이디가 4자 이상이면
		$.ajax({
			type : "POST",				// 데이터 전송 방법
			url : "dupId",		// 전송한 데이터를 받을 서버의 url(컨트롤러로 서블릿 클래스를 의미)
			data : {"uid" : uid},		// 지정한 url로 보낼 데이터의 이름과 값
			success : function(chkRs) {	// 데이터를 보내 실행한 결과를 chkRs로 받아 옴
				if (chkRs == 0) {	// uid와 동일한 기존 회원의 아이디가 없으면
					$("#idMsg").html("<span id='fontBlue'>사용할 수 있는 ID 입니다.</span>");
					$("#idChk").val("y");	// 아이디 중복 체크를 성공한 상태로 변경
				} else {			// uid와 동일한 기존 회원의 아이디가 있으면
					$("#idMsg").html("<span id='fontRed'>이미 사용중인 ID 입니다.</span>");
					$("#idChk").val("n");	// 아이디 중복 체크를 성공한 상태로 변경
				}
			}
		});
	} else {				// 사용자가 입력한 아이디가 4자 미만이면
		$("#idMsg").text("아이디는 4~20자로 입력하세요.");
		$("#idChk").val("n");
		// 아이디 중복체크를 하지 않거나 실패한 상태로 변경
	}
}

function passwordCheckFunction(){
	var password1 = $("#pw").val();
	var password2 = $("#pw_chk").val();
	if(password1 != password2){
		$("#pwMsg").html("<span id='fontRed'>비밀번호가 일치하지 않습니다.</span>");
	} else {
		$("#pwMsg").html("<span id='fontBlue'>비밀번호가 일치합니다.</span>");
	}
}

function isChk() {
	if (!$('#agree1').is(':checked')) {
		alert("이용약관 동의에 체크 하셔야 회원 가입이 가능합니다.")
		return false;
	}
	if (!$('#agree2').is(':checked')) {
		alert("개인정보 보호정책 동의에 체크 하셔야 회원 가입이 가능합니다.")
		return false;
	}
	return true;
}

function chkAll(all) {
	var chk = document.frmJoin.chk;
	for (var i = 0; i < chk.length; i++) {
		chk[i].checked = all.checked;
	}
}


</script>

<article class="main">
	<h3 class="main_title border_none">회원가입</h3>
	<form class="frmJoin" name="frmJoin" action="member_proc_in" onsubmit="return isChk()" method="post">

	<textarea name="" id="">이용약관 동의</textarea>
	<label for="" class="agree"><input type="checkbox" name="chk" id="agree1">이용약관
		동의(필수) </label>

	<textarea name="" id="" class="tm50">개인정보 보호정책 동의</textarea>
	<label for="" class="agree"><input type="checkbox" name="chk" id="agree2">개인정보
		보호정책 동의(필수)</label>

	<div class="all">
		<label for="" class="agree"><input type="checkbox" name="all" id="all" onclick="chkAll(this);" >위 내용에 모두 동의합니다.</label>
	</div>

	<p class="must tm80">＊표시는 회원가입시 꼭 필요한 항목입니다.</p>
		<div class="joinForm">
			<div class="content id">
				<p>
					<span class="must">*</span> 아이디
				</p>
				<p>
	<input type="text" name="mi_id" id="mi_id" maxlength="20" onkeyup="chkDupId(this.value)" /> 
	<span id="idMsg">아이디는 4~20자로 입력하세요.</span>
					<!-- <span class="id_no">사용 불가능한 아이디 입니다.</span> -->
					<br> <span class="plus">4~12자의 영문, 숫자만 입력(ID는 가입 후 변경
						불가능 합니다.)</span>
				</p>
			</div>
			<div class="content pw">
				<p>
					<span class="must">*</span> 비밀번호
				</p>
				<p>
					<input type="password" name="mi_pw" id="pw" placeholder="사용하실 비밀번호를 입력해주세요" onkeyup="passwordCheckFunction()"><br>
					<span class="plus">(한글 입력불가, 대소문자 구별, 8~12자리 입력)</span>
				</p>

			</div>
			<div class="content pw">
				<p>
					<span class="must">*</span> 비밀번호 확인
				</p>
				<p>
					<input type="password" name="mi_pwChk" id="pw_chk" placeholder="사용하실 비밀번호를 입력해주세요" onkeyup="passwordCheckFunction()">
					<span id="pwMsg"> </span> <br>
					<span class="plus">비밀번호 확인을 위해 다시 한번 입력해주세요. </span>
					
				</p>
			</div>
			<div class="content birth">
				<p>
					<span class="must">* </span> 생년월일
				</p>
				<p>
					<label for="">	<select name="by" onchange="resetday(this.value, this.form.bm.value, this.form.bd)">
<!-- 1930년 부터 올 해까지 option 지정 -->
	<% for (int i = 1930 ; i <= cyear ; i++) { %>
	<option <% if (i==cyear) { %>selected="selected"<% } %>><%=i %></option>
	<% } %>
	</select>년
	<select name="bm" onchange="resetday(this.form.by.value, this.value, this.form.bd)">
<!-- 1월 부터 12월 까지 option 지정 -->
<%
	for (int i = 1 ; i <= 12 ; i++) {
	String bm = i + "";
	if (i < 10) bm = "0" + i;
%>
	<option <% if (i == cmonth) { %>selected="selected"<% } %>><%=bm %></option>
<% } %>
	</select>월
	<select name="bd" onchange="resetday(this.value, this.form.bm.value, this.form.bd)">
<!-- 1일 부터 31일 까지 option 지정 -->
<%
	for (int i = 1 ; i <= last ; i++) {
	String bd = i + "";
	if (i < 10) bd = "0" + i;
%>
	<option <% if (i == cday) { %>selected="selected"<% } %>><%=bd %></option>
<% } %>
	</select>일<br />
					</label>

				</p>
			</div>
			<div class="content">
				<p>
					<span class="must">*</span> 성별
				</p>
				<p>
					<label for="" class="man"><input type="radio" name="sex" value="남" checked="checked">남</label>
					<label for="" class="woman"><input type="radio" name="sex" value="여">여</label>
				</p>
			</div>
			<div class="content">
				<p>
					<span class="must">*</span> 이름
				</p>
				<p>
					<input type="text" name="mi_name" placeholder="이름을 입력하세요. ">
				</p>
			</div>


			<div class="content">
				<p>
					<span class="must">*</span> 연락처
				</p>
				<p>
					<select name="p1">
						<option selected="selected">010</option>
						<option>011</option>
						<option>016</option>
						<option>019</option>
					</select> - <input type="text" name="p2" size="4" maxlength="4"
						onkeyup="onlyNum(this);" placeholder="0000" /> - <input
						type="text" name="p3" size="4" maxlength="4"
						onkeyup="onlyNum(this);" placeholder="0000" />

				</p>
			</div>
			<div class="content">
				<p>
					<span class="must">*</span> E-mail
				</p>
				<p>
					<input type="text" name="e1" size="10" /> @ <select name="e2"
						id="e2">
						<option value="">도메인 선택</option>

						<option>naver.com</option>

						<option>nate.com</option>

						<option selected="selected">gmail.com</option>

						<option value="direct">직접 입력</option>
					</select> <input type="text" name="e3" id="e3" size="10" placeholder="직접입력" />
				</p>
			</div>
			<div class="content">
				<p>
					<span class="must">*</span> 주소
				</p>
				<p class="adr_content">
					<input type="text" name="mi_zip" size="5" maxlength="5" placeholder="우편번호" onkeyup="onlyNum(this);"/>
					<br>
					<input type="text" name="mi_addr1"	size="40" placeholder="주소 입력" />
					<br>
					<input type="text" name="mi_addr2" size="40" placeholder="상세주소 입력" />
				</p>
			</div>


		</div>
		<div class="submit_btn">
			<input type="submit" value="취소" />
			<input type="submit" value="회원가입"/>
		</div>
	</form>
</article>
</body>
</html>