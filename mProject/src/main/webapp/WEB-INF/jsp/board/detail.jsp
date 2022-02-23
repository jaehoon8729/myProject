<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Board View</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
    integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"............................
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
    <!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
<script type="text/javascript" src="/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script>
	function updatePost() {
		var checkContentLength = oEditors.getById["content"].getIR();
		var tagRemove = checkContentLength.replaceAll(/(<([^>]+)>)/ig,"");
		//에디터의 실제 내용을 가져옴
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD",[]);
		
		if('<c:out value="${userVo.user_id}"/>' == ""){		//로그인여부 확인
			alert("로그인을 해주세요!");
			location.href="/login/login.do";
			return false;
		}else if(tagRemove.length >= 40000){		//글자수가 40000byte제한
			alert("최대 40000 byte까지 입력 가능합니다.");	//DB엔 text형으로 컬럼을 만들어 65535 문자까지 가능
			return false;
		}
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
    <br />
    <h1 class="text-center">Board View</h1>
    <br />
    <br />
    <div class="container">
        <form action="detailPost.do" id="viewForm" method="post" encType="multiplart/form-data" onsubmit="return updatePost()">
        	<input type="hidden" id="board_id" name="board_id" value="${vo.board_id}">
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th>작성자</th>
                        <td>
                        	<input name="id" type="text" value="${vo.user_id}" class="form-control" readonly />
                        </td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td>
                        	<input id="title" name="title" type="text" value="${vo.title}" name="title" class="form-control"/>
                        </td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td>
                        	<textarea id="content" name="content" rows="10" cols="100" style="width: 100%;">${vo.content }</textarea>
                        </td>
                    </tr>
                    <c:if test="${vo.file_name ne null}">
						<tr>
						    <th>다운로드</th>
						    <td>
							    <a href="fileDownload.do?file_name=${vo.file_name}">
								<input type="text" id="uploadFile" value="${vo.file_name}" name="uploadFile" class="form-control"/></a>
								<button id="filedelete" type="button" class="btn_previous" style="float: right">파일삭제</button>
							</td>
						</tr>
                    </c:if>
                    <c:if test="${vo.file_name eq null}">
	                    <tr>
	                    	<th>첨부파일</th>
	                    	<td>
		                        <input id="uploadfile" type="file" name="uploadFile" placeholder="파일 선택" /><br/>
	                        </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td colspan="2" style="text-align: right;">
                            <button id="btn_previous" type="button" class="btn_previous" onclick="location.href='http://localhost:8080/board/board.do'">이전</button>
                           	<c:if test="${userVo.user_id == vo.user_id}">
	                            <button id="btn_modify" type="submit" class="btn_register">수정</button>
	                            <button id="btn_delete" type="button" class="btn_delete">삭제</button>
                            </c:if>
                        </td>
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
	    elPlaceHolder: "content",  //textarea ID 입력
	    sSkinURI: "/SmartEditor2Skin.html",  //martEditor2Skin.html 경로 입력
	    fCreator: "createSEditor2",
	    htParams : { 
	    	// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
	        bUseToolbar : false, 
		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
		bUseVerticalResizer : false, 
		// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
		bUseModeChanger : false 
	    }
	});
</script>
</html>