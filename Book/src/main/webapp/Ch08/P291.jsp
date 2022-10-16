<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	String num = request.getParameter("num"); // 일련번호 받기
	
	BoardDAO dao = new BoardDAO(application); // DAO 생성
	dao.updateVisitCount(num); 				  // 조회수 증가
	BoardDTO dto = dao.selectview(num); 	  // 게시물 가져오기
	dao.close();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원제 게시판 - 상세 보기</title>
		<%--
			날짜 : 2022/10/16
			이름 : 서정현
			내용 : 상세 보기 페이지
		--%>
		<style>
			*{padding: 0; margin:0;}
			#wrapper{ width: 900px; height: auto; margin: auto; }
			table {width: 100%; height: auto;}
			th {text-align: center}
			td {padding-left: 5px;}
		</style>
	</head>
	<body>
		<div id="wrapper">
			<jsp:include page="P225.jsp"/>
			<h2>회원제 게시판 상세 보기(View)</h2>
			<form name="writeFrm">
				<input type="hidden" name="num" value="<%= num %>">
				<table border="1">
					<tr>
						<th>번호</th>
						<td><%= dto.getNum() %></td>
						<th>작성자</th>
						<td><%= dto.getName() %></td>
					</tr>
					<tr>
						<th>작성일</th>
						<td><%= dto.getPostdate() %></td>
						<th>조회수</th>
						<td><%= dto.getVisitcount() %></td>
					</tr>
					<tr>
						<th>제목</th>
						<td colspan="3"><%= dto.getTitle() %></td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3" height="100">
							<%= dto.getContent().replace("\r\n", "<br/>") %>
						</td>
					</tr>
					<tr>
						<td colspan="4" align="right">
						<%
						if(session.getAttribute("id") != null 
							&& ((String)session.getAttribute("id")).equals(dto.getId())){
						%>
						<button type="button" onclick="location.href='P294.jsp?num=<%= num %>'">
							수정하기
						</button>
						<button type="button" >삭제하기</button>
						<%	
						}
						%>
						<button type="button" onclick="location.href='P273.jsp'">목록보기</button>
						</td>
					</tr>
				</table>
			</form>
		
		</div>
	</body>
</html>