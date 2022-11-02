<%@page import="kr.co.jboard1.bean.UserBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	UserBean ub = (UserBean)session.getAttribute("sessUser"); 
	if(ub == null){
		response.sendRedirect("/Jboard1/user/login.jsp?success=101");
		return;
	}
	String result =  request.getParameter("result");
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>글목록</title>
</head>
<link rel="stylesheet" href="./css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	let result = "<%= result %>";
	if(result == '202'){
		alert('수정완료');
	} else if (result == '201'){
		alert('삭제완료');
	}
</script>
<body>
    <div id="wrapper">
        <header>
            <h3>Board System v1.0</h3>
            <p>
                <span><%= ub.getNick() %></span>님 반갑습니다.
                <a href="/Jboard1/user/proc/logoutProc.jsp">[로그아웃]</a>
            </p>
        </header>