
let contextRoot = location.pathname.split('/')[1];
let emailCode = -9999999999;
let preventDoubleClick = false; // 인증번호 받기 버튼 중복 입력 체크
let isNumber = /[0-9]{5,10}$/;
let email;
let name;

$(function(){	
	
	// 이메일 검사하기
	$('input[name=email]').focusout(function () {
		
		if(email != $(this).val()){ // 기존에 입력된 이메일과 현재 입력된 이메일이 다르면
			email = $(this).val();
			isEmailok = false;
			preventDoubleClick = false;
		}
		
		if(email.match(reEmail)){
			isEmailok = true;
		} 
	});
	
	$('input[name=name]').focusout(function () {
		
		if(name != $(this).val()){ // 기존에 입력된 이메일과 현재 입력된 이메일이 다르면
			name = $(this).val();
			preventDoubleClick = false;
			$('.nameResult').text(' ');
		}
		
		if(name.match(reName)){
			$('.nameResult').css('color', 'red').text('유효한 이름이 아닙니다.');
		} 
	});
	
	// 이메일 인증 검사하기
	$('#btnEmail').click(function () {
		email = $('input[name=email]').val();
		
		if(!isEmailok){
			alert('유효하지 않는 이메일입니다.');
			return;
		}
		
		if(preventDoubleClick){ // 중복확인을 이미 한번 누른 상태이면
			alert('이미 인증번호를 발송했습니다. \n인증번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해 주세요.');
			return;
		}
		
		alert('인증번호를 발송했습니다. \n인증번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해 주세요.');
		
		preventDoubleClick = true; // 중복확인 버튼을 눌렀으면 true;
		
		Check_Name_Email();
	});
	
	// 이메일 인증코드 확인
	$('#btnEmailConfirm').click(function () {
		let code = $('input[name=auth]').val();
		
		if(code == emailCode){
			isEmailAuthok = true;
			$('.resultEmail').css('color', 'green').text('이메일이 인증 되었습니다.');
		} else {
			$('.resultEmail').css('color', 'red').text('인증번호가 올바르지 않습니다. 확인 후 다시 입력해주세요.');
		}
	});
	
})

// 이름, 이메일 확인 후 메일을 전송하는 함수
function Check_Name_Email (){
	let name = $('input[name=name]').val();
	email = $('input[name=email]').val();
			
	let jsonData = {
		"name":name,
		"email":email
	}
	
	$.ajax({
		url: "/" + contextRoot + '/user/findId.do',
		method:'post',
		data: jsonData,
		dataType:'json',
		success: function (data) {
			// console.log(data);
			if(data.result == 1){ // 입력한 정보와 일치하는 회원이 있음
				$('.resultEmail').text('인증번호를 입력해주세요.');
				// 인증번호 input창 배경색을 화이트로 바꾸고, 입력이 가능하도록 바꾸고, 선택한다.
				$('input[name=auth]').css("background-color", "#fff").attr("disabled", false).select();
				$('#btnEmailConfirm').css("pointer-events", "auto"); // 인증번호 확인 버튼 활성화
				
				// 메일을 전송하는 AJAX
				$.ajax({
					url: "/" + contextRoot + '/user/emailAuth.do',
					method:'get',
					data: {"email":email},
					dataType:'json',
					success: function (data) {
						console.log(data.code);
						if(data.status == 1){
							// 메일발송 성공
							emailCode = data.code;
						} 
					}
				});
			} 
		}
	});
}