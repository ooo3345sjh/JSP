<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%@ include file="loginCheck.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
 	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	BoardDTO dto = new BoardDTO();
	dto.setTitle(title);
	dto.setContent(content);
	dto.setId((String)session.getAttribute("id"));
	
	BoardDAO dao = new BoardDAO();
	int result = dao.insertWrite(dto);
	
	if(result == 1){
		response.sendRedirect("list.jsp");
		return;
	} else {
		JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
	}

%>