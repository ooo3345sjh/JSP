<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>college::register</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function () {
		
		$(".insertInput").hide();
		
		$(document).ready(function () {
			let stulist = $('.stuList');
			$.ajax({
				url: '/College/proc/studentListProc.jsp',
				method: "get",
				dataType: "json",
				success: function (data) {
					for(let stu of data){
						let trTag = "<tr>"
							  + "<td>" + stu.stdNo + "</td>"
							  + "<td>" + stu.stdName + "</td>"
							  + "<td>" + stu.stdHp + "</td>"
							  + "<td>" + stu.stdYear + "</td>"
							  + "<td>" + stu.stdAddress + "</td>"
							  + "</tr>";	
					stulist.append(trTag);
					}
				}
			});
		});
		
		$(document).on('click', '.submitBtn', function (e) {
			$(".insertInput").show();
			
		});
		
		$(document).on('click', '.closeBtn', function (e) {
			$(".insertInput").hide();
		});
		
		$(document).on('click', '.insertBtn', function (e) {
			let stdNo = $('.insertInput input[name=stdNo]').val();
			let stdName = $('.insertInput input[name=stdname]').val();
			let stdHp = $('.insertInput input[name=stdHp]').val();
			let stdYear = $('.stdYear').val();
			let stdAddress = $('.insertInput input[name=stdAddress]').val();
			
			
			let jsonData = {
					"stdNo":stdNo,
					"stdName":stdName,
					"stdHp":stdHp,
					"stdYear":stdYear,
					"stdAddress":stdAddress
			}
			console.log(jsonData);
			
			$.ajax({
				url:'/College/proc/studentInsertProc.jsp',
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
	<h2>학생관리</h2>
	<a href="/College/lecture.jsp">강좌관리</a>&nbsp;
	<a href="/College/register.jsp">수강관리</a>&nbsp;
	<a href="/College/student.jsp">학생관리</a>&nbsp;
	
	<h3>학생목록</h3>
	
	<button type="button" class="submitBtn">등록</button>
	<table border="1" class='stuList'>
		<tr>
			<th>학번</th>
			<th>이름</th>
			<th>휴대폰</th>
			<th>학년</th>
			<th>주소</th>
		</tr>
	</table>
	<div class="insertInput">
		<h3>학생등록</h3>
		<button type="button" class="closeBtn">닫기</button>
		<table border="1">
			<tr>
				<td>학번</td>
				<td><input type="text" name="stdNo"> </td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="stdname"> </td>
			</tr>
			<tr>
				<td>휴대폰</td>
				<td><input type="text" name="stdHp"> </td>
			</tr>
			<tr>
				<td>신청강좌</td>
				<td>
					<select class="stdYear">
					    <option value="1" selected>1학년</option>
					    <option value="2">2학년</option>
					    <option value="3">3학년</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="stdAddress"> </td>
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