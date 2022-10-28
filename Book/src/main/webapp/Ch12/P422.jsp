<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>FileUpload</title>
		<%--
			날짜 : 2022/10/27
			이름 : 서정현
			내용 : 업로드용 폼 화면
		--%>
		<script>
			function vaildateFoem(form) {
				if(form.name.value == ""){
					alert("작성자를 입력하세요.");
					form.name.focus();
					return false;
				}
				if(form.title.value == ""){
					alert("제목을 입력하세요.");
					form.title.focus();
					return false;
				}
				if(form.arrtachedFile.value == ""){
					alert("첨부파일은 필수 입력입니다.");
					return false;
				}
			}
		</script>
	</head>
	<body>
		<h3>파일 업로드</h3>
		<span style="color: red;">${ errorMessage }</span>
		<form action="P430.jsp" name="fileForm" method="post" enctype="multipart/form-data"
			onsubmit="return validateForm">
			<table>
				<tr>
					<td>작성자</td>
					<td><input type="text" name="name" value="머스트해브"/></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" name="title"/></td>
				</tr>
				<tr>
					<td>카테고리(선택사항)</td>
					<td>
						<input type="checkbox" name="cate" value="사진" checked/>사진
						<input type="checkbox" name="cate" value="과제" />과제
						<input type="checkbox" name="cate" value="워드" />워드
						<input type="checkbox" name="cate" value="음원" />음원
					</td>
				</tr>
				<tr>
					<td colspan="2">첨부파일 : <input type="file" name="attachedFile"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="제출하기"></td>
				</tr>
				
			</table>
			
			</form>		
	</body>
</html>