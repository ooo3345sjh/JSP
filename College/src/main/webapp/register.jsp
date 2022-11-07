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
		
		// 수강 등록 창 숨기기
		$(".insertInput").hide();
		
		// 수강 리스트 목록 출력
		$(document).ready(function () {
			let reglist = $('.regList');
			$.ajax({
				url: '/College/proc/registerListProc.jsp',
				method: "get",
				dataType: "json",
				success: function (data) {
					for(let reg of data){
						let trTag = "<tr>"
							  + "<td>" + reg.regStdNo + "</td>"
							  + "<td>" + reg.stdName + "</td>"
							  + "<td>" + reg.lecName + "</td>"
							  + "<td>" + reg.regLecNo + "</td>"
							  + "<td>" + reg.regMidScore + "</td>"
							  + "<td>" + reg.regFinalScore + "</td>"
							  + "<td>" + reg.regTotalScore + "</td>"
							  + "<td>" + reg.regGrade + "</td>"
							  + "</tr>";	
					reglist.append(trTag);
					}
				}
			});
		});
		
		// 등록 버튼을 누를시 수강 등록 창 보이기
		$(document).on('click', '.submitBtn', function (e) {
			$(".insertInput").show();
			
		});
		
		// 닫기 버튼을 누를시 수강 등록 창 숨기기
		$(document).on('click', '.closeBtn', function (e) {
			$(".insertInput").hide();
		});
		
		// 추가 버튼을 누를시 DB에 데이터 추가 및 reload
		$(document).on('click', '.insertBtn', function (e) {
			let regStdNo = $('.insertInput input[name=regStdNo]').val();
			let stdName = $('.insertInput input[name=stdName]').val();
			let regLecNo = $('.regLecNo').val();
			
			let jsonData = {
					"regStdNo":regStdNo,
					"stdName":stdName,
					"regLecNo":regLecNo
			}
			console.log(jsonData);
			
			$.ajax({
				url:'/College/proc/registerInsertProc.jsp',
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
		
		// 검색 버튼을 누를시 검색 조건에 맞는 리스트 출력
		$(document).on('click', '.searchBtn', function (e) {
			let searchVal = $('input[name=search]').val();
			$('.regList tr').not(':first').remove();
			
			let jsonData = {
				"searchVal":searchVal
			}
			
			$.ajax({
				url: '/College/proc/registerListProc.jsp',
				method: "get",
				data: jsonData,
				dataType: "json",
				success: function (data) {
					let reglist = $('.regList');
					console.log(data);
					for(let reg of data){
						let trTag = "<tr>"
							  + "<td>" + reg.regStdNo + "</td>"
							  + "<td>" + reg.stdName + "</td>"
							  + "<td>" + reg.lecName + "</td>"
							  + "<td>" + reg.regLecNo + "</td>"
							  + "<td>" + reg.regMidScore + "</td>"
							  + "<td>" + reg.regFinalScore + "</td>"
							  + "<td>" + reg.regTotalScore + "</td>"
							  + "<td>" + reg.regGrade + "</td>"
							  + "</tr>";	
						reglist.append(trTag);
					}
				}
			});
			
		})
		
		
	});
</script>
</head>
<body>
	<h2>수강관리</h2>
	<a href="/College/lecture.jsp">강좌관리</a>&nbsp;
	<a href="/College/register.jsp">수강관리</a>&nbsp;
	<a href="/College/student.jsp">학생관리</a>&nbsp;
	
	<h3>수강 현황</h3>
	<input type="text" name="search">
	<button type="button" class="searchBtn">검색</button>
	<button type="button" class="submitBtn">수강신청</button>
	<table border="1" class='regList'>
		<tr>
			<th>학번</th>
			<th>이름</th>
			<th>강좌명</th>
			<th>강좌코드</th>
			<th>중간시험</th>
			<th>기말시험</th>
			<th>총점</th>
			<th>등급</th>
		</tr>
	</table>
	<div class="insertInput">
		<h3>수강신청</h3>
		<button type="button" class="closeBtn">닫기</button>
		<table border="1">
			<tr>
				<td>학번</td>
				<td><input type="text" name="regStdNo"> </td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="stdName"> </td>
			</tr>
			<tr>
				<td>신청강좌</td>
				<td>
					<select class="regLecNo">
					    <option value="none" selected disabled>강좌선택</option>
					    <option value="167">운영체제론</option>
					    <option value="159">인지행동심리학</option>
					    <option value="234">중급 영문법</option>
					    <option value="239">세법개론</option>
					    <option value="248">빅데이터 개론</option>
					    <option value="253">컴퓨팅사고와 코딩</option>
					    <option value="349">사회복지 마케팅</option>
					</select>
				</td>
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