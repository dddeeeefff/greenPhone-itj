<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="vo.*" %>
<%
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
boolean isLogin = false;
if (loginInfo != null)	isLogin = true;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>

</style>
<script>

</script>
<body>
<div style="display:flex; justify-content:center;">
	<h2 text-align="center">배송지 변경</h2>
</div>
<form name="frmPopup" action="order_form" method="post">
<input type="hidden" name="def" value="y" />
	<div class="frame">
		<div>
			<label id="up_name">이름</label><br />
			* <input type="text" name="up_name" id="up_name" maxlength="20" style="width:100px" />
		</div>
		<br />
		<div>
			<label id="up_phone">전화번호</label><br />
			* <input type="text" name="up_phone1" id="up_phone1" maxlength="3" style="width:100px" /> -
			<input type="text" name="up_phone2" id="up_phone2" maxlength="4" style="width:100px" /> -
			<input type="text" name="up_phone3" id="up_phone3" maxlength="4" style="width:100px" />
		</div>
		<br />
		<div>
			<label id="up_addr">주소</label><br />
			* <input type="text" name="up_zip" id="up_zip" maxlength="5" style="width:100px" /><br />
			* <input type="text" name="up_addr1" id="up_addr1" maxlength="50" style="width:500px" /><br />
			* <input type="text" name="up_addr2" id="up_addr2" maxlength="50" style="width:500px" />
		</div>
		<div>
			<input type="checkbox" name="up_mi" id="up_mi"> 기본배송지로 등록
		</div>
		<br />
		<div style="display:flex; justify-content:center; justify-content: space-evenly;">
			<input type="submit" value="확인" />
			<input type="button" value="닫기" name="btnClose" onclick="self.close();" />
		</div>
	</div>
</form>
</body>
</html>