/**
 * 강좌 관련 메서드
 */
 
 function lecture(){
	$(function(){
		
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
			
			if(!lecNo){
				alert('번호를 입력하세요.');
				$('.insertInput input[name=lecNo]').focus();
				return;
			}
			if(!lecName){
				alert('강좌명을 입력하세요.');
				$('.insertInput input[name=lecName]').focus();
				return;
			}
			if(!lecCredit){
				alert('학점을 입력하세요.');
				$('.insertInput input[name=lecCredit]').focus();
				return;
			}
			if(!lecTime){
				alert('시간을 입력하세요.');
				$('.insertInput input[name=lecTime]').focus();
				return;
			}
			if(!lecClass){
				alert('강의장을 입력하세요.');
				$('.insertInput input[name=lecClass]').focus();
				return;
			}
			
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
		
		
	})
}