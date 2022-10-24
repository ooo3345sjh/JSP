<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	// 예시에서 사용할 변수 선언
	int num1 = 3;
	pageContext.setAttribute("num2", 4);
	pageContext.setAttribute("num3", "5");
	pageContext.setAttribute("num4", "8");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>표현 언어(EL) - 연산자</title>
		<%--
			날짜 : 2022/10/23
			이름 : 서정현
			내용 : 각종 연산자 사용 예1
		--%>
	</head>
	<body>
		<h3>변수 선언 및 할당</h3>
		<ul>
			<li>스크립틀릿에서 선언한 변수 : ${ num1 }</li>
			<li>page 영역에 저장된 변수 : ${ num2 }</li>
			<li>변수 할당 및 즉시 출력 : ${ num1 = 7 }</li>
			<li>변수 할당 및 별도 출력 : ${ num2 = 9;'' } => ${ num2 }</li>
			<li>num1 = ${ num1 }, num2 = ${ num2 }, num3 = ${ num3 }, num4 = ${num4 }</li>
		</ul>
		
		<h3>산술 연산자</h3>
		<ul>
			<li>num1 + num2 : ${ num1 + num2 }</li>
			<li>num1 - num2 : ${ num1 - num2 }</li>
			<li>num1 * num2 : ${ num1 * num2 }</li>
			<li>num3 / num4 : ${ num3 / num4 }</li>
			<li>num3 div num4 : ${ num3 div num4 }</li>
			<li>num3 % num4 : ${ num3 % num4 }</li>
			<li>num3 mod num4 : ${ num3 mod num4 }</li>
		</ul>
		
		<h3>+ 연산자는 덧셈만 가능</h3>
		<ul>
			<li>num1 + "34" : ${ num1 + "34" }</li>
			<li>num2 + "이십" : \${ num2 + "이십" }<!-- 에러 발생(주석 처리) --></li>
			<li>"삼십" + "삼십" : \${ "삼십" + "사십" }<!-- 에러 발생(주석 처리) --></li>
		</ul>

		<h3>비교 연산자</h3>
		<ul>
			<li>num4 > num3 : ${ num4 gt num3 }</li>
			<li>num1 < num3 : ${ num1 lt num3 }</li>
			<li>num2 >= num4 : ${ num2 ge num4 }</li>
			<li>num1 == num4 : ${ num1 eq num4 }</li>
		</ul>

		<h3>논리 연산자</h3>
		<ul>
			<li>num3 <= num4 && num3 == num4 : ${ num3 le num4 and num3 eq num4 }</li>
			<li>num3 >= num4 || num3 != num4 : ${ num3 ge num4 or num3 ne num4 }</li>
		</ul>
		
	</body>
</html>