<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>파일 첨부형 게시판</title>
		<%--
			날짜 : 2022/11/11
			이름 : 서정현
			내용 : 비밀번호 입력 화면
		--%>
		<style>
			#wrapper{ width: 500px; margin: 0 auto;}
		</style>
		<script>
			function validateForm(form) {
				if(form.pass.value == ""){
					alert("비밀번호를 입력하세요.");
					form.pass.focus();
					return false;
				}
			}
		</script>
	</head>
	<body>
		<div id="wrapper">
			<h2>파일 첨부형 게시판 - 비밀번호 검증(Pass)</h2>
			<form name="WiteFrm" method="post" action="/Book/Ch14/pass.do" onsubmit="return validateForm">
				<input type="hidden" name="idx" value="${ param.idx }"/>
				<input type="hidden" name="mode" value="${ param.mode }"/>
				<table border="1" width="90%">
					<tr>
						<td align="center">비밀번호</td>
						<td>
							<input type="password" name="pass" style="width:90%"/>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="right">
							<button type="submit">검증하기</button>
							<button type="reset">RESET</button>
							<button type="button" onclick="location.href='/Book/Ch14/list.do'">목록 바로가기</button>
						</td>
					</tr>
				
				</table>
			</form>			
		</div>
	</body>
</html>