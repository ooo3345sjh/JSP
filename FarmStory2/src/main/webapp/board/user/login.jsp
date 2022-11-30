<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/_header.jsp"/>
<script>
	function checkCapsLock(event)  {
	  if (event.getModifierState("CapsLock")) {
		  $('#capsLock').show();
	  } else {
		  $('#capsLock').hide();
	  }
	}
</script>
        <main id="user">
            <section class="login">
                <form action='<c:url value="/user/login.do"/>' method="post">
                    <table border="0">
                        <tr>
                            <td><img src="<c:url value="/img/login_ico_id.png"/>" alt="아이디"/></td>
                            <td><input type="text" name="uid" placeholder="아이디 입력"/></td>
                        </tr>
                        <tr>
                            <td><img src="<c:url value="/img/login_ico_pw.png"/>" alt="비밀번호"/></td>
                            <td><input type="password" name="pass" placeholder="비밀번호 입력" onkeydown="checkCapsLock(event);"/></td>
                        </tr>
                    </table>
                    <!-- CapsLock 활성 여부 알림 태그 -->
                    <p id='capsLock' style="color: red;margin-left: 79px; display: none;">
                    	<span style="font-weight: bold">CapsLock</span>이 켜져있습니다.
                    </p>
                    
                    <input type="submit" value="로그인" class="btnLogin"/>
                    <label><input type="checkbox" name="auto">자동 로그인</label>
                </form>
                <div>
                    <h3>회원 로그인 안내</h3>
                    <p>
                        아직 회원이 아니시면 회원으로 가입하세요.
                    </p>
                    <div style="text-align: right;">
                        <a href="<c:url value="/user/findId.do"/>">아이디 찾기 |</a>
                        <a href="<c:url value="/user/findPw.do"/>">비밀번호 찾기 |</a>
                        <a href="<c:url value="/user/terms.do"/>">회원가입</a>
                    </div>                    
                </div>
            </section>
        </main>
<jsp:include page="/_footer.jsp"/>