<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="./_header.jsp"/>
<jsp:include page="./commentScript.jsp"/>
<script>
	function realDelete() {
		return confirm("정말 삭제 하시겠습니까?"); 
	}
	
</script>
        <main id="board">
            <section class="view">
                
                <table border="0">
                    <caption>글보기</caption>
                    <tr>
                        <th>제목</th>
                        <td><input type="text" name="title" value="${map.board.title}" readonly/></td>
                    </tr>
                    <c:if test="${map.board.file ne 0}">
	                    <tr>
	                        <th>파일</th>
	                        <td><a href='<c:url value="/download.do?no=${map.board.no}"/>'>${map.board.fileName}</a>&nbsp;<span>${map.board.download}</span>회 다운로드</td>
	                    </tr>
                    </c:if>
                    <tr>
                        <th>내용</th>
                        <td>
                            <textarea name="content" readonly>${map.board.content}</textarea>
                        </td>
                    </tr>                    
                </table>
                
                <div>
                	<c:if test="${reqUser.uid eq map.board.uid}"> <!-- 로그인 회원 정보와 게시글 작성 회원 정보가 같으면 실행 -->
	                    <a href='<c:url value="/delete.do?no=${map.board.no}"/>' class="btn btnRemove" onclick="return realDelete();">삭제</a>
	                    <a href='<c:url value="/modify.do?no=${map.board.no}&title=${map.board.title}&content=${map.board.content}&fname=${map.board.fileName}"/>' class="btn btnModify">수정</a>
                	</c:if>
                	<c:choose>
                		<c:when test="${not empty searchField and not empty searchWord}"><!-- 검색 필드 및 검색 단어가 있다면 실행 -->
                    		<a href='<c:url value="/list.do?${pageContext.request.getQueryString()}"/>' class="btn btnList">목록</a>
                		</c:when>
                		<c:when test="${not empty pageNum}"> <!-- 페이지 번호가 있다면 실행 -->
                    		<a href='<c:url value="/list.do?pageNum=${pageNum}"/>' class="btn btnList">목록</a>
                		</c:when>
                		<c:otherwise>
                    		<a href='<c:url value="/list.do"/>' class="btn btnList">목록</a>
                		</c:otherwise>
                	</c:choose>
                </div>

                <!-- 댓글목록 -->
                <section class="commentList">
                    <h3>댓글목록</h3>                   
					<c:choose>
						<c:when test="${empty map.comments}">
		                    <p class="empty">등록된 댓글이 없습니다.</p>
						</c:when>
						<c:otherwise>
		                    <p class="empty"  style="display: none">등록된 댓글이 없습니다.</p>
							<c:forEach items="${map.comments}" var="comment">
			                    <article>
			                    	<input type="hidden" name="commentNo" value="${comment.no}">
			                        <span class="nick">${comment.nick}</span>
			                        <span class="date">${comment.rdate}</span>
			                        <p class="content">${comment.content}</p> 
			                        <c:if test="${reqUser.uid eq comment.uid}">
				                        <div>
				                            <a href="#" class="remove">삭제</a>
				                            <a href="#" class="modify">수정</a>
				                        </div>
			                        </c:if>                       
			                    </article>
							</c:forEach>
						</c:otherwise>
					</c:choose>
                </section>

                <!-- 댓글쓰기 -->
                <section class="commentForm">
                    <h3>댓글쓰기</h3>
                    <form action="#">
                        <textarea name="comment" placeholder="내용을 입력 해주세요."></textarea>
                        <div>
                            <a href="#" class="btn btnCancel">취소</a>
                            <input type="submit" value="작성완료" class="btn btnComplete"/>
                        </div>
                    </form>
                </section>

            </section>
        </main>
<jsp:include page="./_footer.jsp"/>    