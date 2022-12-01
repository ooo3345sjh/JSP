<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="module" src='<c:url value='/js/phoneAuth.js'/>'></script>
</head>
<body>
	<form action="">
        핸드폰 번호 : <input type="text" id="phoneNumber">
        <button id="phoneNumberBtn">핸드폰 번호 전송</button>
    </form>
    
    <form action="">
        확인 코드 : <input type="text" id="confirmCode">    
        <button id="confirmCodeBtn">확인 코드 전송</button>
    </form>
</body>
</html>