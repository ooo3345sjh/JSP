<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="./_header.jsp"/>
<script>
	$(function () {
		if('${map.searchField}' != ''){
			$('select[name=searchField]').val('${map.searchField}').prop("selected", true);
		}
	})
</script>
        <main id="board">
            <section class="list">                
                <form action="#">
                	<!--  <input type="hidden" name="isSearch" value="true"> -->
    	            <select name="searchField">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="nick">글쓴이</option>
					</select>
                    <input type="text" name="searchWord" value="${map.searchWord}" placeholder="제목 키워드, 글쓴이 검색">
                    <input type="submit" value="검색">
                </form>
                
                <table border="0">
                    <caption>글목록</caption>
                    <tr>
                        <th width='12%'>번호</th>
                        <th width='*'>제목</th>
                        <th width='10%'>글쓴이</th>
                        <th width='25%'>날짜</th>
                        <th width='10%'>조회</th>
                    </tr>     
                    <c:choose>
                    	<c:when test="${empty map.articles}">
                    		<tr>
                    			<td colspan="5" align="center">
                    				등록된 게시물이 없습니다.
                    			</td>
                    		</tr>
                    	</c:when>
                    	<c:otherwise>
		                    <c:forEach items="${map.articles}" var="row" varStatus="loop">
			                    <tr>
			                        <td>${map.pageStartNum - loop.index}</td>
			                        <td>
			                        	<a href='<c:url value="/view.do?no=${row.no}&${pageContext.request.getQueryString()}"/>'>
			                        		${row.title}
			                        		<c:if test="${row.comment ne 0}">
				                        		<span>[${row.comment}]</span>
			                        		</c:if>
			                        	</a></td>
			                        <td>${row.nick}</td>
			                        <td>${row.rdate}</td>
			                        <td>${row.hit}</td>
			                    </tr>
		                    </c:forEach>               
                    	</c:otherwise>
                    </c:choose>
                </table>
				<!-- 하단 메뉴(바로가기, 글쓰기)  -->
                <div class="page">
                	${map.pageTags}
                </div>

                <a href='<c:url value="/write.do"/>' class="btn btnWrite">글쓰기</a>
                
            </section>
        </main>
<jsp:include page="./_footer.jsp"/>