<%@page import="java.util.List"%>
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
	
	// 댓글 가져오기
	List<ArticleBean> comments = dao.selectComments(no);
%>
<%@ include file="_header.jsp" %>
<script src="/Jboard1/js/comment.js"></script>
<script>
	$(document).ready(function () {	
		
		// 글 삭제
		$('.btnRemove').click(function (e) {
			let isDelete = confirm('정말 삭제 하시겠습니까?');
			
			if(isDelete){
				return true;
			}else {
				return false;
			}
		});
		
		// 게시글의 댓글 유무를 확인하고 출력하는 함수
		commentEmpty();
		
		// 댓글 삭제
		commentDelete();
		
		// 댓글 수정
		commentModify();
		
		// 댓글 작성 
		commentWrite();
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
	        <% if(ub.getUid().equals(ab.getUid()) ){ %>
	            <a href="/Jboard1/proc/deleteProc.jsp?no=<%= no %>&pg=<%= pg %>" class="btn btnRemove">삭제</a>
	            <a href="/Jboard1/modify.jsp?no=<%= no %>&pg=<%= pg %>" class="btn btnModify">수정</a>
	            <%} %>
	            <a href="/Jboard1/list.jsp?pg=<%= pg %>" class="btn btnList">목록</a>
	        </div>
	
	        <!-- 댓글 목록 -->
	        <section class="commentList">
	            <h3>댓글목록</h3>
	            
	            <% for(ArticleBean comment : comments){ %>
	            <article>
	                <span class="nick"><%= comment.getNick() %></span>
	                <span class="date"><%= comment.getRdate() %></span>
	                <p class="content"><%= comment.getContent() %></p>
	                <% if(ub.getUid().equals(comment.getUid())){ %>
	                <div>
	                    <a href="#" class="remove" data-no="<%= comment.getNo()%>">삭제</a>
	                    <a href="#" class="modify" data-no="<%= comment.getNo() %>">수정</a>
	                </div>
	                <%} %>
	            </article>
	            <%} %>
	            <p class="empty">등록된 댓글이 없습니다.</p>
	        </section>
	
	        <!-- 댓글 쓰기 -->
	        <section class="commentForm">
	            <h3>댓글쓰기</h3>
	            <form method="post">
	                <input type="hidden" name="uid" value="<%= ub.getUid() %>">
	                <input type="hidden" name="no" value="<%= no %>">
	                <textarea name="content" placeholder="댓글내용 입력하세요."></textarea>
	                <div>
	                    <a href="#" class="btn btnCalcel">취소</a>
	                    <input type="submit" value="작성완료"  class="btn btnComplete">
	                </div>
	            </form>
	
	        </section>
	    </section>
 <%@ include file="_footer.jsp" %>