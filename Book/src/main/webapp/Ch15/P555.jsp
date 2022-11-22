<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>웹소켓 채팅</title>
		<%--
			날짜 : 2022/11/22
			이름 : 서정현
			내용 : 채팅창(1)
		--%>
	</head>
	<body>
		대화명 : <input type="text" id="chatId" value="${param.chatId}" readonly>
		<button id="closeBtn" onclick="disconnect();">채팅종료</button>
		<div id="chatWindow"></div>
		<div>
			<input type="text" id="chatMessage" onkeyup="enterKey();">
		</div>
	</body>
</html>