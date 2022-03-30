<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/js/jquery-3.1.1.min.js" type="text/javascript"></script>
<title>Board Write</title>
<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
<script type="text/javascript" src="/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/service/SE2BasicCreator.js" charset="utf-8"></script>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
<br/>
    <h1 class="text-center">Board Write</h1>
<br/>
<br/>
<div class="container">
        <form id="form" name="form" method="post" enctype="multipart/form-data" action="boardPost" onsubmit="return postText();">
        	<input type="hidden" name="user_id" value="<c:out value="${sessionUserVo.user_id}"/>">
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th>제목</th>
                        <td><input type="text" id="title" name="title" placeholder="제목을 입력하세요." class="form-control" /></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td>
                        	<textarea id="content" name="content" rows="" cols="100" style="width: 100%;"></textarea>
                        </td>
                    </tr>
                    <tr>
                    	<th>첨부파일</th>
                    	<td>
	                        <input id="uploadfile" type="file" name="uploadFile" placeholder="파일 선택" /><br/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button id="" type="submit" class="btn_register" >작성</button>
                            <button id="btn_previous" type="button" onclick="javascript:location.href='board'">뒤로가기</button>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>
</body>

<script type="text/javascript"> 
var oEditors = [];
window.onload = function() {
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "content",  //textarea ID 입력
	    sSkinURI: "/SmartEditor2Skin.html",  //SmartEditor2Skin.html 경로 입력
	    fCreator: "createSEditor2",
	    htParams : { 
	    	// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
	        bUseToolbar : true, 
			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseVerticalResizer : false, 
			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseModeChanger : false 
	    }
	});
}

function postText() {
	var checkTitleLength = $('#title').val();
	var checkContentLength = oEditors.getById["content"].getIR();
	var tagRemove = checkContentLength.replaceAll(/(<([^>]+)>)/ig,"");
	//에디터의 실제 내용을 가져옴
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD",[]);
	
	if('<c:out value="${sessionUserVo.user_id}"/>' == ""){		//로그인여부 확인
		alert("로그인을 해주세요!");
		location.href="/login/login";
		return false;
	}else if(checkTitleLength.length > 100){
		alert("제목은 최대 100자까지 입력 가능합니다.");
		return false;
	}else if(tagRemove.length >= 40000){		//글자수가 40000byte제한
		alert("내용은 최대 40000 byte까지 입력 가능합니다.");	//DB엔 text형으로 컬럼을 만들어 65535 문자까지 가능
		return false;
	}else{
		var fileValue = $("#uploadfile").val().split("\\");
		var fileName = fileValue[fileValue.length-1]; // 파일명
		
		$("#form").append('<input type="hidden" name="default_file_name" value="'+fileName+'">');
	}
}


</script>

</html>