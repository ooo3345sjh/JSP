<%@page import="java.net.URLEncoder"%>
<%@page import="fileupload.MyfileDTO"%>
<%@page import="java.util.List"%>
<%@page import="fileupload.MyfileDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	MyfileDAO dao = new MyfileDAO();
	List<MyfileDTO> fileLists = dao.myFileList();
	dao.close();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<%--
			날짜 : 2022/10/27
			이름 : 서정현
			내용 : 파일 목록 출력 JSP
		--%>
	</head>
	<body>
		<h2>DB에 등록된 파일 목록 쓰기</h2>
		<a href="P422.jsp">파일 등록하기</a>
		<table border="1">
			<tr>
				<th>NO</th>
				<th>작성자</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>원본 파일명</th>
				<th>저장된 파일명</th>
				<th>작성일</th>
				<th>다운</th>
			</tr>
			<% for(MyfileDTO dto : fileLists){ %>
			<tr>
				<td><%= dto.getIdx() %> </td>
				<td><%= dto.getName() %> </td>
				<td><%= dto.getTitle() %> </td>
				<td><%= dto.getCate() %> </td>
				<td><%= dto.getOfile() %> </td>
				<td><%= dto.getSfile() %> </td>
				<td><%= dto.getPostdate() %> </td>
				<td><a href="P439.jsp?oName=<%= URLEncoder.encode(dto.getOfile(), "utf-8") %>
				&sName=<%= URLEncoder.encode(dto.getSfile(), "UTF-8")%>">[다운로드]</a></td>
			</tr>
			<%} %>
			
		</table>
		
	</body>
</html>