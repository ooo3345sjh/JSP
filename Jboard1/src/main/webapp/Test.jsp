<%@page import="java.io.File"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String realPath = application.getRealPath("/smartEditor/tmp");
	File file = new File(realPath);
	
	String[] fileNames = file.list();
	for(String filename : fileNames){
		System.out.println("filename : " + filename);
	}






%>