/**
 * 날짜 : 2022/10/21
   이름 : 서정현
   내용 : 사용자 회원가입 검증
 */
 
 
	// 데이터 검증에 사용하는 정규표현식
	let reUid   = /^[a-z]+[a-z0-9]{5,19}$/g;
	let rePass  = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{5,16}$/;
	let reName  = /^[ㄱ-힣]+$/;
	let reNick  = /^[a-zA-Zㄱ-힣0-9][a-zA-Zㄱ-힣0-9]*$/;
	let reEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	let reHp    = /^01(?:0|1|[6-9])-(?:\d{4})-\d{4}$/;
	
	// 폼 데이터 검증 결과 상태변수
	let isUidok = false;
	let isPassok = false;
	let isNameok = false;
	let isNickok = false;
	let isEmailok = false;
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
					url:'./proc/checkUid.jsp',
					method: 'get',
					data: jsonData,
					dataType: 'json',
					success: function (data) {
						if(data.result==0){
							isUidok = true;
							$('.uidResult').css('color', 'green').text('사용 가능한 아이디입니다.');
						}else{
							isUidok = false;
							$('.uidResult').css('color', 'red').text('이미 사용중이 아이디입니다.');
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
					url:'./proc/checkNick.jsp',
					method: 'get',
					data: jsonData,
					dataType: 'json',
					success: function (data) {
						if(data.result==0){
							isNickok = true;
							$('.nickResult').css('color', 'green').text('사용 가능한 별명입니다.');
						}else{
							isUidok = false;
							$('.nickResult').css('color', 'red').text('이미 사용중이 별명입니다.');
						}
					}
				});
				
			}, 100)
			
		});
		
		// 이메일 검사하기
		$('input[name=email]').focusout(function () {
			
			let email = $(this).val();
			
			if(email.match(reEmail)){
				isEmailok = true;
				$('.emailResult').text('');
			} else{
				isEmailok = false;
				$('.emailResult').css('color', 'red').text('유효하지 않는 이메일입니다.');
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
			
			// 휴대폰 검증
			if(!isHpok){
				alert('휴대폰이 유효하지 않습니다.');
				return false;
			}
			
			return true;
		});
	});