<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_price.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<ProductBrand> brandList = (ArrayList<ProductBrand>)request.getAttribute("brandList");
ArrayList<ProductSeries> seriesList = (ArrayList<ProductSeries>)request.getAttribute("seriesList");
ArrayList<ProductInfo> productList = (ArrayList<ProductInfo>)request.getAttribute("productList");
%>
<script>
<% 
for (int i = 0; i < brandList.size(); i++) {
	ProductBrand pb = brandList.get(i);
	String arr = "arr" + pb.getPb_id();
%>
	var <%=arr %> = new Array();
	<%=arr %>[0] = new Option("", " 시리즈를 선택하세요. ");
<%
		for (int j = 0, k = 1; j < seriesList.size(); j++, k++) {
			ProductSeries ps = seriesList.get(j);
			if (ps.getPb_id().equals(pb.getPb_id())) {
%>
	<%=arr %>[<%=k %>] = new Option("<%=ps.getPs_id() %>", " <%=ps.getPs_name() %> ");
<%
			} else {
				k = 0;
			}
		} 
} 

for (int i = 0; i < seriesList.size(); i++) {
	ProductSeries ps = seriesList.get(i);
	String arr = "arr" + ps.getPs_id();
%>
	var <%=arr %> = new Array();
	<%=arr %>[0] = new Option("", " 모델 명을 선택하세요. ");
<%
		for (int j = 0, k = 1; j < productList.size(); j++, k++) {
			ProductInfo pi = productList.get(j);
			if (pi.getPs_id().equals(ps.getPs_id())) {
%>
	<%=arr %>[<%=k %>] = new Option("<%=pi.getPi_id() %>", "<%=pi.getPi_name() %> ");
<%
			} else {
				k = 0;
			}
		}
%>
<%
}
%>
	function setCategory(x, target) {
	// x : 브랜드/시리즈에서 선택한 값 / target : 선택한 브랜드/시리즈에 따라 보여줄 시리즈/모델명 콤보박스 객체
		// 1. 원래 하위 콤보박스에 있던 데이터(option 태그)들을 모두 삭제
		for (var i = target.options.length - 1 ; i > 0 ; i--) {
			target.options[i] = null;
		}

		// 2. 선택한 상위 분류에 속하는 하위 분류 데이터를 하위 분류 콤보박스에 넣음
		if (x != "") {	// 특정 상위 분류를 선택했으면
			var arr = eval("arr" + x);
			// 상위 분류에서 선택한 값에 따라 사용할 배열을 지정 : 하위 분류 콤보박스에서 보열줄 option 태그들

			for (var i = 0 ; i < arr.length ; i++) {
				target.options[i] = new Option(arr[i].value, arr[i].text);
				// 지정한 arr배열 만큼 target에 option요소 추가
			}

			target.options[0].selected = true;
			// target의 0번 인덱스에 해당하는 option태그를 선택한 상태로 만듦
		}
	}
	
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
	
	function sellSubmit() {
		var frm = document.frmSell;
		var pbid = frm.pbid.value;
		var psid = frm.psid.value;
		var piid = frm.piid.value;
		var bicolor = frm.bicolor.value;
		var bimemory = frm.bimemory.value;
		var biimg = frm.biimg;
		
		for (var i = 0; i < biimg.length; i++) {
			if (biimg[i].value == "" || pbid == "" || psid == "" || piid == "" || bicolor == "" || bimemory == "") {
				alert("모든 항목을 선택하여 주세요.");
				return;
			}
		}
		
		frm.action = "sell_proc_in";
		frm.method = "post";
		frm.submit();
			
	}

</script>
<link rel="stylesheet" href="src/css/sell_form.css">
	<div class="page-contents">
		<div class="template">
			<h3>등급 책정 기준</h3>
			<div class="img-wrapper">
				<p>1. S 등급</p>
				<figure>
					<img src="sell/img/s1.png" alt="s1" />
				</figure>
				<figure>
					<img src="sell/img/s2.png" alt="s2" />
				</figure>
				<figure>
					<img src="sell/img/s3.png" alt="s3" />
				</figure>
				<figure>
					<img src="sell/img/s4.png" alt="s4" />
				</figure>
			</div>
			<div class="img-wrapper">
				<p>2. A 등급</p>
				<figure>
					<img src="sell/img/a1.png" alt="a1" />
				</figure>
				<figure>
					<img src="sell/img/a2.png" alt="a2" />
				</figure>
				<figure>
					<img src="sell/img/a3.png" alt="a3" />
				</figure>
				<figure>
					<img src="sell/img/a4.png" alt="a4" />
				</figure>
			</div>
			<div class="img-wrapper">
				<p>3. B 등급</p>
				<figure>
					<img src="sell/img/b1.png" alt="b1" />
				</figure>
				<figure>
					<img src="sell/img/b2.png" alt="b2" />
				</figure>
				<figure>
					<img src="sell/img/b3.png" alt="b3" />
				</figure>
				<figure>
					<img src="sell/img/b4.png" alt="b4" />
				</figure>
			</div>
		</div>
		<div class="frm-wrapper">
            <h3>판매 신청</h3>
            <div class="sell-frm">
                <form name="frmSell" enctype="multipart/form-data">
                    <div class="frmbox">
                        <div class="frm-row">
                            <p>상품 정보</p>
                            <div class="boxin">
                                <div class="col">
                                    <p>브랜드</p>
                                    <select name="pbid" onchange="setCategory(this.value, this.form.psid);">
                                    	<option value="">브랜드를 선택하세요.</option>
                                        <option value="a" >애플</option>
                                        <option value="s" >삼성</option>
                                    </select>
                                </div>
                                <div class="col">
                                    <p>시리즈</p>
                                    <select name="psid" onchange="setCategory(this.value, this.form.piid);">
                                    	<option value="">시리즈를 선택하세요.</option>
                                    </select>
                                </div>
                                <div class="col">
                                    <p>모델 명</p>
                                    <select name="piid">
                                    	<option value="">모델 명을 선택하세요.</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="frm-row">
                            <p>세부 사항</p>
                            <div class="boxin">
                                <div class="col">
                                    <p>색상</p>
                                    <select name="bicolor">
                                    	<option value="">색상을 선택하세요.</option>
                                        <option value="b" >블랙</option>
                                        <option value="w" >화이트</option>
                                    </select>
                                </div>
                                <div class="col">
                                    <p>용량</p>
                                    <select name="bimemory">
                                    	<option value="">용량을 선택하세요.</option>
                                        <option value="128" >128GB</option>
                                        <option value="256" >256GB</option>
                                        <option value="512" >512GB</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="frm-row">
                            <div class="boxin">
                                <div class="img-block">
                                    <p>전면 이미지</p>
                                    <input type="file" name="biimg" id="biimg1" accept="image/*" onchange="validation(this);" />
                                </div>
                                <div class="img-block">
                                    <p>후면 이미지</p>
                                    <input type="file" name="biimg" id="biimg2" accept="image/*" onchange="validation(this);" />
                                </div>
                            </div>
                        </div>
                        <div class="frm-row">
                            <div class="boxin">
                                <div class="img-block">
                                    <p>측면 이미지1</p>
                                    <input type="file" name="biimg" id="biimg3" accept="image/*" onchange="validation(this);" />
                                </div>
                                <div class="img-block">
                                    <p>측면 이미지2</p>
                                    <input type="file" name="biimg" id="biimg4" accept="image/*" onchange="validation(this);" />
                                </div>
                            </div>
                        </div>
                        <div class="frm-row">
                            <p>추가 입력 정보</p>
                            <textarea name="bidesc" cols="30" rows="10" placeholder="추가 정보를 입력하세요." ></textarea>
                            <p class="warn">2차 검수시 실물과 다른 상품 등록 및 분실 등록된 핸드폰 등 문제가 있는 상품에 대해서는 택배비 및 모든 책임이 본인에게 있음을 알려드립니다.</p>
                        </div>
                        <div class="btns">
                            <input type="button" value="취소" onclick="location.href='index';" />
                            <input type="button" value="신청하기" onclick="sellSubmit();" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
	</div>

</body>
</html>