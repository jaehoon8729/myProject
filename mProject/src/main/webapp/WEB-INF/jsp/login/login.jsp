<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="/js/user.js"></script>
    <title>로그인</title>
    <!-- css 파일 분리 -->
    <link href='/css/join_style.css' rel='stylesheet' style='text/css'/>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
    <div id="wrap">
        <form name="loginInfo" method="post" action="/login/loginPost.do" onsubmit="return checkValue()">
        
            <br><br><br><br><font size="6" color="gray">로그인</font></b>
            <br><br><br><br>
            
            <table>
                <tr>
                    <td bgcolor="skyblue">아이디</td>
                    <td><input type="text" name="user_id" maxlength="50"></td>
                </tr>
                <tr>
                    <td bgcolor="skyblue">비밀번호</td>
                    <td><input type="password" name="user_pswd" maxlength="50" autocomplete="off"></td>
                </tr>
            </table>
            <c:if test=""></c:if>
            <div>
           		<img src="/captcha/getImg.do" id="captchaImg" alt="captcha img">
				<input id="captcha" type="text" placeholder="보안문자를 입력하세요" name="captcha">
				<input type="button" onclick="imgRefresh()" id="refreshBtn" value="새로고침"/>
         	</div>
            <br>
            <input type="submit" value="로그인"/>
            <input type="button" value="회원가입" onclick="location.href='joinForm.do'" />
        </form>
    </div>    
</body>
</html>
