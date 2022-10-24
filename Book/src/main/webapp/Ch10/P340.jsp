<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>표현 언어(EL) - 내장 객체</title>
		<%--
			날짜 : 2022/10/23
			이름 : 서정현
			내용 : 포워드된 페이지
		--%>
	</head>
	<body>
		<h2>ImplicitForwradResult</h2>
		<h3>각 영역에 저장된 속성 읽기</h3>
		<ul>
			<li>페이지 영역 : ${ pageScope.scopeValue }</li>
			<li>리퀘스트 영역 : ${ requestScope.scopeValue }</li>
			<li>세션 영역 : ${ sessionScope.scopeValue }</li>
			<li>애플리케이션 영역 : ${ applicationScope.scopeValue }</li>
		</ul>
		<h3>영역 지정 없이 속성 읽기</h3>
		<ul>
			<li>${ scopeValue }</li>
		</ul>
	</body>
</html>