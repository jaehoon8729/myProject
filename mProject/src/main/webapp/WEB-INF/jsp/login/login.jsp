<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
    <%
        // ���ڵ� ó��
        request.setCharacterEncoding("euc-kr"); 
    %>
    <title>�α��� ȭ��</title>
    
    <!-- css ���� �и� -->
    <link href='/css/join_style.css' rel='stylesheet' style='text/css'/>
    
    <script type="text/javascript">
    
        function checkValue()
        {
            inputForm = eval("document.loginInfo");
            if(!inputForm.id.value)
            {
                alert("���̵� �Է��ϼ���");    
                inputForm.id.focus();
                return false;
            }
            if(!inputForm.password.value)
            {
                alert("��й�ȣ�� �Է��ϼ���");    
                inputForm.password.focus();
                return false;
            }
        }
    
        // ȸ������ ��ư Ŭ���� ȸ������ ȭ������ �̵�
        function goJoinForm() {
            location.href="JoinForm.jsp";
        }    
    </script>
 
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
    <div id="wrap">
        <form name="loginInfo" method="post" action="../pro/LoginPro.jsp" onsubmit="return checkValue()">
        
            <br><br><br><br><font size="6" color="gray">�α���</font></b>
            <br><br><br><br>
            
            <table>
                <tr>
                    <td bgcolor="skyblue">���̵�</td>
                    <td><input type="text" name="id" maxlength="50"></td>
                </tr>
                <tr>
                    <td bgcolor="skyblue">��й�ȣ</td>
                    <td><input type="password" name="password" maxlength="50"></td>
                </tr>
            </table>
            <br>
            <input type="submit" value="�α���"/>
            <input type="button" value="ȸ������" onclick="location.href="/login/joinForm.do" />
        </form>
        
        <% 
            // ���̵�, ��й�ȣ�� Ʋ����� ȭ�鿡 �޽��� ǥ��
            // LoginPro.jsp���� �α��� ó�� ����� ���� �޽����� ������.
            String msg=request.getParameter("msg");
            
            if(msg!=null && msg.equals("0")) 
            {
                out.println("<br>");
                out.println("<font color='red' size='5'>��й�ȣ�� Ȯ���� �ּ���.</font>");
            }
            else if(msg!=null && msg.equals("-1"))
            {    
                out.println("<br>");
                out.println("<font color='red' size='5'>���̵� Ȯ���� �ּ���.</font>");
            }
        %>    
    </div>    
</body>
</html>
