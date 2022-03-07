
function checkValue(){
	var userid = $('#user_id').val();
	var userpw = $('#user_pswd').val();
    
    if(!userid){
        alert("아이디를 입력하세요");    
        return false;
    }
    if(!userpw){
        alert("비밀번호를 입력하세요");    
        return false;
    }
    
    var form = new FormData(document.getElementById('loginForm'));

    $.ajax({
    	url: '/login/loginPost',
        async: true ,
        type: 'post',
        data: form,
        processData: false,
        contentType: false,
        cache: false,
        success: function (result){
            if(result == 1){
            	location.href="/main";
            }else if(result == 0){
            	alert("캡차가 다릅니다.");
            	return false;
            }else if(result == 2){
            	alert("로그인 정보가 다릅니다.");
            	return false;
            }
        },
        error: function (request, status, error) {
            console.log("request",request);
            console.log("status",status);
            console.log("error",error);
        }
	});
}
function imgRefresh(){
    $("#captchaImg").attr("src", "/captcha/getImg.do?id=" + Math.random());
}
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
			idCheck = $.trim(data);
			
			if(idCheck == '"1"'){	//값에 ""이 붙어서 나옴
				alert("아이디가 이미있습니다.");
			}else if(idCheck == '"0"'){		//값에 ""이 붙어서 나옴
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