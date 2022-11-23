<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/style.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/js/validation.js"></script>
	<script src="${pageContext.servletContext.contextPath}/js/zipcode.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- 우편번호 찾기 오픈 API -->
</head>
<body>
    <div id="wrapper">
        <header>
            <h3>Board System v2.0</h3>
        </header>
        