<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalDate"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%--
	날짜 : 2022/10/05
	이름 : 서정현
	내용 : 공통 UI요소를 담은 JSP 파일(포함될 파일)
--%>

<%
	LocalDate today = LocalDate.now(); //오늘 날짜
	LocalDateTime tomorrow = LocalDateTime.now().plusDays(1); //내일 날짜
%>