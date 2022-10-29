<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.protocol.Resultset"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신 
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	dao.updateArticleHit(no); // 조회수 올리는 메서드
	ArticleBean ab = dao.selectArticle(no); // 조건에 해당하는 게시물을 가져오는 메서드
%>
<%@ include file="_header.jsp" %>
<script src="/Jboard1/comment/js/write.js"></script>
<script src="/Jboard1/comment/js/list.js"></script>
<script src="/Jboard1/comment/js/delete.js"></script>
<script src="/Jboard1/comment/js/modify.js"></script>
<script>
	$(function () {
		 
		/******* 댓글 작성 *******/
		write(<%= no %>); // 파라미터 - no : 게시글 번호
		
		$('#comment').on('keydown', function (e) { // ENTER키를 누를때도 댓글 작성완료 버튼을 작동, SHIFT + ENTER 키는 줄바꿈
			if(e.keyCode == 13){
				if(!e.shiftKey){
					$('#write').trigger("click"); // 강제로 댓글 쓰기의 작성완료 버튼을 누른다.
				}
			} 
		});
		
		
		// 댓글쓰기 내용 리셋
		$(document).on('click', '#cancle',  function (e) {
			e.preventDefault();
			let textarea = $(this).parent().prev().val(''); // 댓글쓰기의 내용 값을 없앤다.
		});
		
		/******* 댓글 목록 출력 *******/
		list(<%= no %>, '<%= ub.getUid()%>'); // 파라미터 - no : 게시글 번호, ub.getUid() : 로그인 회원 아이디
		
		/******* 댓글 삭제 *******/
		$(document).on('click', '.remove', function(e) { 
			e.preventDefault();
			let deleteBtn = $(this); // 댓글 삭제 버튼
			deleteComment(<%=no%>, deleteBtn); // 파라미터 - no : 게시글 번호, deleteBtn : 댓글 삭제 버튼 <a>태그
		});
		
		/******* 댓글 수정 *******/
		function modify() {
			let articleTag; // 전역 변수, 수정전의 댓글의 내용을 포함하는 article태그를 저장 
			
			$(document).on('click','.modify', function (e) {
				e.preventDefault();
				let modifyBtn = $(this); // 댓글 수정 버튼
				articleTag = showModifyInput(modifyBtn); // 파라미터 - modifyBtn : 댓글 수정 버튼 <a> 태그
			});
			
			
			// #modifyCancel 클릭시 이벤트 정의 함수
			//  - 취소 버튼을 누를 경우 댓글 수정 창을 지우고, 다시 수정전의 댓글을 보이게한다.			
			$(document).on('click', '#modifyCancel',  function (e) {
				e.preventDefault();
				
				let sectionTag = $(this).parent().parent().parent(); // 댓글 수정창인 section태그를 선택
				
				articleTag.show(); // 댓글을 보여준다.
				sectionTag.remove(); // 댓글 수정창을 지운다.
			});
			
			
			// #modifyComplete 클릭시 이벤트 정의 함수
			//  - 작성완료 버튼을 누를 경우 AJAX로 데이터를 modifyProc.jsp로 보내어 DB에 업데이트 한다.	
			$(document).on('click', '#modifyComplete',  function (e) {
				e.preventDefault();
				let modifyCompleteBtn = $(this); // 댓글 수정완료 버튼
				modifyComplete(modifyCompleteBtn, articleTag); // 파라미터 - modifyCompleteBtn : 댓글 수정완료 버튼, articleTag : 수정전의 댓글의 내용을 포함하는 article태그
			});
			
			$(document).on('keydown', '#modifyContent', function (e) { // ENTER키를 누를때도 댓글 작성완료 버튼을 작동, SHIFT + ENTER 키는 줄바꿈
				if(e.keyCode == 13){
					if(!e.shiftKey){
						$('#modifyComplete').trigger("click"); // 강제로 댓글 수정창의 작성완료 버튼을 누른다.
					}
				} 
			});
			
		}
		
		modify(); // 댓글 수정 함수 호출
		
		
	});
</script>
	<main id="board">
	    <section class="view">
	        <table border="0">
	            <caption>글보기</caption>
	            <tr>
	                <th>제목</th>
	                <td>
	                    <input type="text" name="title" value="<%= ab.getTitle() %>" readonly>
	                </td>
	            </tr>
	            <% if(ab.getFile() > 0){ %>
	            <tr>
	                <th>첨부파일</th>
	                <td>
	                    <a href="/Jboard1/proc/download.jsp?parent=<%= ab.getNo() %>"><%= ab.getOriName() %></a>&nbsp;<span><%= ab.getDownload() %>회</span> 다운로드
	                </td>
	            </tr>
	            <%} %>
	            <tr>
	                <th>내용</th>
	                <td>
	                    <textarea name="content" readonly><%= ab.getContent() %></textarea>
	                </td>
	            </tr>
	            
	        </table>
	        <div>
	            <a href="#" class="btn btnRemove">삭제</a>
	            <a href="/Jboard1/modify.jsp" class="btn btnModify">수정</a>
	            <a href="/Jboard1/list.jsp?pg=<%= pg %>" class="btn btnList">목록</a>
	        </div>
	
	        <!-- 댓글 목록 -->
	        <section class="commentList">
	            <h3>댓글목록</h3>
	            <p class="empty">
	                등록된 댓글이 없습니다.
	            </p>                     
	        </section>
	
	        <!-- 댓글 쓰기 -->
	        <section class="commentForm">
	            <h3>댓글쓰기</h3>
	            <form action="#">
	                <textarea id="comment" name="content" placeholder="내용을 입력해주세요."></textarea>
	                <div>
	                    <a href="#" class="btn btnCancel" id="cancle">취소</a>
	                    <input type="submit" value="작성완료"  class="btn btnComplete" id="write">
	                </div>
	            </form>
	        </section>
	    </section>
 <%@ include file="_footer.jsp" %>