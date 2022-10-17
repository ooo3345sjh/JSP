<%@page import="model1.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%--
	날짜 : 2022/10/16
	이름 : 서정현
	내용 : 게시물 목록을 출력하는 JSP(앞부분)
--%>
<%
	// DAO를 생성해 DB에 연결
	BoardDAO dao = new BoardDAO(application);

	// 사용자가 입력한 검색 조건을 Map에 저장
	Map<String, Object> param = new HashMap<String, Object>();
	
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	if(searchWord != null){
		param.put("searchField", searchField);
		param.put("searchWord", searchWord);
	}
	
	int totalCount = dao.selectCount(param); // 게시물 수 확인
	
	/*** 페이지 처리 start ***/
	// 전체 페이지 수 계산
	int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
	int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
	int totalPage = (int)Math.ceil((double)totalCount / pageSize); // 전체 페이지 수
	
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
	
	List<BoardDTO> boardLists = dao.selectList(param); // 게시물 목록 받기
	dao.close(); // DB 연결 닫기
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원제 게시판</title>
		<%--
			날짜 : 2022/10/16
			이름 : 서정현
			내용 : 게시물 목록을 출력하는 JSP(뒷부분)
		 --%>
		 <style>
		 	*{padding: 0; margin:0;}
		 	#wrapper{ width: 900px; height: auto; margin: auto; }
		 </style>
	</head>
	<body>
		<div id="wrapper">
			<jsp:include page="P225.jsp"/> <!-- 공통 링크 -->
			<h2>목록 보기(List)</h2>
			<form method="get">
				<table border="1" width="90%">
					<tr>
						<td align="center">
							<select name="searchField">
								<option value="title">제목</option>
								<option value="content">내용</option>
							</select>
							<input type="text" name="searchWord"/>
							<input type="submit" value="검색하기"/>
						</td>
					</tr>
				</table>
			</form>
			
			<!-- 게시물 목록 테이블(표) -->
			<table border="1" width="90%">
				<tr>
					<th width="10%">번호</th>
					<th width="45%">제목</th>
					<th width="15%">작성자</th>
					<th width="10%">조회수</th>
					<th width="20%">작성일</th>
				</tr>
				<!--  목록의 내용 -->
			<% 
			if(boardLists.isEmpty()){
				// 게시물이 하나도 없을 때
			%>
				<tr>
					<td colspan="5" align="center">
						 등록된  게시물이 없습니다^^*
					</td>
				</tr>
			<%
			}
			else {
				// 게시물이 있을 때
				int virtualNum = 0; // 화면상에서의 게시물 번호
				for(BoardDTO dto : boardLists){
					virtualNum = totalCount--; // 전체 게시물 수에서 시작해 1씩 감소
			%>
				<tr>
					<td align="center"><%= virtualNum %></td> <!-- 게시물 번호 -->
					<td align="left"><a href="P291.jsp?num=<%= dto.getNum()%>"><%= dto.getTitle() %></a> </td> <!-- 제목(+ 하이퍼링크) -->
					<td align="center"><%= dto.getId() %></td> <!--  작성자 아이디 -->
					<td align="center"><%= dto.getVisitcount() %></td> <!--  조회수 -->
					<td align="center"><%= dto.getPostdate() %></td> <!--  작성자일 -->
				</tr>
			<%
				}
			}
			%>
			</table>
			<!-- 목록 하단의 [글쓰기] 버튼 -->
			<table border="1" width="90%">
				<tr align="right">
					<td><button type="button" onclick="location.href='P280.jsp'">글쓰기</button></td>
				</tr>		
			</table>
		</div>
	</body>
</html>
