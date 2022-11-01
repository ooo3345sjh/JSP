<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>파일 첨부형 게시판</title>
		<%--
			날짜 : 2022/11/01
			이름 : 서정현
			내용 : 글쓰기 폼 JSP
		--%>
		<style>
			#wrapper { width: 800px; height: auto; margin: auto; }
			form {width: 100%;}
			table {width: 100%;}
		</style>
		<script>
			function validateForm(form) {
				if(form.name.value == ""){ // 필수 항목 입력 확인
					alert('작성자를 입력하세요.');
					from.name.focus();
					return false;
				}
				if(form.title.value == ""){
					alert('제목을 입력하세요.');
					from.title.focus();
					return false;
				}
				if(form.content.value == ""){
					alert('내용을 입력하세요.');
					from.content.focus();
					return false;
				}
				if(form.pass.value == ""){
					alert('비밀번호를 입력하세요.');
					from.pass.focus();
					return false;
				}
				
			}
		</script>
	</head>
	<body>
		<div id="wrapper">
			<h2>파일 첨부형 게시판 - 글쓰기(Write)</h2>
			<form name="writeFrm" method="post" enctype="multipart/form-data"
				action="/Book/mvcboard/write.do" onsubmit="return validateForm(this);">
				<table border="1">
					<tr>
						<td>작성자</td>
						<td>
							<input type="text" name="name" step="width:150px;"/>
						</td>
					</tr>
					<tr>
						<td>제목</td>
						<td>
							<input type="text" name="title" step="width:90%;"/>
						</td>
					</tr>
					<tr>
						<td>내용</td>
						<td>
							<textarea name="content" style="width:90%; height:100px"></textarea>
						</td>
					</tr>
					<tr>
						<td>첨부 파일</td>
						<td>
							<input type="file" name="ofile"/>
						</td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td>
							<input type="password" name="pass" style="width:100px"/>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<button type="submit">작성 완료</button>
							<button type="reset">RESET</button>
							<button type="button" onclick="location.href='/Book/mvcboard/list.do'">
								목록 바로가기
							</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>