<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
    <title>ȸ������ ȭ��</title>
    <link href='/css/join_style.css' rel='stylesheet' style='text/css'/>
    
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
    <!-- div ����, ������ �ٱ������� auto�� �ָ� �߾����ĵȴ�.  -->
    <div id="wrap">
        <br><br><br><br><font size="6" color="gray">ȸ������</font></b>
            <br><br><br><br>
        
        
        <form method="post" action="../pro/JoinPro.jsp" name="userInfo" 
                onsubmit="return checkValue()">
            <table>
                <tr>
                    <td id="title">���̵�</td>
                    <td>
                        <input type="text" name="id" maxlength="50">
                        <input type="button" value="�ߺ�Ȯ��" >    
                    </td>
                </tr>
                        
                <tr>
                    <td id="title">��й�ȣ</td>
                    <td>
                        <input type="password" name="password" maxlength="50">
                    </td>
                </tr>
                
                <tr>
                    <td id="title">��й�ȣ Ȯ��</td>
                    <td>
                        <input type="password" name="passwordcheck" maxlength="50">
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">�̸�</td>
                    <td>
                        <input type="text" name="name" maxlength="50">
                    </td>
                </tr>

            </table>
            <br>
            <input type="submit" value="����"/>  
            <input type="button" value="���" onclick="goLoginForm()">
        </form>
    </div>
</body>
</html>