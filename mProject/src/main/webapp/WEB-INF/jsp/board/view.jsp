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

</head>
<body>
	<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
    <br />
    <h1 class="text-center">Board View</h1>
    <br />
    <br />
    <div class="container">
        <form action="updateTest.do" id="viewForm" method="post"
            encType="multiplart/form-data">
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
                        	<input type="text" name="title" value="${vo.title}" class="form-control" readonly/>
                        </td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td>
                        	<textarea id="content" name="content" rows="10" cols="100" style="width: 100%;" readonly>${vo.content }</textarea>
                        </td>
                    </tr>
                    <c:if test="${vo.file_name ne null}">
						<tr>
						    <th>다운로드</th>
						    <td>
							    <a href="fileDownload.do?file_name=${vo.file_name}">
								<input type="text" id="filename" value="${vo.file_name}" name="fileName" class="form-control" readonly="readonly" /></a>
							</td>
						</tr>
                    </c:if>
                    <tr>
                        <td colspan="2" style="text-align: right;">
                            <button id="btn_previous" type="button" class="btn_previous" onclick="location.href='http://localhost:8080/board/board.do'">이전</button>
                           	<c:if test="${sessionUserVo.user_id == vo.user_id}">
	                            <button id="btn_modify" type="button" class="btn_register" onclick="location.href='/board/detail.do?board_id=${vo.board_id}'">수정</button>
                            </c:if>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <!-- 댓글 부분 -->
	    <div class="container">
	        <table class="table table-bordered">
			    <!-- 댓글 목록 -->
                <tbody>
	                <c:forEach var="comment" items="${cvo}">
	                	<input type="hidden" id="comment_id${comment.comment_id}" name="comment_id" value="${comment.comment_id}"/>
						<tr>
	                        <th>${comment.user_id}<br>${comment.reg_dtm}</th>
	                        <td>
	                        	<input id="id${comment.comment_id}" name="id" type="text" value="${comment.com_content}" class="form-control" readonly />
	                        </td>
	                        <td>
	                        	<!-- 댓글 작성자만 수정, 삭제 가능하도록 -->    
			                    <c:if test="${comment.user_id == sessionUserVo.user_id}">
			                        <button id="updateComment" onclick="updateComment(${comment.comment_id})">[수정]</button><br>   
			                        <button id="deleteComment" onclick="deleteComment(${comment.comment_id})">[삭제]</button>
			                    </c:if>
	                        </td>
	                    </tr>
					</c:forEach>
				</tbody>
			</table>
            <!-- 로그인 했을 경우만 댓글 작성가능 -->
            <c:if test="${sessionUserVo.user_id != null}">
            	<form name="writeCommentForm" method="post" action="commentPost.do" onsubmit="return commentPost()">
            		<input type="hidden" id="user_id" name="user_id" value="${sessionUserVo.user_id}"/>
                	<input type="hidden" id="board_id" name="board_id" value="${vo.board_id}"/>
	            	<table class="table table-bordered">
		            	<tr bgcolor="#F5F5F5">
			                <!-- 아이디-->
			                <td width="150">
		                        ${userVo.user_id}
			                </td>
			                <!-- 본문 작성-->
			                <td width="550">
		                        <textarea id="com_content" name="com_content" rows="4" cols="70" ></textarea>
			                </td>
			                <!-- 댓글 등록 버튼 -->
			                <td width="100">
		                        <button type="submit">[댓글작성]</button>   
			                </td>
		            	</tr>
	            	</table>
            	</form>
            </c:if>
	    </div>
		<!-- 댓글작성 -->

		
    </div>
</body>
<script type="text/javascript"> 
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
	    },
	    fOnAppLoad : function(){
			//oEditors.getById["content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
			var editor = oEditors.getById["content"];
			editor.exec("DISABLE_WYSIWYG");
			editor.exec("DISABLE_ALL_UI");
		}
	});
	
	//댓글길이check
	function commentPost() {
		var commentLength = $('#com_content').val();

		if(commentLength.length > 1000){
			alert("댓글 길이가 너무 깁니다.");
			return false;
		}
	}
	//댓글 삭제
	function deleteComment(a) {
		var form = document.createElement('form');
		form.type = 'hidden';
		form.name = 'form';
		form.method = 'post';
		form.action = '/board/deleteComment.do';
		
		var input = document.createElement("input");
		input.type = 'hidden';
		input.name = 'comment_id';
		input.value = document.getElementById("comment_id"+a).value;
		form.append(input);
		
		var input = document.createElement("input");
		input.type = 'hidden';
		input.name = 'board_id';
		input.value = document.getElementById("board_id").value;
		form.append(input);
		
		document.body.appendChild(form);
		form.submit();
		document.body.removeChild(form);
	}
	
	function updateComment(a) {
		if($('#id'+a).is('[readonly]')){
			$('#id'+a).attr('readonly', false);
			return false;
		}
		
		var form = document.createElement('form');
		form.type = 'hidden';
		form.name = 'form';
		form.method = 'post';
		form.action = '/board/updateComment.do';
		
		var input = document.createElement("input");
		input.type = 'hidden';
		input.name = 'com_content';
		input.value = document.getElementById("id"+a).value;
		form.append(input);
		
		var input = document.createElement("input");
		input.type = 'hidden';
		input.name = 'board_id';
		input.value = document.getElementById("board_id").value;
		form.append(input);
		
		var input = document.createElement("input");
		input.type = 'hidden';
		input.name = 'user_id';
		input.value = document.getElementById("user_id").value;
		form.append(input);
		
		var input = document.createElement("input");
		input.type = 'hidden';
		input.name = 'comment_id';
		input.value = document.getElementById("comment_id"+a).value;
		form.append(input);
		
		document.body.appendChild(form);
		form.submit();
		document.body.removeChild(form);
	}
</script>
</html>