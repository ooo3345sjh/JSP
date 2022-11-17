<%@page import="kr.co.FarmStory1.vo.ArticleVO"%>
<%@page import="kr.co.FarmStory1.dao.BoardDAO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	ArticleVO vo = BoardDAO.getInstance().selectArticle(no);
	
	pageContext.include("/board/_" + group + ".jsp");
%>
<script>
	smarteditor();
</script>
	<main id="board">
	    <section class="modify">
	        <form action="./proc/modifyProc.jsp?">
	        	<input type="hidden" name="no" value="<%= no %>">
	        	<input type="hidden" name="pg" value="<%= pg %>">
	        	<input type="hidden" name="group" value="<%= group %>">
	        	<input type="hidden" name="cate" value="<%= cate %>">
	            <table border="0">
	             <caption>글수정</caption>
	             <tr>
	                 <th>제목</th>
	                 <td><input type="text" name="title" placeholder="제목을 입력하세요." value="<%= vo.getTitle() %>"></td>
	             </tr>
	             <tr>
	                 <th>내용</th>
	                 <td>
	                  	<textarea name="editorTxt" id="editorTxt" rows="20" cols="10" 
                            	laceholder="내용을 입력해주세요" style="width: 100%"><%= vo.getContent() %></textarea>
	                     <%-- <textarea name="content" ><%= vo.getContent() %></textarea> --%>
	                 </td>
	             </tr>
	           <%-- 수정시 첨부파일도 새로 바꿀 수 있도록 구현 예정
	             <tr>
	                 <th>첨부</th>
	                 <td>
	                     <input type="file" name="file">
	                 </td>
	             </tr>
	            --%>
	            </table>
	            <div>
	                <a href="./view.jsp?no=<%= no %>&group=<%= group %>&cate=<%= cate %>&pg=<%= pg %>" class="btn btnCalcel"">취소</a>
	                <input type="submit" value="수정완료" class="btn btnComplete">
	            </div>
	        </form>
	    </section>
	</main>
</article>
</section>
</div>
<%@ include file="/_footer.jsp" %>