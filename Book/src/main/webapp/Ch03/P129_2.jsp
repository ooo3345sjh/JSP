<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<!-- 
			날짜 : 2022/10/07
			이름 : 서정현
			내용 : 링크를 클릭해 이동된 페이지
		-->
	</head>
	<body>
		<h2>페이지 이동 후 session 영역의 속성 읽기</h2>
		<%
			ArrayList<String> lists = (ArrayList<String>)session.getAttribute("lists");
			if(lists == null) out.print("데이터가 존재하지 않습니다."); 
			else{
				for(String str : lists){
					out.print(str + "<br/>");
				}				
			}
		%>		
	</body>
</html>