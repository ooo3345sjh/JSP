<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/_header.jsp"/>
<script type="module" src='<c:url value='/js/phoneAuth.js'/>'></script>
<script src='<c:url value='/js/myinfo_validation.js'/>'></script>
<script src='<c:url value='/js/zipcode.js'/>'></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- 우편번호 찾기 오픈 API -->
<script>
	const uid = '${reqUser.uid}'; 
	$(function () {
		$('.passUpdate').click(function () {
			
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $('input[name=pass2]').val();
			
			// 비밀번호 유효성 체크
			if(!confirm('정말 수정 하시겠습니까?')){
				return;
			}
			else if(pass1 == '' || pass2 == ''){
				alert('비밀번호를 입력 해주세요.');
				return;
			}
			else if(pass1 != pass2){
				alert('비밀번호가 일치 하지 않습니다.');
				return;
			} 
			else if(!isPassok){
				alert('숫자,영문,특수문자 포함 5자리 이상 이어야 합니다.');				
				return;
			} 
			
			let jsonData = {
					"uid":uid,
					"pass1":pass1
			}
			
			$.ajax({
				url: "/" + contextRoot + "/user/findPwChange.do",
				method: 'post',
				data : jsonData,
				dataType: 'json',
				success: function (data) {
					if(data.result == 1){
						$('.passResult').css("color", "green").text("비밀번호가 수정되었습니다.")
					} else {
						$('.passResult').css("color", "green").text("비밀번호가 수정에 실패했습니다.")
					}
				}
			})
		})
		
		$('#unRegister').click(function (e) {
			e.preventDefault();
			if(!confirm('정말 탈퇴 하시겠습니까?')){
				return;
			}
			let jsonData = {
					"uid":uid,
			}
			
			$.ajax({
				url: "/" + contextRoot + "/user/unregister.do",
				method: 'post',
				data : jsonData,
				dataType: 'json',
				success: function (data) {
					if(data.result == 1){
						alert("회원탈퇴가 정상적으로 완료되었습니다.");
						location.href = "/" + contextRoot + "/user/logout.do";
					} else {
						alert("회원탈퇴에 실패했습니다.")
					}
				}
			})
		})
		
	})
</script>
        <main id="user">
            <section class="register">
                <form action='<c:url value="/user/myInfo.do"/>' method="post">
                    <table border="1">
                        <caption>회원정보 설정</caption>
                        <tr>
                            <td>아이디</td>
                            <td>${reqUser.uid}</td>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td><input type="password" name="pass1" placeholder="비밀번호 입력"/></td>
                        </tr>
                        <tr>
                            <td>비밀번호 확인</td>
                            <td>
	                            <input type="password" name="pass2" placeholder="비밀번호 입력 확인"/>
	                            <button type="button" class='passUpdate' style="vertical-align: baseline;">
	                            비밀번호 수정	
	                            </button>
	                            <span class="passResult"></span>
                            </td>
                        </tr>
                        <tr>
                        	<td>회원가입일</td>
                       		<td>${reqUser.rdate}</td>
                        </tr>
                    </table>

                    <table border="1">
                        <caption>개인정보 수정</caption>
                        <tr>
                            <td>이름</td>
                            <td>
                                <input type="text" name="name" placeholder="이름 입력" value="${reqUser.name}"/>                        
	                            <span class="nameResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>별명</td>
                            <td>
                                <p class="nickInfo">공백없는 한글, 영문, 숫자 입력</p>
                                <input type="text" name="nick" placeholder="별명 입력" value="${reqUser.nick}"/>
                                <button type="button" id="btnNickCheck"><img src='<c:url value='/board/img/chk_id.gif'/>' alt="중복확인"/></button>
                                <br/><span class="nickResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td>
                                
                                <input type="email" name="email" placeholder="이메일 입력" value="${reqUser.email}"/>
                                <button type="button" id="btnEmailAuth"><img src='<c:url value='/board/img/chk_auth.gif'/>' alt="인증번호 받기"/></button>
                                
                                <div class="auth">
                                    <input type="text" name="auth" placeholder="인증번호 입력"/>
                                    <button type="button" id="btnEmailConfirm"><img src='<c:url value='/board/img/chk_confirm.gif'/>' alt="확인"/></button>
                                </div>
                                <span class="emailResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>휴대폰</td>
                            <td>
                            	<input type="text" name="hp" placeholder="휴대폰 입력" value="${reqUser.hp}"/>
                            	<input type="hidden" id="phoneNumberBtn"/> <!-- firebase 인증번호 요청 -->
                            	<input type="hidden" id="phoneNumber"/>	   <!-- firebase 휴대폰 번호값 -->
                                <button type="button" id="btnHpAuth"><img src='<c:url value='/board/img/chk_auth.gif'/>' alt="인증번호 받기"/></button>
                                
                                <div class="hpAuth">
                            		<input type="hidden" id="confirmCodeBtn" value="false"> <!-- firebase 인증코드 전송 -->
                                    <input type="text" name="auth" id="confirmCode" placeholder="인증번호 입력"/>
                                    <button type="button" id="btnHpConfirm"><img src='<c:url value='/board/img/chk_confirm.gif'/>' alt="확인"/></button>
                                </div>
                                <br/><span class="hpResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>주소</td>
                            <td>
                                <input type="text" name="zip" id="zip" placeholder="우편번호" value="${reqUser.zip}"/>
                                <button type="button" onclick="zipcode()"><img src='<c:url value='/board/img/chk_post.gif'/>' alt="우편번호찾기"/></button>
                                <input type="text" name="addr1" id="addr1" placeholder="주소 검색" value="${reqUser.addr1}"/>
                                <input type="text" name="addr2" id="addr2" placeholder="상세주소 입력" value="${reqUser.addr2}"/>
                            </td>
                        </tr>
                        <tr>
                        	<td>회원탈퇴</td>
                        	<td>
                        		<button id="unRegister" type="button" style="padding: 6px; background: #ed2f22; color: #fff;">탈퇴하기</button>
                        	</td>
                        </tr>
                    </table>

                    <div>
                        <a href="<c:url value="/index.do"/>" class="btn btnCancel">취소</a>
                        <input type="submit" value="회원수정" class="btn btnRegister"/>
                    </div>

                </form>

            </section>
        </main>
<jsp:include page="/_footer.jsp"/>