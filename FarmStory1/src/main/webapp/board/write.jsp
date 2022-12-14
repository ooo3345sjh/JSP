<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	String pg = request.getParameter("pg");
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	
	pageContext.include("/board/_" + group + ".jsp");
%>
<script>
	smarteditor();
</script>
	<main id="board">
	    <section class="write">
	        <form action="/FarmStory1/board/proc/writeProc.jsp" method="post" enctype="multipart/form-data">
	        	<input type="hidden" name="uid" value="<%= user.getUid() %>">
	        	<input type="hidden" name="group" value="<%= group %>">
	        	<input type="hidden" name="cate" value="<%= cate %>">
	        	<input type="hidden"  name="img">
	            <table border="0">
	             <caption>글쓰기</caption>
	             <tr>
	                 <th>제목</th>
	                 <td><input type="text" name="title" placeholder="제목을 입력하세요."></td>
	             </tr>
	             <tr>
	                 <th>내용</th>
	                 <td>
	                     <textarea name="editorTxt" id="editorTxt" rows="20" cols="10" 
                            placeholder="내용을 입력해주세요" style="width: 100%"></textarea>
	                     <%-- <textarea name="content" placeholder="내용을 입력하세요." ></textarea>--%>
	                 </td>
	             </tr>
	             <tr>
	                 <th>첨부</th>
	                 <td>
	                     <input type="file" name="file">
	                 </td>
	             </tr>
	            </table>
	            <div>
	                <a href="./list.jsp?pg=<%= pg %>&group=<%= group %>&cate=<%= cate %>" class="btn btnCalcel">취소</a>
	                <input type="submit" value="작성완료" class="btn btnComplete">
	            </div>
	        </form>
	    </section>
	</main>
</article>
</section>
</div>
<%@ include file="/_footer.jsp" %>
        