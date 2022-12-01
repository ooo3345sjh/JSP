<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/_header.jsp"/>
<jsp:include page="/${group}.jsp"/>
<script>
	$(function () {
		if('${map.searchField}' != ''){
			$('select[name=searchField]').val('${map.searchField}').prop("selected", true);
		}
		
		// 컨텍스트루트
		let contextPath = '${pageContext.request.contextPath}';
		
		// 조회수 +1
		$('.view > a').click(function (e) {
			let no = $(this).data('no');
			$.post(contextPath + '/board/view.do', {"no":no}, function(data){});
		})
	})
	// 검색어 하이라이트(참고 사이트 : https://nyol.tistory.com/m/159)
	$(document).ready(function () {
		let searchWord = '${map.searchWord}';
		let searchFeild = $("select[name='searchField'] option:selected").val();
		
		let regex = new RegExp(searchWord, 'gi'); // g (global, 전역 판별) 처음 일치에서 중단하지 않고, 문자열 전체를 판별합니다.
												  // i (ignore case, 대소문자 무시)				
		let matcheWord; 
		if(searchWord != ''){
			
			if(searchFeild == 'title'){
				$(".view > a").each(function (e) {
					matcheWord = $(this).text().match(regex); // 정규식 표현에 해당하는 단어만 추출한다.
					
					// 정규 표현식에 해당하는 부분을 replace를 사용하여 스타일을 바꾼다.
					$(this).html($(this).text().replace(regex, "<span style='font-weight:bold; color:#D50000;'>" + matcheWord + "</span>"));
				})
			} else if(searchFeild == 'nick') {
				$(".nick").each(function () {
					matcheWord = $(this).text().match(regex); // 정규식 표현에 해당하는 단어만 추출한다.
					
					// 정규 표현식에 해당하는 부분을 replace를 사용하여 스타일을 바꾼다.
					$(this).html($(this).text().replace(regex, "<span style='font-weight:bold; color:#D50000;'>" + matcheWord + "</span>"));
				})
			}
		}
	})
	
</script>
        <main id="board">
            <section class="list">                
                <form action="#">
                	<input type="hidden" name="group" value="${group}">
                	<input type="hidden" name="cate" value="${cate}">
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
                        <th width='10%'>날짜</th>
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
			                        <td class="view">
			                        	<a href='<c:url value="/board/view.do?no=${row.no}&${queryString}"/>' data-no='${row.no}'>
			                        		${row.title}
			                        	</a>
		                        		<c:if test="${row.comment ne 0}">
			                        		<span>[${row.comment}]</span>
		                        		</c:if>
		                        		<c:if test="${row.file gt 0}">
			                        		<img style="" alt="파일" src='<c:url value='/img/file.JPG'/>'>
		                        		</c:if>
			                        	</td>
			                        <td class="nick">${row.nick}</td>
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

                <a href='<c:url value="/board/write.do?group=${group}&cate=${cate}"/>' class="btn btnWrite">글쓰기</a>
                
            </section>
        </main>
       </article>
	</section>
</div>
<jsp:include page="/_footer.jsp"/>