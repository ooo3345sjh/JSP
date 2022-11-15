<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>팜스토리::메인</title>
    </head>
    <link rel="stylesheet" href="/FarmStory1/css/style.css">
    <link rel="stylesheet" href="/FarmStory1/user/css/style.css">
    <link rel="stylesheet" href="/FarmStory1/board/css/style.css">
    <body>
        <div id="wrapper">
            <header>
                <a href="/FarmStory1/index.jsp" class="logo">
                    <img src="/FarmStory1/img/logo.png" alt="로고">
                </a>
                <p>
                    <a href="/FarmStory1/index.jsp">HOME |</a>
                    <a href="/FarmStory1/user/login.jsp">로그인 |</a>
                    <a href="/FarmStory1/user/terms.jsp">회원가입 |</a>
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
