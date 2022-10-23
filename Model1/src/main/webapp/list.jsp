<%@page import="util.BoardPage"%>
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
	String searchCheck = request.getParameter("searchCheck");
	
	Map<String, Object> param = new HashMap<>();
	BoardDAO dao = new BoardDAO();
	BoardDTO dto = new BoardDTO();
	
	if(searchCheck != null){
		if(searchCheck.equals("true")){
			session.setAttribute("searchField", searchField);		
			session.setAttribute("searchWord", searchWord);		
		} else {
			session.removeAttribute("searchField");
			session.removeAttribute("searchWord");
			//session.invalidate(); // 이건 하면 에러 뜸
		}
	}
	
	param.put("searchField", session.getAttribute("searchField"));
	param.put("searchWord", session.getAttribute("searchWord"));
	
	out.print(searchCheck);
	out.print(session.getAttribute("searchField"));
	out.print(session.getAttribute("searchWord"));
	int totalCount = dao.selectCount(param); // 게시물 총 갯수
	
	/*** 페이지 처리 start ***/
	// 전체 페이지 수 계산
	int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
	int blockPage = Integer.parseInt(application.getInitParameter("POSTS_PER_BLOCK"));
	int totalPage = (int)Math.ceil((double)totalCount/pageSize); // 전체 페이지 수
	
	// 현재 페이지 확인
	int pageNum = 1; // 기본값
	String pageTemp = request.getParameter("pageNum");
	if(pageTemp != null && !pageTemp.equals("")){
		pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 수정
	}
	
	// 목록에 출력할 게시물 범위 계산
	int start = (pageNum - 1) * pageSize + 1; // 첫 게시물 번호
	int end = pageNum * pageSize; // 마지막 게시물 번호
	param.put("start", start);
	param.put("end", end);
	/*** 페이지 처리 end ***/
	
	
	List<BoardDTO> boards = dao.selectListPage(param); // 게시물 목록 받기
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
		<script>
			function checkFrom(form) {
				if(form.searchWord.value != ""){
					form.searchCheck.value = 'true';
				}
			}
		
		</script>
	</head>
	<body>
		<div id="wrapper">
			<jsp:include page="link.jsp"/>
			<h3>목록 보기 - 현재 페이지 : <%= pageNum %> (전체 : <%= totalPage %>)</h3>
			<form onsubmit="checkFrom(this)">
				<table border="1">
					<tr>
						<td align="center">
							<select name="searchField">
								<option value="title">제목</option>
								<option value="content">내용</option>
							</select>
							<input type="text" name="searchWord">
							<input type="hidden" name='searchCheck' value='flase'>
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
					int countNum = 0;
					if(boards != null){
						for(BoardDTO board : boards){
							//int num = totalCount--;
							int num = totalCount - (((pageNum - 1) * pageSize) + countNum++);
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
					<td colspan="4" align="center">
						<%= BoardPage.paginStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI()) %>
					</td>
					<td align="right"> 
						<button onclick="location.href='write.jsp'">글쓰기</button>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>