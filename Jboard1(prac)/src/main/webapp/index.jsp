<%@page import="org.slf4j.Logger"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="kr.co.jboard1.bean.UserBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	//자바 기본 로거
	java.util.logging.Logger _logger = java.util.logging.Logger.getGlobal(); 	

	_logger.info("info log...");	
	_logger.warning("warning log...");	
	_logger.severe("severe log...");	

	// logback 로거
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	logger.debug("log debug...");
	logger.info("log info...");
	logger.warn("log warn...");
	logger.error("log error...");

	UserBean sessUesr = (UserBean)session.getAttribute("sessUser");
	
	if(sessUesr == null){
		// 로그인을 안했으면
		pageContext.forward("./user/login.jsp");
	} else {
		// 로그인을 했으면
		pageContext.forward("./list.jsp");
	}
	
%>