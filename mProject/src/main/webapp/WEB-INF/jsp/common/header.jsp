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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<!-- boot strap header -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="http://localhost:8080/main">myproject</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

    <div class="collapse navbar-collapse" id="navbarColor01">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="http://localhost:8080/board/board"><span class="sr-only">게시판</span></a>
        </li>
       	<c:if test="${sessionUserVo.user_id == null}">
	        <li class="nav-item">
	          <a class="nav-link" href="http://localhost:8080/login/login">로그인</a>
	        </li>
	        <li class="nav-item">
          		<a class="nav-link" href="http://localhost:8080/login/joinForm">회원가입</a>
        	</li>
        </c:if>
        <c:if test="${sessionUserVo.user_id != null}">
			<h7 class="nav-link" >${sessionUserVo.user_name }님</h7>
			<a class="nav-link" href="http://localhost:8080/login/logout">로그아웃</a>
			<li class="nav-item">
          		<a class="nav-link" href="login/memberCheck">내정보</a>
        	</li>
		</c:if>
      </ul>
    </div>
  </nav>
  <!-- boot strap header -->
</body>
</html>