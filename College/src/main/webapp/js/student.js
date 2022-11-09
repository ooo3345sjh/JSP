/**
 * 학생 관련 메서드
 */
 
 
 // 학생 등록 창 숨기기
function insertInputHide(){
	$(function(){
		$(".insertInput").hide();
	})
}

// 학생 리스트 출력
function list(){
	$(function(){
		let stulist = $('.stuList');
		$.ajax({
			url: '/College/proc/studentListProc.jsp',
			method: "get",
			dataType: "json",
			success: function (data) {
				for(let stu of data){
					let trTag = "<tr>"
						  + "<td class='stdNo'>" + stu.stdNo + "</td>"
						  + "<td>" + stu.stdName + "</td>"
						  + "<td class='stdHp'>" + stu.stdHp + "</td>"
						  + "<td>" + stu.stdYear + "</td>"
						  + "<td>" + stu.stdAddress + "</td>"
						  + "</tr>";	
				stulist.append(trTag);
				}
			}
		});
	})	
}

// 등록/닫기 버튼을 클릭시 강좌 등록 창 보이기/숨기기
function submitInputShowHide(){
	$(function(){
		// 등록 버튼을 누를시 학생 등록 창 보이기
		$(document).on('click', '.submitBtn', function (e) {
			$(".insertInput").show();
			
		});
		
		// 등록 버튼을 누를시 학생 등록 창 숨기기
		$(document).on('click', '.closeBtn', function (e) {
			
			// 초기화 
			let stdNo = $('.insertInput input[name=stdNo]').val('');
			let stdName = $('.insertInput input[name=stdname]').val('');
			let stdHp = $('.insertInput input[name=stdHp]').val('');
			let stdYear = $('.stdYear').val('1').prop("selected", true);
			let stdAddress = $('.insertInput input[name=stdAddress]').val('');
			
			// 등록창 숨기기
			$(".insertInput").hide();
		});
	});
}
		
// DB에 데이터 추가	
function submit(){
	$(function(){
		// 추가 버튼을 누를시 DB에 데이터 추가
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
			
			let searchVal = {
				"stdNo":stdNo
			}
			
			let trTag = "<tr>"
					  + "<td class='stdNo'>" + stdNo + "</td>"
					  + "<td>" + stdName + "</td>"
					  + "<td class='stdHp'>" + stdHp + "</td>"
					  + "<td>" + stdYear + "</td>"
					  + "<td>" + stdAddress + "</td>"
					  + "</tr>";	
			
			
			// 학번 중복 입력 체크
			$.ajax({
				url:'/College/proc/studentListProc.jsp',
				method: "post",
				data: searchVal,
				dataType: 'json',
				success: function (data) {
					if(data.length != 0){
						alert('이미 존재하는 학번입니다.');
						return;
					} 
					
					// 현재 리스트에 있는 휴대폰 목록과 입력한 휴대폰을 비교하여 중복 입력을 체크
				    let stdHpLength = $('.stdHp').get().length; // td태그의 배열 길이
				    let index = 0;
					for(i=0; i<stdHpLength; i++, index++){
						let	listHp = $('.stdHp').eq(i).text();
						if(stdHp == listHp){
							alert('이미 존재하는 휴대폰입니다.');
							return;
						}
					}
					
					// 학번 및 휴대폰의 중복입력 체크가 완료되면 DB에 저장한다.
					$.ajax({
						url:'/College/proc/studentInsertProc.jsp',
						method: "post",
						data: jsonData,
						dataType: "json",
						success: function (data) {
							if(data.result == 1){
								alert('등록 완료!');
								
								// DB 저장이 완료되면 리스트에 추가하기위한 코드
								// 새로 입력한 강좌 번호보다 최초로 큰 번호를 찾는다.
							    let stdNoLength = $('.stdNo').get().length; // td태그의 배열 길이
								let index = 0; 
								for(i=0; i<stdNoLength; i++, index++){
									let	no = $('.stdNo').eq(i).text();
									if(stdNo < no){
										break; 	
									}
								}
								
								if(index != stdNoLength){
									$('.stdNo').eq(index).parent().before(trTag); // 새로 추가한 번호보다 큰 번호 전에 삽입한다.
								} else {
									$('.stdNo').eq(index-1).parent().after(trTag); // 제일 큰 번호일 경우 마지막에 삽입
								}
								
								$('.closeBtn').trigger('click');
									
							}else {
								alert('등록 실패!');
							};
						}
					});
				}
			});
			
		});
	})
}
		
		
