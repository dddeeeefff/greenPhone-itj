<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String url = request.getParameter("url");
if (url == null)	url = "index";
%>
	<link rel="stylesheet" href="src/css/login_form.css">
    <div class="page-contents">
        <div class="login-wrapper">
            <div class="login-box">
                <h2>로그인</h2>
                <div class="ctrl-wrapper">
                    <form name="frmLogin" action="login" method="post">
                        <input type="hidden" name="url" value="<%=url %>" />
                        <div class="input-wrapper">
                            <div class="input_row">
                                <label for="uid">아이디 </label>
                                <input type="text" name="uid" id="uid" class="input_text" value="test1" />
                            </div>
                            <div class="input_row">
                                <label for="pwd">비밀 번호 </label>
                                <input type="password" name="pwd" id="pwd" class="input_text" value="1234" />
                            </div>
                        </div>
                        <p class="submit">
                            <input type="submit" class="btn" value="로그인" />
                        </p>
                    </form>
                </div>
            </div>
            <div class="btns">
                <a href="find_id_form">아이디 찾기</a>
                <a href="find_pw_form">비밀번호 찾기</a>
                <a href="member_form_in">회원 가입</a>
            </div>
        </div>
    </div>
</body>
</html>