/**
 * 강좌 관련 메서드
 */
 
 // 강좌 등록 창 숨기기
 function insertInputHide(){
	$(function(){
		$(".insertInput").hide();
	})
}

// 강좌 리스트 목록 출력
function list(){
	let leclist = $('.leclist');
	$.ajax({
		url: '/College/proc/lectureListProc.jsp',
		method: "get",
		dataType: "json",
		success: function (data) {
			num = data;
			for(let lec of data){
				let trTag = "<tr>"
					  + "<td class='lecNo'>" + lec.lecNo + "</td>"
					  + "<td>" + lec.lecName + "</td>"
					  + "<td>" + lec.lecCredit + "</td>"
					  + "<td>" + lec.lecTime + "</td>"
					  + "<td>" + lec.lecClass + "</td>"
					  + "</tr>";	
				leclist.append(trTag);
			}
		}
	});
}

function submitInputShowHide(){
	$(function(){
		// 등록 버튼을 누를시 강좌 등록 창 보이기
		$(document).on('click', '.submitBtn', function (e) {
			$(".insertInput").show();
			
		});
		
		// 닫기 버튼을 누를시 등록 창 숨기기
		$(document).on('click', '.closeBtn', function (e) {
			// 초기화 
			let lecNo = $('.insertInput input[name=lecNo]').val('');
			let lecName = $('.insertInput input[name=lecName]').val('');
			let lecCredit = $('.insertInput input[name=lecCredit]').val('');
			let lecTime = $('.insertInput input[name=lecTime]').val('');
			let lecClass = $('.insertInput input[name=lecClass]').val('');
			
			$(".insertInput").hide();
		});
	});
}

// 추가 버튼을 누를시 DB에 데이터 추가 및 reload
function submit(){
	$(function(){
		
		$(document).on('click', '.insertBtn', function () {
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
			
			let lecNoLength = $('.lecNo').get().length; // td태그의 배열 길이
			let index=0; 
			
			// 새로 입력한 강좌 번호보다 최초로 큰 번호를 찾는다.
			
			for(i=0; i<lecNoLength; i++, index++){
				let	no = $('.lecNo').eq(i).text();
				if(lecNo <= no){
					break; 	
				}
			}
			
			let trTag = "<tr>"
					  + "<td class='lecNo'>" + lecNo + "</td>"
					  + "<td>" + lecName + "</td>"
					  + "<td>" + lecCredit + "</td>"
					  + "<td>" + lecTime + "</td>"
					  + "<td>" + lecClass + "</td>"
					  + "</tr>";

			$.ajax({
				url:'/College/proc/lectureInsertProc.jsp',
					method: "post",
					data: jsonData,
					dataType: "json",
					success: function (data) {
						if(data.result == 1){
							alert('등록 완료!');
							if(index != lecNoLength){
								$('.lecNo').eq(index).parent().before(trTag); // 새로 추가한 번호보다 큰 번호 전에 삽입한다.
							} else {
								$('.lecNo').eq(index-1).parent().after(trTag); // 제일 큰 번호일 경우 마지막에 삽입
							}
							$('.closeBtn').trigger('click');
						}else {
							alert('강좌 번호가 중복됩니다.');
						};
					}
			})
		});
	});
}
		
		
		
