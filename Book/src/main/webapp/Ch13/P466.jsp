<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>LifeCycle.jsp</title>
		<%--
			날짜 : 2022/10/28
			이름 : 서정현
			내용 : 수명주기 메서드 동작 확인
		--%>
		<script>
			function requestAction(frm, met) {
				if(met == 1){
					frm.method = "get";
				} else {
					frm.method = "post"
				}
				frm.submit();
			}
		</script>
	</head>
	<body>
		<h2>서블릿 수명주기(Life Cycle) 메서드</h2>
		<form action="./LifeCycle.do">
			<input type="button" value="Get 방식 요청하기" onclick="requestAction(this.form, 1)">
			<input type="button" value="post 방식 요청하기" onclick="requestAction(this.form, 2)">
		</form>
	</body>
</html>