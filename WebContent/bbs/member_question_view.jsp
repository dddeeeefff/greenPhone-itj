<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_mypage.jsp"%>
<%@page import="java.text.DecimalFormat"%>
<%
request.setCharacterEncoding("utf-8");
MemberQuestion memberQuestion = (MemberQuestion)request.getAttribute("memberQuestion");
String status = "";
if (memberQuestion.getBmq_status().equals("a")) {
	status = "답변대기중";
} else {
	status = "답변완료";
}
%>
<style>
.view_title_box{display:flex;align-items: center;background-color:#eee;padding:10px;justify-content:space-between}
p.view_title {font-size:1.2rem; font-weight:600; color:#333;  box-sizing:border-box; display:inline-block; box-sizing:border-box; }
.op{background:#0e9482;color:#fff;padding:8px 15px;float:right;font-weight: 500;}

p.view_info {font-size:1rem; font-weight:400; color:#666; width:100%;  border-bottom:1px solid #ddd; padding:12px 0; display:inline-block; box-sizing:border-box; }

p.view_info a {color:#015bac !important}
p.view_info a:hover {text-decoration:underline }

div.view_content {width:100%; display:inline-block;  border-bottom:1px solid #ddd; padding:20px 0; }

div.view_file {width:100%; padding:15px 0 10px 0;  border-bottom:1px solid #ddd; }
div.view_file ul {width:100%; display:flex; flex-wrap:wrap;}
div.view_file ul li {display:inline-block; margin-bottom:5px; }
div.view_file ul li a {display:inline-block; font-size:0.90rem; background-color:red; color:#fff; padding:10px 15px; border-radius:5px; margin-right:10px;}

div.reple {width:100%; display:flex; border-bottom:1px solid #ddd; padding:15px 10px; font-size:15.5px; color:#666;  background-color:#f9f9f9; box-sizing:border-box;}
div.reple  b {color:#333; font-weight:600; font-size:16px; width:90px}
div.reple  p {padding-left:30px;}

.answer{border:1px solid #ddd;padding:10px;margin:15px 0}
.answer span{background:#e4f5f3;padding:10px;display:inline-block;margin-top:-12px;color:#000}

.ing{border-bottom:1px solid #ddd;padding-bottom:1%}
.answer_text{padding:1% 0}     


.btn_wrap{
width: 100%;
text-align: center;
margin-top:50px

}

.no_btn_bg  a {
display:inline-block;
 line-height:43px;
border-radius:5px;
font-size:1em; 
font-weight:600;
 background-color:#585858;
 color: #fff;
 padding:5px 50px
}
</style>
<article class="main">

<div class="view_title_box">
    <p class="view_title"><%=memberQuestion.getBmq_title() %></p>
    <span class="op"><%=status %></span>
</div>   
  <p class="view_info">
    <span class="view_data">작성자 : <%=memberQuestion.getMi_id() %></span> &nbsp; | &nbsp;
    <span class="view_data">등록일 : <%=memberQuestion.getBmq_date() %></span>  
  </p>

<div class="view_content"><%=memberQuestion.getBmq_content() %></div>

<div class="answer">
  <p class="view_info">
      <span><%=memberQuestion.getAi_idx() %></span>
  </p>
    <p class="answer_text"><%=memberQuestion.getBmq_answer() %></p>

</div>


<div class="btn_wrap">
    <span class="no_btn_bg"><a href="member_question_list">목록</a> </span>
</div>

</article>
</section>
</body>
</html>