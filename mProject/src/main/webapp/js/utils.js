$('#loginForm').keypress(function(e){
	if(e.keyCode === 13){
		pwCheck();
	}
});

function pwCheck() {
	var form = new FormData(document.getElementById('loginForm'));
	var userInfo = $('#sessionInfo').val();
	
	if(userInfo !== null){
		var pw = $('#user_pswd').val();
		$.ajax({
	    	url: '/login/loginPost',
	        async: true ,
	        type: 'post',
	        data: form,
	        datatype: 'json',
	        processData: false,
	        contentType: false,
	        cache: false,
	        success: function (json){
	            if(json === 1){
	            	alert("확인완료");
	            	location.href="/login/myPage";
	            }else{
	            	alert("비밀번호가 다릅니다.");
	            	return false;
	            }
	        },
	        error: function (request, status, error) {
	            console.log("request",request);
	            console.log("status",status);
	            console.log("error",error);
	        }
		});
	}else{
		alert('로그인해주세요');
		return false;
	}
}