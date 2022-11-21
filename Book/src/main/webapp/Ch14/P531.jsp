<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>파일 첨부형 게시판</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
		
			$(function () {
				$('button[type=submit]').click(function () {
					if($('input[name=name]').val() == ""){ // 필수 항목 입력 확인
						alert('작성자를 입력하세요.');
						$('input[name=name]').focus();
						return false;
					}
					if($('input[name=title]').val() == ""){ 
						alert('제목을 입력하세요.');
						$('input[name=title]').focus();
						return false;
					}
					if($('textarea[name=content]').val() == ""){ 
						alert('내용을 입력하세요.');
						$('input[name=content]').focus();
						return false;
					}
				});
			});
		</script>
	</head>
	<body>
		<div id="wrapper">
			<h2>파일 첨부형 게시판 - 글수정(Update)</h2>
			<form name="writeFrm" method="post" enctype="multipart/form-data"
				action="/Book/Ch14/edit.do" onsubmit="return validateForm(this);">
				<input type="hidden" name="idx" value="${ dto.idx }">
				<input type="hidden" name="prevOfile" value="${ dto.ofile }">
				<input type="hidden" name="prevSfile" value="${ dto.sfile }">
				<table border="1">
					<tr>
						<td>작성자</td>
						<td>
							<input type="text" name="name" value="${dto.name}" step="width:150px;"/>
						</td>
					</tr>
					<tr>
						<td>제목</td>
						<td>
							<input type="text" name="title" value="${dto.title}" step="width:90%;"/>
						</td>
					</tr>
					<tr>
						<td>내용</td>
						<td>
							<textarea name="content" style="width:90%; height:100px">${ dto.content }</textarea>
						</td>
					</tr>
					<tr>
						<td>첨부 파일</td>
						<td>
							<input type="file" name="ofile"/>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<button type="submit">작성 완료</button>
							<button type="reset">RESET</button>
							<button type="button" onclick="location.href='/Book/Ch14/list.do'">
								목록 바로가기
							</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>