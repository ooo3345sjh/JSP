/**
 * 날짜 : 2022/10/21
   이름 : 서정현
   내용 : 사용자 회원가입 검증
 */
 
  	let contextRoot = location.pathname.split('/')[1]; // 컨택트루트 ex) Jboard2
  	
	// 데이터 검증에 사용하는 정규표현식
	let reUid   = /^[a-z]+[a-z0-9]{5,19}$/g;
	let rePass  = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{5,16}$/;
	let reName  = /^[ㄱ-힣]+$/;
	let reNick  = /^[a-zA-Zㄱ-힣0-9][a-zA-Zㄱ-힣0-9]*$/;
	let reEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	let reHp    = /^01(?:0|1|[6-9])-(?:\d{4})-\d{4}$/;
	let reAuth  = /^[0-9]+$/;
	
	// 폼 데이터 검증 결과 상태변수
	let isUidok = false;
	let isPassok = false;
	let isNameok = false;
	let isNickok = false;
	let isEmailok = false;
	let isEmailAuthok = false;
	let isHpok = false;
	
	$(function () {
		// 아이디 검사하기(별명 항목도 동일하다)
		$('input[name=uid]').keydown(function () { // 다른 아이디 값을 입력 했을때 다시 중복 확인을 해야 하므로
			isUidok = false;
		});
		
		$('#btnIdCheck').click(function () {
			
			
			let uid = $('input[name=uid]').val(); // uid 입력값
			
			if(isUidok){ // 이미 확인한 아이디값으로 중복확인 버튼을 다시 클릭시 중북확인을 실행하는 것은 불필요하기 위한 제동장치 
				return;
			}
			
			let jsonData = { // uid 값을 JSON형태로 변환한다.
					"uid":uid 
			};
			
			if(!uid.match(reUid)){ // 유효성 검사  
				isUidok = false;
				$('.uidResult').css('color', 'red').text('유효한 아이디가 아닙니다.');
				return;
			}
			
			// 유효성 검사가 통과되야 아래의 AJAX가 실행된다. 
			
			$('.uidResult').css('color', 'black').text('...'); // 중복확인 클릭시 로딩중을 표시
			
			
			setTimeout(function() {
				$.ajax({
					url:'/' + contextRoot + '/user/checkUid.do',
					method: 'get',
					data: jsonData,
					dataType: 'json',
					success: function (data) {
						if(data.result==0){
							isUidok = true;
							$('.uidResult').css('color', 'green').text('사용 가능한 아이디입니다.');
						}else{
							isUidok = false;
							$('.uidResult').css('color', 'red').text('이미 사용중인 아이디입니다.');
						}
					}
				});
				
			}, 100)
			
		});
		
			
		// 비밀번호 검사하기
		$('input[name=pass1], input[name=pass2]').focusout(function () {
			
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $('input[name=pass2]').val();
			
			if(pass2.match(rePass)){
				if(pass1 == pass2){
					isPassok = true;
					$('.passResult').css('color', 'green').text('사용하실수 있는 비밀번호입니다.');
				} else {
					isPassok = false;
					$('.passResult').css('color', 'red').text('비밀번호가 일치하지 않습니다.');					
				}
				
				
			} else{
				isPassok = false;
				$('.passResult').css('color', 'red').text('숫자,영문,특수문자 포함 5자리 이상 이어야 합니다.');
			}
			
		});
		
		
		// 이름 검사하기
		$('input[name=name]').focusout(function () {
			let name = $(this).val();
			
			if(name.match(reName)){
				isNameok = true;
				$('.nameResult').text(' ');
			} else {
				isNameok = false;
				$('.nameResult').css('color', 'red').text('유효한 이름이 아닙니다.');
			}
		});
		
		// 별명 검사하기
		$('input[name=nick]').keydown(function () {
			isNickok = false;
		});
		
		$('#btnNickCheck').click(function () {
			
			
			let nick = $('input[name=nick]').val(); // nick 입력값
			
			if(isNickok){
				return;
			}
			
			let jsonData = {
					"nick":nick 
			};
			
			if(!nick.match(reNick)){
				isNickok = false;
				$('.nickResult').css('color', 'red').text('유효한 별명이 아닙니다.');
				return;
			}
			
			$('.nickResult').css('color', 'black').text('...');
			
			setTimeout(function() {
				$.ajax({
					url:'/' + contextRoot + '/user/checkNick.do',
					method: 'get',
					data: jsonData,
					dataType: 'json',
					success: function (data) {
						if(data.result==0){
							isNickok = true;
							$('.nickResult').css('color', 'green').text('사용 가능한 별명입니다.');
						}else{
							isUidok = false;
							$('.nickResult').css('color', 'red').text('이미 사용중인 별명입니다.');
						}
					}
				});
				
			}, 100)
			
		});
		
		// 이메일 검사하기
		let email;
		let emailCode = -999999999;
		let isClick = false;
		
		$('input[name=email]').focusout(function () {
			
			if(email != $(this).val()){ // 기존에 입력된 이메일과 현재 입력된 이메일이 다르면
				email = $(this).val();
				isClick = false;
			}
			
			if(email.match(reEmail)){
				isEmailok = true;
				$('.emailResult').text('');
			} else{
				isEmailok = false;
				$('.emailResult').css('color', 'red').text('유효하지 않는 이메일입니다.');
			}
		});
		
		// 인증번호 숫자 유효성 체크
		$('input[name=auth]').keyup(function () {
			authNumber = $(this).val();
			if(!authNumber.match(reAuth)){
				$(this).val('');
				alert('숫자만 입력해주세요.');
				return;
			} 
		});
		
		// 이메일 인증 검사하기
		$('#btnEmailAuth').click(function () {
			email = $('input[name=email]').val();
			
			if(isClick){ // 중복확인을 이미 한번 누른 상태이면
				alert('이미 인증번호가 전송 중입니다. \n전송완료 메시지가 나타나면 입력한 이메일을 확인 해주세요.');
				return;
			}
			
			isClick = true; // 중복확인 버튼을 눌렀으면 true;
			
			$('.auth').show();
			$('.emailResult').css('color', 'black').text('...'); // 중복확인 클릭시 로딩중을 표시
			
			$.ajax({
				url: '/' + contextRoot + '/user/emailAuth.do',
				method:'get',
				data: {"email":email},
				dataType:'json',
				success: function (data) {
					// console.log(data);
					if(data.status == 1){
						// 메일발송 성공
						emailCode = data.code;
						
						$('.emailResult').text('인증코드를 전송했습니다. 이메일을 확인 하세요.');
					} else {
						// 메일발송 실패
						$('.emailResult').css("color", "red").text('이미 사용중인 이메일입니다.');
						isClick = false;
					}
				}
			});
		});
		
		// 이메일 인증코드 확인
		$('#btnEmailConfirm').click(function () {
			let code = $('input[name=auth]').val();
			
			if(code == emailCode){
				isEmailAuthok = true;
				$('.emailResult').css('color', 'green').text('이메일이 인증 되었습니다.');
			} else {
				isEmailAuthok = false;
				$('.emailResult').css('color', 'red').text('인증번호가 일치하지 않습니다.');
			}
		});
		
		// 휴대폰 검사하기
		$('input[name=hp]').focusout(function () {
			
			let hp = $(this).val();
			
			if(hp.match(reHp)){
				isHpok = true;
				$('.hpResult').text('');
			} else{
				isHpok = false;
				$('.hpResult').css('color', 'red').text('유효하지 않는 휴대폰입니다.');
			}
		});
		
		// 최종 폼 전송할 때
		
		$('.register > form').submit(function () {
			// 아이디 검증
			if(!isUidok){
				alert('아이디를 확인 하십시요.');
				return false;
			}
			
			// 비밀번호 검증
			if(!isPassok){
				alert('비밀번호가 유효하지 않습니다.');
				return false;
			}
			
			// 이름 검증
			if(!isNameok){
				alert('이름이 유효하지 않습니다.');
				return false;
			}
			
			// 별명 검증
			if(!isNickok){
				alert('별명이 확인 하십시요.');
				return false;
			}
			
			// 이메일 검증
			if(!isEmailok){
				alert('이메일이 유효하지 않습니다.');
				return false;
			}
			
			// 이메일 인증 검증
			if(!isEmailAuthok){
				alert('이메일을 인증 하셔야 합니다.');
				return false;
			}
			
			// 휴대폰 검증
			if(!isHpok){
				alert('휴대폰이 유효하지 않습니다.');
				return false;
			}
			
			return true;
		});
	});