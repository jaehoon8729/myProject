<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">
a{
 text-decoration: auto;
}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<a href="http://localhost:8080/board/board.do">게시판</a>
	<c:if test="${sessionUserVo.user_id == null}">
		<a href="http://localhost:8080/login/login.do">로그인</a>
	</c:if>
	<c:if test="${sessionUserVo.user_id != null}">
		${sessionUserVo.user_name }님어서오세요
		<a href="http://localhost:8080/login/logout.do">로그아웃</a>
	</c:if>
	<a href="http://localhost:8080/login/joinForm.do">회원가입</a>
</body>
</html>