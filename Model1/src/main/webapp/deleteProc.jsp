<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%@ include file="loginCheck.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	int num = Integer.parseInt(request.getParameter("num"));
	
	String loginId = (String)session.getAttribute("id");
	
	if(id != null){
		if(!loginId.equals(id)){
			JSFunction.alertBack("본인이 작성한 게시물만 삭제 가능합니다.", out);
			return;
		}
	} else {
		JSFunction.alertBack("비정상적인 접근입니다.", out);
		return;
	}
	
	BoardDAO dao = new BoardDAO();
	BoardDTO dto = new BoardDTO();
	dto.setNum(num);
	
	int result = dao.deletePost(dto);
	
	if(result == 1){
		response.sendRedirect("list.jsp");
	} else {
		JSFunction.alertBack("삭제에 실패했습니다.", out);
	}
	
%>