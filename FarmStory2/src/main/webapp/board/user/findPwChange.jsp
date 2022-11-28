<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/_header.jsp"/>
<script src="${pageContext.servletContext.contextPath}/js/validation.js"></script>
<script>
	function checkPass() {
		let pass1 = $('input[name=pass1]').val();
		let pass2 = $('input[name=pass2]').val();
		let uid = $('#uid').text();
		console.log("uid : " + uid);
		console.log("pass2 : " + pass2);
		
		
		if(pass1 != pass2){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		
		if(!isPassok){
			alert("숫자,영문,특수문자 포함 5자리 이상 이어야 합니다");
			return false;
		}
		
		let jsonData= {
				'pass1':pass1,
				'uid':uid
		}
		
		$.ajax({
			url: "/" + contextRoot + '/user/findPwChange.do',
			method:'post',
			data: jsonData,
			dataType:'json',
			success: function (data) {
				if(data.result == 1){
					alert("비밀번호가 변경되었습니다. 로그인 해주세요.");
					location.href = "/" + contextRoot + '/user/login.do'
				} else {
					alert("비밀번호 변경에 실패 했습니다. 잠시 후 다시 시도해주세요.");
				} 
			}
		});
		
		return false;
	}
</script>
        <main id="user">
            <section class="find findPwChange">
                <form action='<c:url value="/user/findPwChange.do"/>' method="post">
                    <table border="0">
                        <caption>비밀번호 변경</caption>                        
                        <tr>
                            <td>아이디</td>
                            <td id="uid">${uid}</td>
                        </tr>
                        <tr>
                            <td>새 비밀번호</td>
                            <td>
                                <input type="password" name="pass1" placeholder="새 비밀번호 입력"/>
                            </td>
                        </tr>
                        <tr>
                            <td>새 비밀번호 확인</td>
                            <td>
                                <input type="password" name="pass2" placeholder="새 비밀번호 입력"/>
                            </td>
                        </tr>
                    </table>                                        
                </form>
                
                <p>
                    비밀번호를 변경해 주세요.<br>
                    영문, 숫자, 특수문자를 사용하여 5자 이상 입력해 주세요.                    
                </p>

                <div>
                    <a href='<c:url value="/user/login.do"/>' class="btn btnCancel">취소</a>
                    <a href='<c:url value="/user/login.do"/>' class="btn btnNext" onclick="return checkPass();">다음</a>
                </div>
            </section>
        </main>
<jsp:include page="/_footer.jsp"/>