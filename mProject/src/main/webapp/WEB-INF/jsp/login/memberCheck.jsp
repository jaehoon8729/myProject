<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
    <title>비밀번호 확인</title>
    <link href='/css/join_style.css' rel='stylesheet' style='text/css'/>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
    <!-- div 왼쪽, 오른쪽 바깥여백을 auto로 주면 중앙정렬된다.  -->
    <div id="wrap">
        <br><br><br><br><font size="6" color="gray">비밀번호 확인</font></b>
            <br><br><br><br>
        
        <form id="loginForm" method="post">
        	<input type="hidden" id="sessionInfo" name="user_id" value='${sessionUserVo.user_id}'/>
            <table>
                <tr>
                    <td id="title">비밀번호</td>
                    <td>
                        <input id="user_pswd" type="password" name="user_pswd" maxlength="50">
                    </td>
                </tr>
				<tr>
					<td colspan="2">
						<input type="button" value="확인" onclick="pwCheck()"/> 
					</td>
				</tr>
            </table>
        </form>
    </div>
</body>
    <script type="text/javascript" src="/js/utils.js"></script>
</html>