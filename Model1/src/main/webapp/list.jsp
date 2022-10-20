<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	// 검색 내용이 있을 경우 전송되는 데이터
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	
	Map<String, Object> map = new HashMap<>();
	
	if(searchWord != null && !searchWord.equals("")){
		map.put("searchField", searchField);
		map.put("searchWord", searchWord);
	}
	
	BoardDAO dao = new BoardDAO();
	BoardDTO dto = new BoardDTO();
	
	List<BoardDTO> boards = new ArrayList<>();
	boards = dao.selectList(map); // 모든 게시물 조회
	int totalCount = dao.selectCount(map); // 게시물 총 갯수
	dao.close();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>list</title>
		<style>
			*{padding: 0; margin: 0;}
			#wrapper{width: 900px; height: auto; margin: auto;}
			table{width: 100%; height: auto;}
		</style>
	</head>
	<body>
		<div id="wrapper">
			<jsp:include page="link.jsp"/>
			<h3>목록 보기</h3>
			<form>
				<table border="1">
					<tr>
						<td align="center">
							<select name="searchField">
								<option value="title">제목</option>
								<option value="content">내용</option>
							</select>
							<input type="text" name="searchWord">
							<input type="submit" value="검색하기">
						</td>
					</tr>
				</table>
			</form>
			<table border="1">
				<tr>
					<th width="10%">번호</th>
					<th width="45%">제목</th>
					<th width="10%">작성자</th>
					<th width="10%">조회수</th>
					<th width="20%">작성일</th>
				</tr>
				<% 
					if(boards != null){
						for(BoardDTO board : boards){
							int num = totalCount--;
				%>
				<tr>
					<td align="center"><%= num %></td>
					<td><a href="view.jsp?num=<%= board.getNum()%>"><%= board.getTitle() %></a></td>
					<td align="center"><%= board.getId() %></td>
					<td align="center"><%= board.getVisitCount() %></td>
					<td align="center"><%= board.getPostdate() %></td>
				</tr>
				<%
						}
					}
				
				%>
				<tr>
					<td colspan="5" align="right"> 
						<button onclick="location.href='write.jsp'">글쓰기</button>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>