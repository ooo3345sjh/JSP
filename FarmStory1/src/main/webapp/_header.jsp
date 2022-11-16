<%@page import="kr.co.FarmStory1.vo.UserVO"%>
<%@page import="kr.co.FarmStory1.utils.JSFunction"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	UserVO user = (UserVO)session.getAttribute("user");
	String uri = request.getRequestURI();
	
	if(uri.contains("register.jsp")){
		JSFunction.alertLocation("비정상적인 접근입니다.", "/FarmStory1/user/login.jsp", out);
		return;
	}
	
	if(uri.contains("write.jsp") || uri.contains("modify.jsp") || uri.contains("delete.jsp")){
		if(user == null){
			JSFunction.alertLocation("해당 페이지는 로그인이 필요합니다.", "/FarmStory1/user/login.jsp", out);
			return;
		}
	} else if(uri.contains("login.jsp") && user != null){
		JSFunction.alertLocation("이미 로그인되어있습니다.", "/FarmStory1/index.jsp", out);
		return;
	} else if(uri.contains("terms.jsp") && user != null){
		JSFunction.alertLocation("로그아웃후에 회원가입해주세요.", "/FarmStory1/index.jsp", out);
		return;
	}

%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>팜스토리::메인</title>
	    <link rel="stylesheet" href="/FarmStory1/css/style.css">
	    <link rel="stylesheet" href="/FarmStory1/user/css/style.css">
	    <link rel="stylesheet" href="/FarmStory1/board/css/style.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    </head>
    <body>
        <div id="wrapper">
            <header>
                <a href="/FarmStory1/index.jsp" class="logo">
                    <img src="/FarmStory1/img/logo.png" alt="로고">
                </a>
                <p>
                    <a href="/FarmStory1/index.jsp">HOME |</a>
                    <% if(user != null){ %>
                    <a href="/FarmStory1/user/proc/logoutProc.jsp">로그아웃 |</a>
                    <% } else { %>
                    <a href="/FarmStory1/user/login.jsp">로그인 |</a>
                    <a href="/FarmStory1/user/terms.jsp">회원가입 |</a>
                    <% } %>
                    <a href="#">고객센터</a>
                </p>
                <ul class="gnb">
                    <li><a href="/FarmStory1/introduction/hello.jsp">팜스토리 소개</a></li>
                    <li><a href="/FarmStory1/board/list.jsp?group=market&cate=market">
                        <img src="/FarmStory1/img/head_menu_badge.png" alt="30%">
                        장보기
                    </a></li>
                    <li><a href="/FarmStory1/board/list.jsp?group=croptalk&cate=story">농작물이야기</a></li>
                    <li><a href="/FarmStory1/board/list.jsp?group=event&cate=event">이벤트</a></li>
                    <li><a href="/FarmStory1/board/list.jsp?group=community&cate=notice">커뮤니티</a></li>
                </ul>
                <img src="/FarmStory1/img/head_txt_img.png" alt="3만원 이상 무료배송">
            </header>
