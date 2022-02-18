<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Board Detail</title>
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
</head>
<body>
    <br />
    <h1 class="text-center">Board Detail</h1>
    <br />
    <br />
    <div class="container">
        <form action="updateTest.do" id="viewForm" method="post"
            encType="multiplart/form-data">
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th>글번호</th>
                        <td><input name="testId" type="text" value="${vo.testId}"
                            class="form-control" readonly /></td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td><input type="text" value="${vo.testTitle}"
                            name="testTitle" class="form-control" /></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td><textarea name="testContent" class="form-control"
                                style="height: 200px;">${vo.testContent}</textarea></td>
 
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: right;">
                            <button id="btn_previous" type="button" class="btn_previous">이전</button>
                            <button id="btn_modify" type="button" class="btn_register">수정</button>
                            <button id="btn_delete" type="button" class="btn_delete">삭제</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>
</body>
<script type="text/javascript">
    $(document).on('click', '#btn_modify', function(e) {
        if (confirm("정말 수정하시겠습니까 ?") == true) {
            $("#viewForm").submit();
        } else {
            return;
        }
    });
    $(document).on('click', '#btn_delete', function(e) {
        
        var testId = ${vo.testId};
        
        if (confirm("정말 삭제하시겠습니까 ?") == true) {
            $("#viewForm").attr("action", "deleteTest.do?testId="+testId);
            $("#viewForm").submit();
        } else {
            return;
        }
    });
 
    //이전 클릭 시 testList로 이동
    $("#btn_previous").click(function previous() {
        $(location).attr('href', 'testList.do');
 
    });
</script>
</html>