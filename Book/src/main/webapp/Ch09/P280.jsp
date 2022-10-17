<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%@ include file="P279.jsp" %> <!-- 로그인 확인 -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원제 게시판</title>
		<%--
			날짜 : 2022/10/16
			이름 : 서정현
			내용 : 글쓰기 페이지
		--%>
		<style>
			*{padding: 0; margin:0;}
		 	#wrapper{ width: 900px; height: auto; margin: auto; }
		 	table {width: 100%; height: auto;}
			textarea{
				width: 95%;
				height: 100px;
				resize: none;
				margin: 5px;
				text-indent: 5px;
			}
			table td > input {
				width: 95%;
				margin: 5px;
				text-indent: 5px;
			}
		</style>
		<script>
			function vaildateForm(form) {
				if(form.title.value == ""){
					alert("제목을 입력하세요.");
					form.title.focus();
					return false;
				}
				if(form.content.value == ""){
					alert("내용을 입력하세요.");
					form.content.focus();
					return false;
				}
			}
		</script>
	</head>
	<body>
		<div id="wrapper">
			<jsp:include page="P225.jsp"/>
			<h2>회원제 게시판 - 글쓰기(Write)</h2>
			<form action="P283.jsp" onsubmit="return vaildateForm(this)">
				<table border="1">
					<tr>
						<td align="center">제목</td>
						<td>
							<input type="text" name="title" placeholder="제목을 입력해 주세요." autofocus>
						</td>
					</tr>
					<tr>
						<td align="center">내용</td>
						<td>
							<textarea name="content" placeholder="내용을 입력해 주세요."></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="right">
							<button type="submit">작성 완료</button>
							<button type="reset">다시 입력</button>
							<button type="button" onclick="location.href='P273.jsp'">목록보기</button>
						</td>
					</tr>
				</table>
			</form>
		</div>		
	</body>
</html>