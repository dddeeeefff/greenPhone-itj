<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_mypage.jsp"%>
	<link rel="stylesheet" href="src/css/member_question_list.css">
<%

request.setCharacterEncoding("utf-8");
ArrayList<MemberQuestion> memberQuestionList = (ArrayList<MemberQuestion>)request.getAttribute("memberQuestionList");
%>

<article class="main">



		<h3 class="main_title border_none">1:1 문의</h3>			
			<div class="table">

				<div class="row header">
					<div class="cell">상태</div>
					<div class="cell">제목</div>
					<div class="cell">등록일</div>
				</div>


				<%
if (memberQuestionList.size() > 0) {
	for (int i = 0; i < memberQuestionList.size(); i++) {
		MemberQuestion memberQuestion = memberQuestionList.get(i);
		String status = memberQuestion.getBmq_status();
		int idx = memberQuestion.getBmq_idx();
		switch (status) {
			case "a":
				status = "답변대기중";
				break;
			case "b":
				status = "답변완료";
				break;
		}
		String date = (memberQuestion.getBmq_date()).substring(0,10);
%>	
				<div class="row">
					<div class="cell status">
						<%=status %>
					</div>
					<div class="cell tit">
						<a href="member_question_view?bmqidx=<%=idx %>" title=""> <%=memberQuestion.getBmq_title() %>
						</a>
					</div>
					<div class="cell date">
						<%=date %>
					</div>
				</div>
				<%
	}
} else {
%> 
				<p class="nullRow">문의 사항이 없습니다.</p>
<%	
}
%>
			</div>
			<!--table end-->
			
			<div class="btn_area">
				<input type="button" class="btn_confirm" value="문의하기" onclick="location.href='member_question_form';" />
			</div>			
	
	
	
</article>
</section>
</body>
</html>