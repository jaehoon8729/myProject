<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/js/jquery-3.1.1.min.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Board View</title>
<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
<script type="text/javascript" src="/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script>
	var filename = '<c:out value="${vo.vo.file_name}"/>'; 
	
	function updatePost() {
		var boardSubject = $("#title").val();
		var boardContent = $("#content").val();
		var checkContentLength = oEditors.getById["content"].getIR();
		var tagRemove = checkContentLength.replaceAll(/(<([^>]+)>)/ig,"");
		//에디터의 실제 내용을 가져옴
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD",[]);
		
		if('<c:out value="${sessionUserVo.user_id}"/>' == ""){		//로그인여부 확인
			alert("로그인을 해주세요!");
			location.href="/login/login";
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
			var checkContentLength = oEditors.getById["content"].getIR();
			var tagRemove = checkContentLength.replaceAll(/(<([^>]+)>)/ig,"");
			//에디터의 실제 내용을 가져옴
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD",[]);
			//실제파일명
			var fileValue = $("#uploadFile").val().split("\\");
			var fileName = fileValue[fileValue.length-1]; // 파일명
			
			$("#boardForm").append('<input type="hidden" name="default_file_name" value="'+fileName+'">');
			
		    var formData = new FormData(document.boardForm);
		    
		    
	        //Form data
// 	        const serializedValues = $("#boardForm").serializeArray();
// 	        for (var i = 0; i < serializedValues.length; i++){
// 	            var type = $("#"+serializedValues[i]['name']).attr('type');
// 	            if (type === "number") {
// 	                if (serializedValues[i]['value'] === "") {
// 	                    formData.append(serializedValues[i]['name'], 0);
// 	                }
// 	                else{
// 	                    formData.append(serializedValues[i]['name'], serializedValues[i]['value']);
// 	                }
// 	            }
// 	            else{
// 	                formData.append(serializedValues[i]['name'], serializedValues[i]['value']);
// 	            }
// 	        }
// 	        var files = $("#uploadFile")[0].files; //선택한 파일리스트를 가져온다.
// 	        console.log(files);
// 	        for (var index = 0; index < files.length; index++) {
// 	             formData.append("uploadFile", files[index]);
// 	        }
	        
			//alert(queryString);
	        $.ajax({
	        	url: '/board/detailPost',
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
                    if(json === "1"){
                        alert("게시글 수정을 성공하였습니다.");
                        location.href = "/board/board";
                    } else {
                        alert("게시글 수정을 실패하였습니다.");
                        return;
                    }
	            },
	            error: function (request, status, error) {
	                console.log("request",request);
	                console.log("status",status);
	                console.log("error",error);
	            }
	            /*
	            
	            url : '/board/detailPost',
	            type : 'post',
	            encType : 'multipart/form-data',
	            data : queryString,
	            dataType : 'json',
	            success : function(json){
	                console.log(json);    
                    if(json == 1){
                        alert("게시글 수정을 성공하였습니다.");
                        location.href = "/board/board";
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
        	<input type="hidden" id="board_id" name="board_id" value="${vo.vo.board_id}">
        	<input type="hidden" id="session_id" name="user_id" value="${sessionUserVo.user_id}"/>
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th>작성자</th>
                        <td>
                        	<input name="user_id" type="text" value="${vo.vo.user_id}" class="form-control" readonly />
                        </td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td>
                        	<input id="title" name="title" type="text" value="${vo.vo.title}" name="title" class="form-control"/>
                        </td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td>
                        	<textarea id="content" name="content" rows="10" cols="100" style="width: 100%;">${vo.vo.content }</textarea>
                        </td>
                    </tr>
						<tr>
						    <th id="thOption"></th>
						    <td id="tdOption">
							</td>
						</tr>
                    <tr>
                        <td colspan="2" style="text-align: right;">
                            <button id="btn_previous" type="button" class="btn_previous" onclick="location.href='/board/board'">이전</button>
                           	<c:if test="${sessionUserVo.user_id == vo.vo.user_id}">
	                            <button type="button" class="btn_register" onclick="updatePost()">수정</button>
	                            <button id="delete_btn" type="button" class="btn_delete" onclick="deleteBoard()">삭제</button>
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
	        bUseToolbar : true, 
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
			document.getElementById("tdOption").innerHTML='<a href="fileDownload?file_name=${vo.vo.file_name}&default_file_name=${vo.vo.default_file_name}"><input type="hidden" id="boardFileCheck" name="boardFileCheck" value="old"/><input type="text" id="uploadFile" value="${vo.vo.default_file_name}" class="form-control"/></a><button id="filedelete" type="button" class="btn_previous" onclick="deleteFile()" style="float: right">파일삭제</button>';
		}else if(filename.length <= 0){
			document.getElementById("thOption").innerText="첨부파일";
			document.getElementById("tdOption").innerHTML='<input type="hidden" id="boardFileCheck" name="boardFileCheck" value="new"/><input id="uploadFile" type="file" name="uploadFile" placeholder="파일 선택" /><br/>';
			document.getElementById("tdOption").innerHTML+='<button id="filedelete" type="button" class="btn_previous" onclick="deleteFileCancel()" style="float: right">삭제취소</button>';
		}
	}
	
	function deleteFile() {
		filename = "";
		loadDownth();
	}
	
	function deleteFileCancel(){
		filename = '<c:out value="${vo.vo.file_name}"/>';
		loadDownth();
	}
	
	function deleteBoard(){
		var form = document.createElement('form');
		form.type = 'hidden';
		form.name = 'form';
		form.method = 'post';
		form.action = '/board/delete';
		
		var input = document.createElement("input");
		input.type = 'hidden';
		input.name = 'board_id';
		input.value = document.getElementById("board_id").value;
		form.append(input);
		
		var input = document.createElement("input");
		input.type = 'hidden';
		input.name = 'user_id';
		input.value = document.getElementById("session_id").value;
		form.append(input);
		
		document.body.appendChild(form);
		form.submit();
		document.body.removeChild(form);
	}
	loadDownth();
</script>
</html>