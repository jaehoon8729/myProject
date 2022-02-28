<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        
        <form method="post" action="/login/joinFormPost.do" onsubmit="return joinCheck()" >
            <table>
                <tr>
                    <td id="title">아이디</td>
                    <td>
                        <input type="text" id="user_id" name="user_id" maxlength="50">
                        <input id="overlapCheck" type="button" value="중복확인">
                        <input id="overlapSuccess" type="button" style="display:none" value="확인완료"/> 
                    </td>
                </tr>
                        
                <tr>
                    <td id="title">비밀번호</td>
                    <td>
                        <input id="user_pswd" type="password" name="user_pswd" maxlength="50">
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
            <input type="button" value="취소" onclick=""/>
        </form>
    </div>
</body>
<script type="text/javascript">
	var idCheck;
	
	//중복확인후 아이디 변경시 재확인
	$('#user_id').change(function(){
		idCheck = 1;
		$('#overlapCheck').attr('style','');
		$('#overlapSuccess').attr('style','display:none');
	});
	
	//아이디중복체크
	$('#overlapCheck').click(function(){
		var id = $('#user_id').val();
		var post = {user_id:id};
		
		$.ajax({
			url: "/login/joinFormOverlap.do",
			type: "post",
			data: post,
			dataType:"text",
			success:function(data){
				idCheck = data;
				if(idCheck == "1"){
					alert("아이디가 이미있습니다.")
				}else if(idCheck == "0"){
					var idl = $('#user_id').val();
					
					if(idl.length < 2 || idl.length > 20){
						
						alert("아이디는 2글자이상 20자 미만으로 작성해주세요.");
						idCheck = "1";
						return false;
					}
					alert("사용 가능한 아이디입니다.");
					$('#overlapCheck').attr('style','display:none');
					$('#overlapSuccess').attr('style','');
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
	            self.close();
			}
		})
	});
	
	//submit시 중복확인 체크
	function joinCheck() {
		var pwl = $('#user_pswd').val();
		
		if(idCheck == "1"){
			alert("중복확인을 해주세요.");
			return false;
		}
		
		if(pwl.length < 2 || pwl.length > 20){
			
			alert("비밀번호는 2글자이상 20자 미만으로 작성해주세요.");
			return false;
		}
	}
</script>
</html>