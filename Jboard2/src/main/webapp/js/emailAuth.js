let contextRoot = location.pathname.split('/')[1]; // 컨택트루트 ex) Jboard2

// 데이터 검증에 사용하는 정규표현식
let reAuth = /^[0-9]+$/;
let reEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

let emailCode = -9999999999;    // 이메일 인증번호
let preventDoubleClick = false; // 인증번호 받기 버튼 중복 입력 체크
let isEmailOk = false;          // 이메일 유효성 체크 변수
let isEmailAuthok = false;      // 이메일 인증번호 체크 변수
let email;
let name;
let uid;
let authNumber;


$(function(){	
	// 이메일 검사하기
	$('input[name=email]').focusout(function () {
		
		if(email != $(this).val()){ // 기존에 입력된 이메일과 현재 입력된 이메일이 다르면
			email = $(this).val();
			preventDoubleClick = false;
		}
		
		// 이메일 유효성 체크	
		if(email.match(reEmail)){
			isEmailOk = true;
		} else{
			isEmailOk = false;
		}
	});
	
	// 이름 검사하기
	$('input[name=name]').focusout(function () {
		
		if(name != $(this).val()){ // 기존에 입력된 이름과 현재 입력된 이름이 다르면
			name = $(this).val();
			preventDoubleClick = false;
		}
	});
	
	// 아이디 검사하기
	$('input[name=uid]').focusout(function () {
		
		if(uid != $(this).val()){ // 기존에 입력된 아이디과 현재 입력된 아이디가 다르면
			uid = $(this).val();
			preventDoubleClick = false;
		}
	});
	
	// 인증번호 숫자 유효성 체크
	$('input[name=auth]').keyup(function () {
		authNumber = $(this).val();
		if(!authNumber.match(reAuth)){
			$(this).val('');
			$(this).select();
			alert('숫자만 입력해주세요.');
			return;
		} 
	});
	
	// 이메일 인증 검사하기
	$('#btnEmail').click(function () {
		email = $('input[name=email]').val();
		let name = $('input[name=name]').val();
		let uid = $('input[name=uid]').val(); 
		
		if(!isEmailOk){
			alert('유효하지 않는 이메일입니다.');
			return;
		}
		
		if(preventDoubleClick){ // 중복확인을 이미 한번 누른 상태이면
			alert('이미 인증번호를 발송했습니다. \n인증번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해 주세요.');
			return;
		}
		
		alert('인증번호를 발송했습니다. \n인증번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해 주세요.');
		
		preventDoubleClick = true; // 중복확인 버튼을 눌렀으면 true;
		
		if(!uid){
			Check_Name_Email();
		} else if(!name){
			Check_Uid_Email();
		}
	});
	
	// 이메일 인증코드 확인
	$('#btnEmailConfirm').click(function () {
		let code = $('input[name=auth]').val();
		
		if(code == emailCode){
			isEmailAuthok = true;
			$('.resultEmail').css('color', 'green').text('이메일이 인증 되었습니다.');
		} else {
			isEmailAuthok = false;
			$('.resultEmail').css('color', 'red').text('인증번호가 올바르지 않습니다. 확인 후 다시 입력해주세요.');
		}
	});
	
})		

// 이름, 이메일 확인 후 메일을 전송하는 함수
function Check_Name_Email (){
	let name = $('input[name=name]').val();
	let findId_Pw = $('input[name=findId_Pw]').val();
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
					data: {"email":email, "findId_Pw":findId_Pw},
					dataType:'json',
					success: function (data) {
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

// 아이디, 이메일 확인 후 메일을 전송하는 함수
function Check_Uid_Email (){
	let uid = $('input[name=uid]').val();
	let findId_Pw = $('input[name=findId_Pw]').val();
	email = $('input[name=email]').val();
	
	let jsonData = {
		"uid":uid,
		"email":email
	}
	
	$.ajax({
		url: "/" + contextRoot + '/user/findPw.do',
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
					data: {"email":email, "findId_Pw":findId_Pw},
					dataType:'json',
					success: function (data) {
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