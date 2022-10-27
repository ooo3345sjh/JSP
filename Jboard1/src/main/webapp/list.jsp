<%@page import="com.mysql.cj.util.LazyString"%>
<%@page import="org.apache.el.util.ConcurrentCache"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.protocol.Resultset"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
    String pg = request.getParameter("pg");

	int limitStart = 0; // 현재 페이지에서 시작하는 게시물 시작값
	int currentPage = 1; // 현재 페이지
	int total = 0; // 게시물 총 개수
	int lastPageNum = 0; // 마지막 페이지
	int pageGroupCurent = 1; // 그룹 번호
	int pageGroupStart = 1; // 그룹에서 첫페이지
	int pageGroupEnd = 0; // 그룹에서 마지막페이지
	int pageStartNum = 0; // 게시물의 번호 정렬
	
	ArticleDAO dao = ArticleDAO.getInstance();
	
	// 전체 게시물 갯수 구하기
	total = dao.selectCountTotal();
	
	// 페이지 마지막 번호 계산
	lastPageNum = (int)Math.ceil(((double)total) / 10);
	
	// 현재 페이지 게시물 limit 시작값 계산
	if(pg != null){
		currentPage = Integer.parseInt(pg);
	}
	limitStart = (currentPage - 1) * 10;
	
	// 페이지 그룹 계산
	pageGroupCurent = (int)Math.ceil(currentPage / 10.0);
	pageGroupStart = (pageGroupCurent - 1) * 10 + 1;
	pageGroupEnd = pageGroupCurent * 10;
	
	if(pageGroupEnd > lastPageNum){
		pageGroupEnd = lastPageNum;
	}
	
	// 페이지 시작 번호 계산
	pageStartNum = total - limitStart;
	
	// 현재 페이지 게시물 가져오기
	List<ArticleBean> articles = dao.selectArticles(limitStart);
%>
<%@ include file="_header.jsp" %>
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
	                <% for(ArticleBean ab : articles){ %>
	                <tr>
	                    <td><%= pageStartNum-- %></td>
	                    <td><a href="/Jboard1/view.jsp"><%= ab.getTitle() %>[<%= ab.getComment() %>]</a></td>
	                    <td><%= ab.getNick() %></td>
	                    <td><%= ab.getRdate() %></td>
	                    <td><%= ab.getHit() %></td>
	                </tr>
	                <%
	                }
	                %>
	            </table>
	            <div class="page">
	            	<% if(pageGroupStart > 1){ %>
	                <a href="list.jsp?pg=<%= pageGroupStart-1 %>" class="prev">이전</a>
	                <% } %>
	                <% for(int i=pageGroupStart; i<=pageGroupEnd; i++){ %>
	                <a href="/Jboard1/list.jsp?pg=<%= i %>" class="num <%= (i == currentPage)? "current":"off" %>"><%= i %></a>
	                <%} %>
	                <% if(pageGroupEnd < lastPageNum){ %>
	                <a href="list.jsp?pg=<%= pageGroupEnd + 1 %>" class="next">다음</a>
	                <%} %>
	            </div>
	            <a href="/Jboard1/write.jsp" class="btn btnWrite">글쓰기</a>
	        </form>
	    </section>
	</main>
<%@ include file="_footer.jsp" %>
      