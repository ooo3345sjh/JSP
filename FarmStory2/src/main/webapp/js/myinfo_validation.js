/**
 * 날짜 : 2022/10/21
   이름 : 서정현
   내용 : 사용자 회원가입 검증
 */
 
  	let contextRoot = location.pathname.split('/')[1]; // 컨택트루트 ex) Jboard2
  	
	// 데이터 검증에 사용하는 정규표현식
	let rePass  = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{5,16}$/;
	let reName  = /^[ㄱ-힣]+$/;
	let reNick  = /^[a-zA-Zㄱ-힣0-9][a-zA-Zㄱ-힣0-9]*$/;
	let reEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	let reHp    = /^01(?:0|1|[6-9])-(?:\d{4})-\d{4}$/;
	let reAuth  = /^[0-9]+$/;
	
	// 폼 데이터 검증 결과 상태변수
	let isPassok = false;
	let isNameok = true;
	let isNickok = true;
	let isEmailok = true;
	let isEmailAuthok = true;
	let isHpok = true;
	
	
	$(function () {
			
		/*** 비밀번호 수정 ***/
		// 비밀번호 검사하기
		$('input[name=pass1], input[name=pass2]').keyup(function () {
			
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $('input[name=pass2]').val();
			
			if(pass2.match(rePass)){
				if(pass1 == pass2){
					isPassok = true;
				} else {
					isPassok = false;
				}
				
			} else{
				isPassok = false;
			}
			
		});
		
		/*** 회원정보 수정 ***/
		
		let currentName = $('input[name=name]').val();
		let currentNick = $('input[name=nick]').val();
		let currentEmail = $('input[name=email]').val();
		let currentHp = $('input[name=hp]').val();
		let updateName = $('input[name=name]').val();
		let updateNick = $('input[name=nick]').val();
		let updateEmail = $('input[name=email]').val();
		let updateHp = $('input[name=hp]').val();
		
		
		// 이름 검사하기
		$('input[name=name]').keyup(function () {
			let name = $(this).val();
			updateName = name;
			if(currentName != name){
				if(name.match(reName)){
					isNameok = true;
					$('.nameResult').text('');
				} else {
					isNameok = false;
					$('.nameResult').css('color', 'red').text('유효한 이름이 아닙니다.');
				}
			} else {
				isNameok = true;
				$('.nameResult').text('');
			}
		});
		
		// 별명 검사하기
		$('input[name=nick]').keyup(function () {
			let nick = $(this).val();
			updateNick = nick;
			if(currentNick != nick){
				isNickok = false;
			} else {
				isNickok = true;
			}
		});
		
		$('#btnNickCheck').click(function () {
			
			let nick = $('input[name=nick]').val(); // nick 입력값
			
			if(currentNick == nick){
				$('.nickResult').css('color', 'black').css("color", "red").text('현재 입력하신 별명은 변경되지 않은 값입니다. 변경 후에 클릭해주세요.');
				isNickok = true;
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
							isNickok = false;
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
		
		$('input[name=email]').keyup(function () {
			updateEmail = $(this).val();
			isEmailAuthok = false;
			
			if(currentEmail == $(this).val()){
				isEmailok = true;
				isEmailAuthok = true;
				$('.emailResult').text('');
				return;
			}
			
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
			if(currentEmail == email){
				alert('현재 입력하신 이메일은 변경되지 않은 값입니다. \n변경 후에 클릭해주세요.');
				isEmailok = true;
				return;
			}
			
			if(!email){
				alert('이메일 주소를 입력 해주세요.');
				return;
			}
			
			if(!isEmailok){
				alert('유효하지 않은 이메일입니다.');
				return;
			}
			
			if(isClick){ // 중복확인을 이미 한번 누른 상태이면
				alert('이미 인증번호가 전송 중입니다. \n전송완료 메시지가 나타나면 입력한 이메일을 확인 해주세요.');
				return;
			}
			
			isClick = true; // 중복확인 버튼을 눌렀으면 true;
			
			
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
						
						$('.emailResult').css("color", "black").text('인증코드를 전송했습니다. 이메일을 확인 하세요.');
						$('.auth').show();
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
		
		
		let isHpClick;
		let hp;
		
		// 휴대폰 검사하기
		$('input[name=hp]').keyup(function () {
			updatetHp = $(this).val();
			if(currentHp == $(this).val()){
				isHpok = true;
				return;
			}
			
			if(hp != $(this).val()){ // 기존에 입력된 이메일과 현재 입력된 이메일이 다르면
				hp = $(this).val();
				isHpClick = false;
			}
			
			if(hp.match(reHp)){
				isHpok = true;
				$('.hpResult').text('');
			} else{
				isHpok = false;
				$('.hpResult').css('color', 'red').text('유효하지 않는 휴대폰입니다.');
			}
		});
		
		// 휴대폰 인증 검사하기
		$('#btnHpAuth').click(function () {
			isHpok = true; // 테스트용 코드
			hp = $('input[name=hp]').val();
			$('#phoneNumber').val(hp);
			
			if(currentHp == hp){
				alert('현재 입력하신 휴대폰은 변경되지 않은 값입니다. \n변경 후에 클릭해주세요.');
				isHpok = true;
				return;
			}
			
			if(!hp){
				alert('휴대폰 번호를 입력 해주세요.');
				return;
			}
			
			if(!isHpok){
				alert('유효하지 않은 휴대폰입니다.');
				return;
			}
			
			if(isHpClick){ // 중복확인을 이미 한번 누른 상태이면
				alert('이미 인증번호가 전송 중입니다. \n메시지를 확인 해주세요.');
				return;
			}
			
			isHpClick = true; // 중복확인 버튼을 눌렀으면 true;
			
			
			
			$.ajax({
				url: '/' + contextRoot + '/user/phoneAuth.do',
				method:'get',
				data: {"hp":hp},
				dataType:'json',
				success: function (data) {
					console.log(data);
					if(data.result != 1){
						// 메일발송 성공
						$('#phoneNumberBtn').trigger('click');			
						$('.hpResult').css("color", "black").text('인증번호를 전송했습니다. 메시지를 확인 하세요.');
						$('.hpAuth').show();
					} else {
						// 메일발송 실패
						$('.hpResult').css("color", "red").text('이미 사용중인 휴대폰입니다.');
						isHpClick = false;
					}
				}
			});
		});
		
		// 휴대폰 인증코드 확인
		$('#btnHpConfirm').click(function () {
			$('#confirmCodeBtn').trigger('click');
			$('.hpResult').css('color', 'black').text('...'); // 중복확인 클릭시 로딩중을 표시
			
			setTimeout(function() {
				if( $('#confirmCodeBtn').val() == 'true'){
					isHpok = true;
					$('.hpResult').css('color', 'green').text('휴대폰이 인증 되었습니다.');
				} else {
					isHpok = false;
					$('.hpResult').css('color', 'red').text('인증번호가 일치하지 않습니다.');
				}
			}, 2000);			
		});
		
		
		
		// 최종 폼 전송할 때
		
		$('.register > form').submit(function () {
			if((currentName == updateName) && (currentNick == updateNick) 
				&& (currentEmail == updateEmail) && (currentHp == updateHp)){
				alert('수정된 항목이 없습니다.');
				return false;
			}
			
			// 이름 검증
			if(!isNameok){
				alert('이름이 유효하지 않습니다.');
				return false;
			}
			
			// 별명 검증
			if(!isNickok){
				alert('별명을 확인 하십시요.');
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