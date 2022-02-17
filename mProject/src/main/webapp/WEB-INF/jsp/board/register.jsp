<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Board Write</title>
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

<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->


</head>
<body>

<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
<br/>
    <h1 class="text-center">Board Write</h1>
<br/>
<br/>
<div class="container">
        <form id="form_test" action="insertTest.do" method="post"
            encType="multiplart/form-data">
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th>제목</th>
                        <td><input type="text" placeholder="제목을 입력하세요."
                            name="testTitle" class="form-control" /></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td>
                        	<textarea id="smartE" name="smartE" rows="10" cols="100" style="width: 100%;"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button id="save" type="button" class="btn_register" onclick="">작성</button>
                            <button id="btn_previous" type="button" onclick="javascript:location.href='board.do'">뒤로가기</button>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>
</body>

<script id="smartEditor" type="text/javascript"> 
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "smartE",  //textarea ID 입력
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
</script>

</html>