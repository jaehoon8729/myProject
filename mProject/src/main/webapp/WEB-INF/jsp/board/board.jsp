<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Board List</title>
<style type="text/css">
	a{
	 text-decoration: auto;
	}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/common/header.jsp"></jsp:include>
    <br/>
    <h1 class="text-center">Board List</h1>
    <br/>
    <br/>
    
    <div class="container">
        <table class="table table-hover table-striped text-center" style="border:0.1px solid;">
            <colgroup>
                <col width="10%" />
                <col width="50%" />
                <col width="20%" />
                <col width="20%" />
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>등록일자</th>
                </tr>
            </thead>
 
            <tbody>
            <c:forEach items="${boardList }" var="result">
                <tr>
                    <td>${result.board_id}</td>
                    <td><a href="/board/view.do?board_id=${result.board_id}">${result.title}</a></td>
                    <td>${result.user_id}</td>
                    <td><fmt:formatDate value="${result.reg_dtm}" pattern="yyyy-MM-dd HH:mm"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <hr/>
        <!-- pagination start -->
        <div id="paginationBox" class="pagination1">
            <ul class="pagination justify-content-center">
                <c:if test="${pagination.prev}">
                    <li class="page-item"><a class="page-link" href="#"
                        onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.listSize}'
                    ,'${search.searchType}', '${search.keyword}')">이전</a></li>
                </c:if>
 
                <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="pageId">
                    <li class="page-item <c:out value="${pagination.page == pageId ? 'active' : ''}"/> ">
                    <a class="page-link" href="#"
                        onClick="fn_pagination('${pageId}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.listSize}'
                     ,'${search.searchType}', '${search.keyword}')">
                            ${pageId} </a></li>
                </c:forEach>
 
                <c:if test="${pagination.next}">
                    <li class="page-item"><a class="page-link" href="#"
                        onClick="fn_next('${pagination.range}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.listSize}'
                    ,'${search.searchType}', '${search.keyword}')">다음</a></li>
                </c:if>
            </ul>
        </div>
        <!-- pagination end -->
        <div>
        	<a class="btn btn-outline-info" style="float:right" href="register.do">글쓰기</a>
        </div>
        
        <!-- search start -->
        <div class="form-group row">
            <div class="w100" style="padding-right: 10px">
                <select class="form-select" name="searchType" id="searchType">
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                </select>
            </div>
            <div class="w300" style="padding-right: 10px">
                <input type="text" class="form-control form-control-sm" name="keyword" id="keyword">
                <button class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch">검색</button>
            </div>
        </div>
        <!-- search end -->
    </div>
    <br>
</body>
    <script type="text/javascript">
    //이전 버튼 이벤트
    //5개의 인자값을 가지고 이동 testList.do
    //무조건 이전페이지 범위의 가장 앞 페이지로 이동
    function fn_prev(page, range, rangeSize, listSize, searchType, keyword) {
            
        var page = ((range - 2) * rangeSize) + 1;
        var range = range - 1;
            
        var url = "/board/board.do";
        url += "?page=" + page;
        url += "&range=" + range;
        url += "&listSize=" + listSize;
        url += "&searchType=" + searchType;
        url += "&keyword=" + keyword;
        location.href = url;
        }
 
 
    //페이지 번호 클릭
    function fn_pagination(page, range, rangeSize, listSize, searchType, keyword) {
 
        var url = "/board/board.do";
            url += "?page=" + page;
            url += "&range=" + range;
            url += "&listSize=" + listSize;
            url += "&searchType=" + searchType;
            url += "&keyword=" + keyword; 
 
            location.href = url;    
        }
 
    //다음 버튼 이벤트
    //다음 페이지 범위의 가장 앞 페이지로 이동
    function fn_next(page, range, rangeSize, listSize, searchType, keyword) {
        var page = parseInt((range * rangeSize)) + 1;
        var range = parseInt(range) + 1;            
        var url = "/board/board.do";
            url += "?page=" + page;
            url += "&range=" + range;
            url += "&listSize=" + listSize;
            url += "&searchType=" + searchType;
            url += "&keyword=" + keyword;
            location.href = url;
        }
        
    // 검색
    $(document).on('click', '#btnSearch', function(e){
        e.preventDefault();
        var url = "/board/board.do";
        url += "?searchType=" + $('#searchType').val();
        url += "&keyword=" + $('#keyword').val();
        location.href = url;
        console.log(url);
 
    });    
 
    </script>
</html>