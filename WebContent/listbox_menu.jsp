<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
select { width:100px; height:200px; }
</style>
<script>
var arr1 = new Array();
arr1[0] = new Option("11", " 농구화 ");	arr1[1] = new Option("12", " 축구화 ");
arr1[2] = new Option("13", " 런닝화 ");	arr1[3] = new Option("14", " 야구화 ");

var arr2 = new Array();
arr2[0] = new Option("21", " 로퍼 ");			arr2[1] = new Option("22", " 플레인 토 ");
arr2[2] = new Option("23", " 윙팀 ");			arr2[3] = new Option("24", " 더비 ");

var arr11 = new Array();
arr11[0] = new Option("111", " 농구화1 ");	arr11[1] = new Option("112", " 축구화1 ");
arr11[2] = new Option("113", " 런닝화1 ");	arr11[3] = new Option("114", " 야구화1 ");

var arr12 = new Array();
arr12[0] = new Option("121", " 농구화2 ");	arr12[1] = new Option("122", " 축구화2 ");
arr12[2] = new Option("123", " 런닝화2 ");	arr12[3] = new Option("124", " 야구화2 ");

var arr21 = new Array();
arr21[0] = new Option("211", " 로퍼1 ");		arr21[1] = new Option("212", " 플레인 토1 ");
arr21[2] = new Option("213", " 윙팀1 ");		arr21[3] = new Option("214", " 더비1 ");

var arr22 = new Array();
arr22[0] = new Option("221", " 로퍼2 ");		arr22[1] = new Option("222", " 플레인 토2 ");
arr22[2] = new Option("223", " 윙팀2 ");		arr22[3] = new Option("224", " 더비2 ");

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
</script>
</head>
<body>
<form name="frm">
<select name="c1" onchange="setCategory(this.value, this.form.c2);" size="10">
	<option value="1"> 운동화 </option>
	<option value="2"> 구두 </option>
</select>
<select name="c2" onchange="setCategory(this.value, this.form.c3);" size="10">
</select>
<select name="c3" size="10">
</select>
</form>
</body>
</html>
