/**
 * 수강 관련 메서드
 */
 
 function register(){
	$(function(){
		
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
			console.log(jsonData);
			
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
		
		
	})
}