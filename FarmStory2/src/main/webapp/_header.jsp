<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>팜스토리</title>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css"/>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/board/css/style.css'/>"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>    
    <script>
        $(function(){
            $('.slider > ul').bxSlider({
                slideWidth: 980,
                pager: false,
                controls: false,
                auto: true
            });

            $('#tabs').tabs();
            
        });
    </script>
</head>
<body>
    <div id="wrapper">
        <header>
            <a href='<c:url value='/'/>' class="logo"><img src="<c:url value='/img/logo.png'/>" alt="로고"/></a>
            <p>
                <a href='<c:url value='/'/>'>HOME |</a>
               	<c:choose>
               		<c:when test="${not empty reqUser}">
		                <a>${reqUser.nick}님 반갑습니다. </a>
		                <a href='<c:url value='/user/info.do'/>'>회원정보 |</a>
		                <a href='<c:url value='/user/logout.do'/>'>로그아웃 |</a>
               		</c:when>
               		<c:otherwise>
		                <a href='<c:url value='/user/login.do'/>'>로그인 |</a>
		                <a href='<c:url value='/user/terms.do'/>'>회원가입 |</a>
               		</c:otherwise>
               	</c:choose>
                <a href='<c:url value='/board/list.do?group=community&cate=4'/>'>고객센터</a>
            </p>
            <img src="<c:url value='/img/head_txt_img.png'/>" alt="3만원 이상 무료배송"/>
            
            <ul class="gnb">
                <li><a href='<c:url value='/introduction/hello.do'/>'>팜스토리소개</a></li>
                <li><a href='<c:url value='/board/list.do?group=market&cate=1'/>'><img src="<c:url value='/img/head_menu_badge.png'/>" alt="30%"/>장보기</a></li>
                <li><a href='<c:url value='/board/list.do?group=croptalk&cate=1'/>'>농작물이야기</a></li>
                <li><a href='<c:url value='/board/list.do?group=event&cate=1'/>'>이벤트</a></li>
                <li><a href='<c:url value='/board/list.do?group=community&cate=1'/>'>커뮤니티</a></li>
            </ul>
        </header>