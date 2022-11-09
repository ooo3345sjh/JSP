<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>college::lecture</title>
<style>
	td {text-align: center;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="/College/js/lecture.js"></script>
<script>
	$(function () {
		
		// 강좌 등록 창 숨기기
		insertInputHide();
		
		// 강좌 리스트 목록 출력
		list();
		
		// 등록/닫기 버튼을 클릭시 강좌 등록 창 보이기/숨기기
		submitInputShowHide();
		
		// 강좌 DB추가
		submit();
	});
</script>
</head>
<body>
	<h2>강좌관리</h2>
	<a href="/College/lecture.jsp">강좌관리</a>&nbsp;
	<a href="/College/register.jsp">수강관리</a>&nbsp;
	<a href="/College/student.jsp">학생관리</a>&nbsp;
	
	<h3>강좌 현황</h3>
	
	<button type="button" class="submitBtn">등록</button>
	<table border="1" class='leclist'>
		<tr>
			<th>번호</th>
			<th>강좌명</th>
			<th>학점</th>
			<th>시간</th>
			<th>강의장</th>
		</tr>
	</table>
	<div class="insertInput">
		<h3>강좌등록</h3>
		<button type="button" class="closeBtn">닫기</button>
		<table border="1">
			<tr>
				<td>번호</td>
				<td><input type="text" name="lecNo"> </td>
			</tr>
			<tr>
				<td>강좌명</td>
				<td><input type="text" name="lecName"> </td>
			</tr>
			<tr>
				<td>학점</td>
				<td><input type="text" name="lecCredit"> </td>
			</tr>
			<tr>
				<td>시간</td>
				<td><input type="text" name="lecTime"> </td>
			</tr>
			<tr>
				<td>강의장</td>
				<td><input type="text" name="lecClass"> </td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<button type="button" class="insertBtn">추가</button> 
				</td>
			</tr>
		</table>
	</div>

</body>
</html>