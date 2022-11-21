<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.io.File"%>
<%@page import="kr.co.FarmStory1.vo.ArticleVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.FarmStory1.dao.BoardDAO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	String pg = request.getParameter("pg");
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	BoardDAO dao = new BoardDAO();
	
	/* 페이지 Start */
	int limitStart = 0; // 현재 페이지에서 시작하는 게시물 시작값
	int currentPage = 1; // 현재 페이지
	int total = 0; // 게시물 총 개수
	int lastPageNum = 0; // 마지막 페이지
	int pageGroupCurrent = 1; // 그룹 번호
	int pageGroupStart = 1; // 그룹에서 첫 페이지
	int pageGroupEnd = 0; // 그룹에서 마지막 페이지
	int pageStartNum = 0; // 게시물의 번호 정렬
	
	// 전체 게시물 갯수 구하기
	total = dao.selectArticleCountTotal(cate);
	
	// 페이지 마지막 번호 계산 
	lastPageNum = (int)Math.ceil(total / 10.0);
	
	// 현재 페이지 게시물 limit 시작값 계산
	if(pg != null){
		currentPage = Integer.parseInt(pg);
	}
	limitStart = (currentPage - 1) * 10;
	
	// 페이지 그룹 계산
	pageGroupCurrent = (int)Math.ceil(currentPage / 10.0);
	pageGroupStart = (pageGroupCurrent -1) * 10 + 1;
	pageGroupEnd = pageGroupCurrent * 10;
	
	if(pageGroupEnd > lastPageNum){
		pageGroupEnd = lastPageNum;
	}
	
	// 페이지 시작 번호 계산
	pageStartNum = total - limitStart;
	
	// 현재 페이지 게시물 가져오기
	List<ArticleVO> articles = dao.selectArticles(cate, limitStart);
	
	
	/* 페이지 End */

	// 리스트에 오면 임시 저장소 삭제 
	String realPath = application.getRealPath("/");
	File temp = new File(realPath, "/board/smartEditor/temp");
	if(temp.exists()){
		FileUtils.deleteDirectory(temp);
	}
	
	pageContext.include("/board/_" + group + ".jsp");
	
%>
			<main id="board">
			    <section class="list">
			        <form action="#">
			            <table border="0">
			                <caption>글목록</caption>
			                <tr>
			                    <th>번호</th>
			                    <th>제목</th>
			                    <th>글쓴이</th>
			                    <th>날짜</th>
			                    <th>조회</th>
			                </tr>
			                <%
			                if(articles.size() == 0){
			                %>
			                <tr>
			                	<td colspan="5">등록된 글이 없습니다.</td>
			                </tr>
			                <%	
			                }else {
				                for(ArticleVO vo : articles){
			                
			                %>
				                <tr>
				                    <td><%= pageStartNum-- %></td>
				                    <td>
				                    	<a href="./view.jsp?no=<%= vo.getNo() %>&pg=<%= currentPage %>&group=<%= group %>&cate=<%= cate %>">
				                    		<%= vo.getTitle() %>[<%= vo.getComment() %>]
				                    	</a>
				                    </td>
				                    <td><%= vo.getNick() %></td>
				                    <td><%= vo.getRdate().substring(2, 10) %></td>
				                    <td><%= vo.getHit() %></td>
				                </tr>
			                <%
				                }
			                }
			                %>
			            </table>
			            <div class="page">
			            <% if(pageGroupStart > 1){ %>
			                <a href="./list.jsp?pg=<%= pageGroupStart-1 %>&group=<%= group %>&cate=<%= cate %>" class="prev">이전</a>
			            <% }%>
			            <% for(int i=pageGroupStart; i<=pageGroupEnd; i++){ %>
			                <a href="./list.jsp?pg=<%= i %>&group=<%= group %>&cate=<%= cate %>" class="num <%= (i == currentPage) ? "current":"off"%>"><%= i %></a>
			            <% } %>
			            <%if(pageGroupEnd < lastPageNum){ %>
			                <a href="./list.jsp?pg=<%= pageGroupEnd + 1 %>&group=<%= group %>&cate=<%= cate %>" class="next">다음</a>
			             <%} %>
			            </div>
			            <a href="./write.jsp?pg=<%= currentPage %>&group=<%= group %>&cate=<%= cate %>" class="btn btnWrite">글쓰기</a>
			        </form>
			    </section>
			</main>

		</article>
    </section>
</div>
<%@ include file="/_footer.jsp" %>