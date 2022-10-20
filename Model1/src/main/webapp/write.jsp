<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%@ include file="loginCheck.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>write</title>
	</head>
	<style>
		*{padding: 0; margin: 0;}
		#wrapper{width: 900px; height: auto; margin: auto;}
		table{width: 100%; height: auto;}
		textarea, input {margin-left : 5px; padding: 2px;}
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script>
		$(function () {
			$('button[type=submit]').click(function() {
				let title = $('input[name=title]');
				let content = $('textarea[name=content]');
				if(title.val() == ""){
					alert('제목을 입력해주세요.');
					title.focus();
					return false;
				}				
				if(content.val() == ""){
					alert('내용을 입력해주세요.');
					content.focus();
					return false;
				}				
			});
		});
	</script>
	<body>
	<div id="wrapper">
		<jsp:include page="link.jsp"/>
		<h3>회원제 게시판 - 글쓰기(write)</h3>
		
		<form action="writeProc.jsp">
			<table border="1">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="title" style="width: 95%" placeholder="제목을 입력해주세요." autofocus>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="content" style="width: 95%; height: 100px;" placeholder="내용을 입력해주세요."></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button type="submit">작성 완료</button>
						<button type="reset">다시 입력</button>
						<button type="button" onclick="location.href='list.jsp'">목록 보기</button>
					</td>
				</tr>
			</table>
		</form>		
	</div>
	</body>
</html>