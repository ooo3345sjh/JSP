<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<%@ include file="P279.jsp"%> <!-- 로그인 확인 -->
<%
	// 수정 내용 얻기
	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String content = request.getParameter("content");

%>