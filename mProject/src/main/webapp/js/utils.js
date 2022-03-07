function pwCheck() {
	var pw = $('#user_pswd').val();
	$.ajax({
    	url: '/user/myPage',
        async: true ,
        type: 'post',
        data: pw,
        datatype: 'json',
        processData: false,
        contentType: false,
        cache: false,
        success: function (json){
            
        },
        error: function (request, status, error) {
            console.log("request",request);
            console.log("status",status);
            console.log("error",error);
        }
	});
}