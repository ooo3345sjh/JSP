<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>FrontController.jsp</title>
		<%--
			날짜 : 2022/10/28
			이름 : 서정현
			내용 : 한 번의 매핑으로 여러 가지 요청 처리
		--%>
	</head>
	<body>
		<h3>한 번의 매핑으로 여러 가지 요청 처리하기</h3>
		${ resultValue }
		<ol>
			<li>URI : ${ uri }</li>
			<li>요청명 : ${ commandStr }</li>
		</ol>
		<ul>
			<li><a href="../Ch13/regist.one">회원가입</a> </li>
			<li><a href="../Ch13/login.one">로그인</a> </li>
			<li><a href="../Ch13/freeboard.one">자유게시판</a></li>
		</ul>
	</body>
</html>