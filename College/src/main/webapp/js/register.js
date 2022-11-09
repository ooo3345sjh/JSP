/**
 * 수강 관련 메서드
 */
 
// 수강 등록 창 숨기기
 function insertInputHide(){
	$(function(){
		$(".insertInput").hide();
	})
}
		
// 수강 리스트 목록 출력
function list(){
	let reglist = $('.regList');
	$.ajax({
		url: '/College/proc/registerListProc.jsp',
		method: "get",
		dataType: "json",
		success: function (data) {
			for(let reg of data){
				let trTag = "<tr>"
					  + "<td class='regStdNo'>" + reg.regStdNo + "</td>"
					  + "<td>" + reg.stdName + "</td>"
					  + "<td>" + reg.lecName + "</td>"
					  + "<td>" + reg.regLecNo + "</td>"
					  + "<td>" + reg.regMidScore + "</td>"
					  + "<td>" + reg.regFinalScore + "</td>"
					  + "<td>" + reg.regTotalScore + "</td>"
					  + "<td>" + reg.regGrade + "</td>"
					  + "<td>"
					  + "<button type='button' class='scoreInsertBtn'>입력</button>"
					  + "<button type='button' class='scoreSubmitBtn'>제출</button>"
					  + "</td>"
					  + "</tr>";	
			reglist.append(trTag);
			
			}
			$(".scoreSubmitBtn").css("display", "none");
		}
	});
}		
		
function submitInputShowHide(){
	$(function(){
		// 등록 버튼을 누를시 수강 등록 창 보이기
		$(document).on('click', '.submitBtn', function (e) {
			$(".insertInput").show();
			
		});
		
		// 닫기 버튼을 누를시 수강 등록 창 숨기기
		$(document).on('click', '.closeBtn', function (e) {
			let regStdNo = $('.insertInput input[name=regStdNo]').val('');
			let stdName = $('.insertInput input[name=stdName]').val('');
			let regLecNo = $('.regLecNo').val('none').prop("selected", true);

			$(".insertInput").hide();
		});
	});
}		
			
// 추가 버튼을 누를시 DB에 데이터 추가 및 reload
function submit(){
	$(function(){
		$(document).on('click', '.insertBtn', function (e) {
			let regStdNo = $('.insertInput input[name=regStdNo]').val();
			let stdName = $('.insertInput input[name=stdName]').val();
			let regLecNo = $('.regLecNo').val();
			
			if(!regStdNo){
				alert('학번를 입력하세요.');
				$('.insertInput input[name=regStdNo]').focus();
				return;
			}
			if(!stdName){
				alert('이름을 입력하세요.');
				$('.insertInput input[name=stdName]').focus();
				return;
			}
			if(!regLecNo){
				alert('강좌를 선택하세요.');
				$('.regLecNo').focus();
				return;
			}
			
			let jsonData = {
					"regStdNo":regStdNo,
					"stdName":stdName,
					"regLecNo":regLecNo
			}
			
			let searchVal = {
				"searchVal":regStdNo
			}
			
			$.ajax({
				url:'/College/proc/registerListProc.jsp',
				method: "post",
				data: searchVal,
				dataType: 'json',
				success: function (data) {
					if(data.length == 0){
						alert('존재하지 않는 학번입니다.');
						result = fasle;
						return;
					}
					
					$.ajax({
						url:'/College/proc/registerInsertProc.jsp',
						method: "post",
						data: jsonData,
						dataType: "json",
						success: function (data) {
							console.log(data);
							console.log(data.result);
							if(data.result == 1){
								alert('등록 완료!');
								let trTag = "<tr>"
										  + "<td>" + data.stdNo + "</td>"
										  + "<td>" + data.stdName + "</td>"
										  + "<td>" + data.lecName + "</td>"
										  + "<td>" + data.regLecNo + "</td>"
										  + "<td>0</td>"
										  + "<td>0</td>"
										  + "<td>0</td>"
										  + "<td>-</td>"
										  + "<td>"
										  + "<button type='button' class='scoreInsertBtn'>입력</button>"
										  + "<button type='button' class='scoreSubmitBtn' style='display: none;'>제출</button>"
										  + "</td>"
										  + "</tr>";
								  
						    // 새로 입력한 강좌 번호보다 최초로 큰 번호를 찾는다.
						    let regStdNoLength = $('.regStdNo').get().length; // td태그의 배열 길이
							let index = 0; 
							for(i=0; i<regStdNoLength; i++, index++){
								let	no = $('.regStdNo').eq(i).text();
								if(data.stdNo < no){
									break; 	
								}
							}
							console.log('index : ' + index);
							console.log('regStdNoLength : ' + regStdNoLength);
							if(index != regStdNoLength){
								$('.regStdNo').eq(index).parent().before(trTag); // 새로 추가한 번호보다 큰 번호 전에 삽입한다.
							} else {
								$('.regStdNo').eq(index-1).parent().after(trTag); // 제일 큰 번호일 경우 마지막에 삽입
							}
							
							$('.closeBtn').trigger('click');
						}else {
							alert('등록 실패!');
						};
					}
				})
			}
		});
		});
	});
}	
		
		
// 검색 버튼을 누를시 검색 조건에 맞는 리스트 출력
function search(){
	$(function(){
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
					for(let reg of data){
						let trTag = "<tr>"
							  + "<td class='regStdNo'>" + reg.regStdNo + "</td>"
							  + "<td>" + reg.stdName + "</td>"
							  + "<td>" + reg.lecName + "</td>"
							  + "<td>" + reg.regLecNo + "</td>"
							  + "<td>" + reg.regMidScore + "</td>"
							  + "<td>" + reg.regFinalScore + "</td>"
							  + "<td>" + reg.regTotalScore + "</td>"
							  + "<td>" + reg.regGrade + "</td>"
							  + "<td>"
							  + "<button type='button' class='scoreInsertBtn'>입력</button>"
							  + "<button type='button' class='scoreSubmitBtn'>제출</button>"
							  + "</td>"
							  + "</tr>";	
						reglist.append(trTag);
					}
					$(".scoreSubmitBtn").css("display", "none");
				}
			});
			
		})
	});
}	
		
function scoreInput(){
	$(function(){
		// 입력 버튼을 누르면 중간, 기말 시험점수 입력 input창으로 변환
		$(document).on('click', '.scoreInsertBtn', function (e) {
			
			let regMidScoreTag = $(this).parent().siblings(':eq(4)'); // 중간시험의 td태그
			let regFinalScoreTag = $(this).parent().siblings(':eq(5)'); // 기말시험의 td태그
			
			let regMidScore = regMidScoreTag.text(); // 입력되어있는 중간시험 점수 값
			let regFinalScore = regFinalScoreTag.text(); // 입력되어있는 기말시험 점수 값
			
			regMidScoreTag.contents().wrap( "<input type='text' name='regMidScore' value='" 
					+ regMidScore + "' style='width:55px;'/>" ); // 중간시험 td태그 안에 input태그를 생성
			regFinalScoreTag.contents().wrap( "<input type='text' name='regFinalScore' value='" 
					+ regFinalScore + "' style='width:55px;'/>" ); // 기말시험 td태그 안에 input태그를 생성
			
			$(this).parent().find('.scoreSubmitBtn').show(); // 제출 버튼을 보이게 한다.
			$(this).css("display","none"); // 입력 버튼을 숨긴다.
		});
		
		// 제출버튼 클릭시 DB에 중간, 기말 점수를 업데이트 한다.
		$(document).on('click', '.scoreSubmitBtn', function (e) {
			let regStdNo = $(this).parent().siblings(':eq(0)').text(); // 학번
			let regLecNo = $(this).parent().siblings(':eq(3)').text(); // 강좌코드
			let regMidScore = $(this).parent().siblings(':eq(4)').children('input[name=regMidScore]').val(); // 중간시험 점수
			let regFinalScore = $(this).parent().siblings(':eq(5)').children('input[name=regFinalScore]').val(); // 기말시험 점수
			
			if(!regMidScore){
				alert('중간시험 점수를 입력해주세요.');
				return;
			}
			
			if(!regFinalScore){
				alert('기말시험 점수를 입력해주세요.');
				return;
			}
			
			let jsonData = {
					"regStdNo":regStdNo,
					"regLecNo":regLecNo,
					"regMidScore":regMidScore,
					"regFinalScore":regFinalScore
			}
			
			$.ajax({
				url:'/College/proc/registerModifyProc.jsp',
				method:'post',
				data:jsonData,
				typeData:'json',
				success: function (data) {
					if(data.result == 1){
						alert('등록 완료!');
					}else {
						alert('등록 실패!');
					};
					$('.searchBtn').trigger('click'); // 검색 버튼 강제 클릭
				}
			});
			
			
			$(this).parent().find('.scoreInsertBtn').show(); // 입력 버튼 보이기
			$(this).css("display","none"); // 제출 버튼 숨기기
		});
	});
}	
		
		
		
