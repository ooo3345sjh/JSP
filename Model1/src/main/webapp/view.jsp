<%@page import="util.JSFunction"%>
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
	String num = request.getParameter("num"); // 일련번호 받기
	
	if(num == null){
		JSFunction.alertBack("비정상적인 접근입니다.", out);
		return;
	}
	
	BoardDAO dao = new BoardDAO();
	BoardDTO dto = new BoardDTO();
	dao.updateVisitCount(num); // 조회수 증가
	dto = dao.selectView(num);  // 게시물 가져오기
	dao.close(); // DB 연결해제
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>view</title>
		<style>
			*{padding: 0; margin: 0;}
			#wrapper{width: 900px; height: auto; margin: auto;}
			table{width: 100%; height: auto;}
		</style>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function () {
				$('#btnModify').click(function (e) {
					let title = $('#title').text();
					let content = $('#content').text();
					
					location.href = 'modify.jsp?'
								  + 'title=' + title
								  + '&content=' + content
								  + '&num=' + <%=num%>
								  + '&id=' + '<%=dto.getId()%>';
					return;
				});
				
				$('#btnDelete').click(function () {
					let checkDelete = confirm('정말 삭제하시겠습니까?');
					
					if(checkDelete){
						location.href = 'deleteProc.jsp?'
								      + 'id=' + '<%= dto.getId() %>'
								      + '&num=' + <%= num %>;
						return;
					} 
				});
			});
		</script>
	</head>
	<body>
		<div id="wrapper">
			<jsp:include page="link.jsp"/>
			<h3>목록 보기</h3>
			<table border="1">
				<tr>
					<td>번호</td>
					<td><%= dto.getNum() %></td>
					<td>작성자</td>
					<td><%= dto.getName() %></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><%= dto.getPostdate() %></td>
					<td>조회수</td>
					<td><%= dto.getVisitCount() %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3" id="title"><%= dto.getTitle() %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3" id="content"><%= dto.getContent() %></td>
				</tr>
				<tr>
					<td colspan="4" align="center">
						<%
							if(session.getAttribute("id") != null){
								if(session.getAttribute("id").equals(dto.getId())){
						%>
						<button id='btnModify'>수정하기</button>
						<button id='btnDelete'>삭제하기</button>
						<%
								}
							}
						%>
						<button onclick="location.href='list.jsp'">목록하기</button>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>