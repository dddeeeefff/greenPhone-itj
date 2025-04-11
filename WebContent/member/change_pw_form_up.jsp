<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_mypage.jsp"%>
<link rel="stylesheet" href="src/css/change_pw_form.css">
<script>
function passwordCheckFunction(){
	var password1 = $("#new_pw").val();
	var password2 = $("#new_pw_check").val();
	if(password1 != password2){
		$("#pwMsg").html("<span id='fontRed'>비밀번호가 일치하지 않습니다.</span>");
	} else {
		$("#pwMsg").html("<span id='fontBlue'>비밀번호가 일치합니다.</span>");
	}
}

</script>

<article class="main">
<h3 class="main_title border_none">비밀번호 변경</h3>
	<form class="frmJoin" name="frmJoin" action="change_pw_proc" method="post">
		<div class="joinForm">
			<table width="100%" class="form_table">
				<tbody>
					<tr>
						<th width="30%" >기존 비밀번호</th>
						<td><input type="password" id="old_pw" name="old_pw" /></td>
					</tr>
					<tr>
						<th width="30%" >새로운 비밀번호</th>
						<td><input type="password" id="new_pw" name="new_pw" onkeyup="passwordCheckFunction()"/></td>
					</tr>
					<tr>
						<th width="30%" >비밀번호 확인</th>
						<td><input type="password" id="new_pw_check" name="new_pw_check" onkeyup="passwordCheckFunction()" /></td>
					</tr>
				</tbody>
			</table>
			<span id="pwMsg"></span>
		</div>

		<div class="submit_btn">
			<input type="submit" value="비밀번호 변경" />
		</div>		
	</form>
</article>
</section>
</body>
</html>