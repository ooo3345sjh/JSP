<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>college::lecture</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function () {
		
		// 강좌 등록 창 숨기기
		$(".insertInput").hide();
		
		// 강좌 리스트 목록 출력
		$(document).ready(function () {
			let leclist = $('.leclist');
			$.ajax({
				url: '/College/proc/lectureListProc.jsp',
				method: "get",
				dataType: "json",
				success: function (data) {
					console.log(data);
					for(let lec of data){
						let trTag = "<tr>"
							  + "<td>" + lec.lecNo + "</td>"
							  + "<td>" + lec.lecName + "</td>"
							  + "<td>" + lec.lecCredit + "</td>"
							  + "<td>" + lec.lecTime + "</td>"
							  + "<td>" + lec.lecClass + "</td>"
							  + "</tr>";	
						leclist.append(trTag);
					}
				}
			});
		});
		
		// 등록 버튼을 누를시 강좌 등록 창 보이기
		$(document).on('click', '.submitBtn', function (e) {
			$(".insertInput").show();
			
		});
		
		// 닫기 버튼을 누를시 등록 창 숨기기
		$(document).on('click', '.closeBtn', function (e) {
			$(".insertInput").hide();
		});
		
		// 추가 버튼을 누를시 DB에 데이터 추가 및 reload
		$(document).on('click', '.insertBtn', function (e) {
			let lecNo = $('.insertInput input[name=lecNo]').val();
			let lecName = $('.insertInput input[name=lecName]').val();
			let lecCredit = $('.insertInput input[name=lecCredit]').val();
			let lecTime = $('.insertInput input[name=lecTime]').val();
			let lecClass = $('.insertInput input[name=lecClass]').val();
			
			let jsonData = {
					"lecNo":lecNo,
					"lecName":lecName,
					"lecCredit":lecCredit,
					"lecTime":lecTime,
					"lecClass":lecClass
			}
			console.log(jsonData);
			
			$.ajax({
				url:'/College/proc/lectureInsertProc.jsp',
					method: "post",
					data: jsonData,
					dataType: "json",
					success: function (data) {
						if(data.result == 1){
							alert('등록 완료!');
						}else {
							alert('등록 실패!');
						};
						location.reload();
					}
			})
			
			
		});
		
		
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