<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
.price_pop option:checked {background:#0e9482;color:#fff}
.price_tit{display:flex}
.price_tit p{width:400px;text-align:center;padding:20px;font-size:33px;font-weight:600}
</style>
<head>
<script src="../src/js/jquery-3.6.1.js"></script>
<meta charset="UTF-8">
<link rel="stylesheet" href="../src/css/price_pop.css">
<script>
var arr1 = new Array();
arr1[0] = new Option("11", " S23시리즈 ");	arr1[1] = new Option("12", " S22시리즈 ");
arr1[2] = new Option("13", " S21시리즈 ");	arr1[3] = new Option("14", " S20시리즈 ");


var arr11 = new Array();
arr11[0] = new Option("s2303", " 갤럭시 S23 Ultra ");	arr11[1] = new Option("s2302", " 갤럭시 S23 Plus ");
arr11[2] = new Option("s2301", " 갤럭시 S23 ");

var arr12 = new Array();
arr12[0] = new Option("s2203", " 갤럭시 S22 Ultra ");	arr12[1] = new Option("s2202", " 갤럭시 S22 Plus ");
arr12[2] = new Option("s2201", " 갤럭시 S22 ");

var arr13 = new Array();
arr13[0] = new Option("s2103", " 갤럭시 S21 Ultra ");	arr13[1] = new Option("s2202", " 갤럭시 S21 Plus ");
arr13[2] = new Option("s2101", " 갤럭시 S21 ");

var arr14 = new Array();
arr14[0] = new Option("s2003", " 갤럭시 S20 Ultra ");	arr14[1] = new Option("s2102", " 갤럭시 S20 Plus ");
arr14[2] = new Option("s2001", " 갤럭시 S20 ");


var arr2 = new Array();
arr2[0] = new Option("21", " 14 시리즈 ");			arr2[1] = new Option("22", " 13 시리즈 ");
arr2[2] = new Option("23", " 12 시리즈 ");			arr2[3] = new Option("24", " 11 시리즈 ");

var arr21 = new Array();
arr21[0] = new Option("a1403", " 아이폰 14 Pro Max ");		arr21[1] = new Option("a1402", " 아이폰 14 Pro ");
arr21[2] = new Option("a1401", " 아이폰 14 ");

var arr22 = new Array();
arr22[0] = new Option("a1303", " 아이폰 13 Pro Max ");		arr22[1] = new Option("a1302", " 아이폰 13 Pro ");
arr22[2] = new Option("a1301", " 아이폰 13 ");

var arr23 = new Array();
arr23[0] = new Option("a1203", " 아이폰 12 Pro Max ");		arr23[1] = new Option("a1202", " 아이폰 12 Pro ");
arr23[2] = new Option("a1201", " 아이폰 12 ");

var arr24 = new Array();
arr24[0] = new Option("a1103", " 아이폰 11 Pro Max ");		arr24[1] = new Option("a1102", " 아이폰 11 Pro ");
arr24[2] = new Option("a1101", " 아이폰 11 ");


function setCategory(x, target) {
	for (var i = target.options.length - 1 ; i > 0 ; i--) {
		target.options[i] = null;
	}

	if (x != "") {
		var arr = eval("arr" + x);

		for (var i = 0 ; i < arr.length ; i++) {
			target.options[i] = new Option(arr[i].value, arr[i].text);
		}
	}
}

function price(model) {
	$.ajax({
		type : "GET", 
		url : "../model_price", 
		data : {"model" : model}, 
		success : function(chkRs) {
			const price = chkRs.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			$(".price").text("최대 구매 가격 : " + price + "원");
			
		}
		
	});
}
</script>
</head>
<body class="price_pop">
<div class="price_tit" >
<p>브랜드명</p>
<p>시리즈명</p>
<p>모델명</p>
</div>
<form name="frm">
<select class="select" name="c1" onchange="setCategory(this.value, this.form.c2);" size="5">
	<option value="1"> 삼성 </option>
	<option value="2"> 애플 </option>
</select>
<select class="select" name="c2" onchange="setCategory(this.value, this.form.c3);" size="5">
</select>
<select class="select" name="c3" size="5" onchange="price(this.value)">
</select>

</form>
<p class="price"></p>
</body>
</html>
