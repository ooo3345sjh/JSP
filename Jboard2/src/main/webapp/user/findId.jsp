<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="./_header.jsp"/>
<script src="${pageContext.servletContext.contextPath}/js/emailAuth.js"></script>
<script>
	function isChecked() {
		
		if(!isEmailAuthok){
			alert("이메일 인증 후에 다시 시도해주세요.");
			$('input[name=auth]').select();
			return false;
		}
		
		let name = $('input[name=name]').val();
				
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
				if(data.result == 1){ // 입력한 정보와 일치하는 회원이 있음
					$('form').submit();
				} else {
					alert('일치하는 회원정보가 없습니다.\n입력하신 정보가 회원정보와 일치하는지 확인해 주세요.');
				} 
			}
		});
		return false;
	}
</script>

        <main id="user">
            <section class="find findId">
                <form action='<c:url value="/user/findIdResult.do"/>' method="post">
                	<input type="hidden" name="findId_Pw" value="true">
                    <table border="0">
                        <caption>아이디 찾기</caption>
                        <tr>
                            <td>이름</td>
                            <td>
                            	<input type="text" name="name" placeholder="이름 입력"/>
                            	<span class="nameResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td>
                                <div>
                                    <input type="email" name="email" placeholder="이메일 입력"/>
                                    <button type="button" class="btnAuth" id="btnEmail">인증번호 받기</button>
                                </div>
                                <div>
                                    <input type="text" name="auth" id="auth" disabled placeholder="인증번호 입력"/>
                                    <button type="button" class="btnConfirm" id="btnEmailConfirm">확인</button>
                                    <br/><span class="resultEmail"></span>
                                </div>
                            </td>
                        </tr>                        
                    </table>                                        
                </form>
                
                <p>
                    회원가입시 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.<br>
                    인증번호를 입력 후 확인 버튼을 누르세요.
                </p>

                <div>
                    <a href='<c:url value="/user/login.do"/>' class="btn btnCancel">취소</a>
                    <a href='<c:url value="/user/findIdResult.do"/>' class="btn btnNext" onclick="return isChecked();" >다음</a>
                </div>
            </section>
        </main>
<jsp:include page="./_footer.jsp"/>