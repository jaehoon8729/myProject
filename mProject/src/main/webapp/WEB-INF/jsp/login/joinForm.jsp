<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>회원가입 화면</title>
    <link href='/css/join_style.css' rel='stylesheet' style='text/css'/>
    
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
    <!-- div 왼쪽, 오른쪽 바깥여백을 auto로 주면 중앙정렬된다.  -->
    <div id="wrap">
        <br><br><br><br><font size="6" color="gray">회원가입</font></b>
            <br><br><br><br>
        
        
        <form method="post" action="/login/joinFormPost.do" >
            <table>
                <tr>
                    <td id="title">아이디</td>
                    <td>
                        <input type="text" name="user_id" maxlength="50">
                        <input type="button" value="중복확인" >    
                    </td>
                </tr>
                        
                <tr>
                    <td id="title">비밀번호</td>
                    <td>
                        <input type="password" name="user_pswd" maxlength="50">
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">이름</td>
                    <td>
                        <input type="text" name="user_name" maxlength="50">
                    </td>
                </tr>

            </table>
            <br>
            <input type="submit" value="가입"/>  
            <input type="button" value="취소" onclick="goLoginForm()">
        </form>
    </div>
</body>
</html>