<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%@ include file="loginCheck.jsp" %>
<%	
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// 데이터베이스 작업
	BoardDAO dao = new BoardDAO();
	BoardDTO dto = new BoardDTO();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);
	
	int result = dao.updateEdit(dto);
	
	dao.close();
	
	if(result == 1){
		response.sendRedirect("view.jsp?num=" + num);
		return;
	} else {
		JSFunction.alertBack("게시물 수정에 실패 했습니다.", out);
	}
%>