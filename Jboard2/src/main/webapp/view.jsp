<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="./_header.jsp"/>
<%-- <jsp:include page="./commentScript.jsp"/> --%>
<script src='<c:url value='/js/comment.js'/>'></script>
<script>

	// 글 삭제 재확인
	function realDelete() {
		return confirm("정말 삭제 하시겠습니까?"); 
	}
	
	// 댓글 CRUD
	$(function () {
		let no = '${map.board.no}'   // 게시글 번호
		let nick = '${reqUser.nick}' // 회원 닉네임
		let	uid = '${reqUser.uid}'   // 회원 아이디
		let user = {"no":no, "nick":nick, "uid":uid}; // 배열로 저장
		
		// comment insert
		write(user);
		
		// comment update
		modify();
	})
	
	// download +1
	$(function () {
		$('#down > a').click(function () {
			let totalDown = $('#down > span').text();
			totalDown = parseInt(totalDown) + 1;
			$('#down > span').text(totalDown);
		})
	})
	
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
	                        <td id="down"><a href='<c:url value="/download.do?no=${map.board.no}"/>'>${map.board.fileName}</a>&nbsp;<span>${map.board.download}</span>회 다운로드</td>
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
                	<c:if test="${reqUser.uid eq map.board.uid}">
	                    <a href='<c:url value="/delete.do?no=${map.board.no}"/>' class="btn btnRemove" onclick="return realDelete();">삭제</a>
	                    <a href='<c:url value="/modify.do?no=${map.board.no}&title=${map.board.title}&content=${map.board.content}&fname=${map.board.fileName}"/>' class="btn btnModify">수정</a>
                	</c:if>
                    <a href='<c:url value="/list.do?${queryString}"/>' class="btn btnList">목록</a>
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