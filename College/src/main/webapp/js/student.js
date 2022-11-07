/**
 * 학생 관련 메서드
 */
 
 function student(){
	$(function(){
		
		// 학생 등록 창 숨기기
		$(".insertInput").hide();
		
		// 학생 리스트 출력
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
		
		// 등록 버튼을 누를시 학생 등록 창 보이기
		$(document).on('click', '.submitBtn', function (e) {
			$(".insertInput").show();
			
		});
		
		// 등록 버튼을 누를시 학생 등록 창 숨기기
		$(document).on('click', '.closeBtn', function (e) {
			$(".insertInput").hide();
		});
		
		// 추가 버튼을 누를시 DB에 데이터 추가 및 reload
		$(document).on('click', '.insertBtn', function (e) {
			let stdNo = $('.insertInput input[name=stdNo]').val();
			let stdName = $('.insertInput input[name=stdname]').val();
			let stdHp = $('.insertInput input[name=stdHp]').val();
			let stdYear = $('.stdYear').val();
			let stdAddress = $('.insertInput input[name=stdAddress]').val();
			
			if(!stdNo){
				alert('학번을 입력하세요.');
				$('.insertInput input[name=stdNo]').focus();
				return;
			}
			if(!stdName){
				alert('이름을 입력하세요.');
				$('.insertInput input[name=stdname]').focus();
				return;
			}
			if(!stdHp){
				alert('휴대폰을 입력하세요.');
				$('.insertInput input[name=stdHp]').focus();
				return;
			}
			if(!stdAddress){
				alert('주소를 입력하세요.');
				$('.insertInput input[name=stdAddress]').focus();
				return;
			}
			
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
		
	})
}