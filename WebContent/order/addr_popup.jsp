<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	.title { display: flex; justify-content: center; }
	.title > h2 { text-align: center; }
	.name > input { width: 100px; }
	.phone > input { width: 100px; }
	.addr > input { width: 500px; }
	.addr > input:nth-child(1) { width: 100px; }
	.btns { display: flex; justify-content: space-evenly;  }
</style>
<body>
<div class="title">
	<h2>배송지 변경</h2>
</div>
<form name="frmPopup">
	<div>
		<div class="name">
			<label id="up_name">이름</label><br />
			* <input type="text" name="up_name" id="up_name" maxlength="20" />
		</div>
		<br />
		<div class="phone">
			<label id="up_phone">전화번호</label><br />
			* <input type="text" name="up_phone1" id="up_phone1" maxlength="3" /> -
			<input type="text" name="up_phone2" id="up_phone2" maxlength="4" /> -
			<input type="text" name="up_phone3" id="up_phone3" maxlength="4" />
		</div>
		<br />
		<div class="addr">
			<label id="up_addr">주소</label><br />
			* <input type="text" name="up_zip" id="up_zip" maxlength="5" /><br />
			* <input type="text" name="up_addr1" id="up_addr1" maxlength="50" /><br />
			* <input type="text" name="up_addr2" id="up_addr2" maxlength="50" />
		</div>
		<br />
		<div class="btns" >
			<input type="submit" value="확인" />
			<input type="button" value="닫기" name="btnClose" onclick="self.close();" />
		</div>
	</div>
</form>
</body>
</html>