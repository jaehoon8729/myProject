<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Board Write</title>
<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
<script type="text/javascript" src="/js/service/HuskyEZCreator.js" charset="utf-8"></script>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
    integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
    crossorigin="anonymous">
 
<!-- Optional theme -->
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
    integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
    crossorigin="anonymous">
 
<!-- Latest compiled and minified JavaScript -->
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
    integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
    crossorigin="anonymous"></script>




<script type="text/javascript">
	function postText() {	
		var checkContentLength = oEditors.getById["content"].getIR();
		var tagRemove = checkContentLength.replaceAll(/(<([^>]+)>)/ig,"");
		
		if('<c:out value="${userVo.user_id}"/>' == ""){		//로그인여부 확인
			alert("로그인을 해주세요!");

			location.href="/login/login.do";
		}else if(tagRemove.length >= 40000){		//글자수가 40000byte제한
			alert("최대 40000 byte까지 입력 가능합니다.");	//DB엔 text형으로 컬럼을 만들어 65535 문자까지 가능
		}else{										//조건만족시 Post
			var form = document.createElement('form');
			form.type = 'hidden';
			form.name = 'form';
			form.method = 'post';
			form.action = 'boardPost.do';
			
			var input = document.createElement("input");
			input.type = 'hidden';
			input.name = 'user_id';
			input.value = '<c:out value="${userVo.user_id}"/>';
			form.append(input);
			
			var input = document.createElement("input");
			input.type = 'hidden';
			input.name = 'title';
			input.value = document.getElementById("title").value;
			form.append(input);
			
			var input = document.createElement("input");
			input.type = 'hidden';
			input.name = 'content';
			input.value = oEditors.getById["content"].getIR();
			form.append(input);
			
			document.body.appendChild(form);
			form.submit();
			document.body.removeChild(form);
		}
	}
</script> 


</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
<br/>
    <h1 class="text-center">Board Write</h1>
<br/>
<br/>
<div class="container">
        <form name="form">
        <input type="hidden" name="user_id" value="${userVo.user_id }">
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th>제목</th>
                        <td><input type="text" id="title" name="title" placeholder="제목을 입력하세요." class="form-control" /></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td>
                        	<textarea id="content" name="content" rows="10" cols="100" style="width: 100%;"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button id="" type="button" class="btn_register" onclick="javascript:postText()">작성</button>
                            <button id="btn_previous" type="button" onclick="javascript:location.href='board.do'">뒤로가기</button>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>
</body>

<script id="smartEditor" type="text/javascript"> 
	var oEditors = [];
window.onload = function() {
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "content",  //textarea ID 입력
	    sSkinURI: "/SmartEditor2Skin.html",  //martEditor2Skin.html 경로 입력
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

</script>

</html>