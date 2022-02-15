<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
</head>
<body>
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
                        <td><textarea placeholder="내용을 입력하세요 ." name="testContent"
                                class="form-control" style="height: 200px;"></textarea></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button id="btn_register" type="button" class="btn_register" onclick="">작성</button>
                            <button id="btn_previous" type="button" onclick="javascript:location.href='board.do'">뒤로가기</button>
                    </tr>
 
                </tbody>
            </table>
        </form>
    </div>
</body>
<script type="text/javascript">
    //글쓰기
    $(document).on('click', '#btn_register', function(e) {
        $("#form_test").submit();
    });

</script>
</html>