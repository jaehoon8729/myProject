<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="/js/jquery-3.1.1.min.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Board View</title>
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
    <!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
<script type="text/javascript" src="/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script>
	var filename = '<c:out value="${vo.file_name}"/>'; 
	
	var boardSubject = $("#title").val();
	var boardContent = $("#content").val();
	
	function updatePost() {
		var checkContentLength = oEditors.getById["content"].getIR();
		var tagRemove = checkContentLength.replaceAll(/(<([^>]+)>)/ig,"");
		//에디터의 실제 내용을 가져옴
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD",[]);
		
		if('<c:out value="${sessionUserVo.user_id}"/>' == ""){		//로그인여부 확인
			alert("로그인을 해주세요!");
			location.href="/login/login.do";
			return false;
		}else if(tagRemove.length >= 40000){		//글자수가 40000byte제한
			alert("최대 40000 byte까지 입력 가능합니다.");	//DB엔 text형으로 컬럼을 만들어 65535 문자까지 가능
			return false;
		}
		
		if (boardSubject == ""){            
		    alert("제목을 입력해주세요.");
		    $("#title").focus();
		    return;
		}
		
		if (tagRemove == ""){            
		    alert("내용을 입력해주세요.");
		    $("#content").focus();
		    return;
		}
		
		var yn = confirm("게시글을 수정하시겠습니까?");        
		if(yn){
		    var formData = new FormData();
	        //Form data
	        const serializedValues = $("#boardForm").serializeArray();
	        for (var i = 0; i < serializedValues.length; i++){
	            var type = $("#"+serializedValues[i]['name']).attr('type');
	            if (type === "number") {
	                if (serializedValues[i]['value'] === "") {
	                    formData.append(serializedValues[i]['name'], 0);
	                }
	                else{
	                    formData.append(serializedValues[i]['name'], serializedValues[i]['value']);
	                }
	            }
	            else{
	                formData.append(serializedValues[i]['name'], serializedValues[i]['value']);
	            }
	        }
	        var files = $("#uploadFile")[0].files; //선택한 파일리스트를 가져온다.
	        for (var index = 0; index < files.length; index++) {
	             formData.append("uploadFile", files[index]);
	        }
	        
			//alert(queryString);
	        $.ajax({
	        	url: '/board/detailPost.do',
	            async: true ,
	            type: 'post',
	            data: formData,
	            datatype: 'json',
	            processData: false,
	            contentType: false,
	            cache: false,
	            timeout: 600000,
	            success: function (json){
	                console.log(json);    
                    if(json == 1){
                        alert("게시글 수정을 성공하였습니다.");
                        location.href = "/board/board.do";
                    } else {
                        alert("게시글 수정을 실패하였습니다.");
                        return;
                    }
	            },
	            error: function (request, status, error) {
	            	alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
	                console.log("request",request);
	                console.log("status",status);
	                console.log("error",error);
	            }
	            /*
	            
	            url : '/board/detailPost.do',
	            type : 'post',
	            encType : 'multipart/form-data',
	            data : queryString,
	            dataType : 'json',
	            success : function(json){
	                console.log(json);    
                    if(json == 1){
                        alert("게시글 수정을 성공하였습니다.");
                        location.href = "/board/board.do";
                    } else {
                        alert("게시글 수정을 실패하였습니다.");
                        return;
                    }
	            },
	            error:function(jqXHR, textStatus, errorThrown){
	            	console.log("aaa",jqXHR)
					alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
		            //self.close();
				}
	            */
	        });
		}
	}
	
	/** 게시판 - 수정 콜백 함수 */
    function updateBoardCallback(obj){
    	
    }	
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
    <br />
    <h1 class="text-center">Board detail</h1>
    <br />
    <br />
    <div class="container"> 	
        <form id="boardForm" name="boardForm" method="post" encType="multipart/form-data" onsubmit="return false">
        	<input type="hidden" id="board_id" name="board_id" value="${vo.board_id}">
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th>작성자</th>
                        <td>
                        	<input name="user_id" type="text" value="${vo.user_id}" class="form-control" readonly />
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
						<tr>
						    <th id="thOption"></th>
						    <td id="tdOption">
							</td>
						</tr>
                    <tr>
                        <td colspan="2" style="text-align: right;">
                            <button id="btn_previous" type="button" class="btn_previous" onclick="location.href='http://localhost:8080/board/board.do'">이전</button>
                           	<c:if test="${sessionUserVo.user_id == vo.user_id}">
	                            <button type="button" class="btn_register" onclick="updatePost()">수정</button>
	                            <button type="button" class="btn_delete">삭제</button>
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
<script>
function loadDownth() {
	//파일이 없으면 업로드 출력 있으면 다운로드출력
	if(filename.length > 0){
		document.getElementById("thOption").innerText="다운로드";
		document.getElementById("tdOption").innerHTML='<a href="fileDownload.do?file_name=${vo.file_name}"><input type="text" id="uploadFile" value="${vo.file_name}" name="file_name" class="form-control"/></a><button id="filedelete" type="button" class="btn_previous" onclick="deleteFile()" style="float: right">파일삭제</button>';
	}else if(filename.length <= 0){
		document.getElementById("thOption").innerText="업로드";
		document.getElementById("tdOption").innerHTML=
		`<input id="uploadfile" type="file" name="uploadFile" placeholder="파일 선택"  onclick="" /><br/>`;
	}
}
loadDownth();
</script>
</html>