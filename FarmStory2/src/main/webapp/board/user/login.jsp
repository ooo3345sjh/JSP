<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/_header.jsp"/>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="module" src='<c:url value='/js/googleLogin.js'/>'></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script>
	let contextRoot = location.pathname.split('/')[1]; // 컨택트루트 ex) Jboard2
	// 카카오톡 로그인
	window.Kakao.init("6278a58ba6b80f2970a19be23479d62f");
	console.log(Kakao.isInitialized()); // sdk초기화여부판단
	function kakaoLogin() {
	    Kakao.Auth.login({
	    	success: function (response) {
		    	Kakao.API.request({
		        	url: '/v2/user/me',
		        	success: function (response) {
		        		let jsonData = {
		        				"uid" : response.id,
		        				"pass" : "kakao",
		        				"nick" : response.properties.nickname,
		        				"email" : response.kakao_account.email,
		        				"gender" : response.kakao_account.gender
		        		}
		        		$.post("/" + contextRoot + '/user/kakaoLogin.do', jsonData, function(data){
							console.log(data);
		        			if(!data){
								alert('로그인에 실패 했습니다.');
							} else {
								location.href = "/" + contextRoot + "/index.do";
							}
		        		});
		          	},
		          	fail: function (error) {
		          		console.log(error)
		            	alert('로그인에 실패 했습니다.');
		         	}
		       	})
	      	}
		})
	}
	
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
                <div class="SignForm__oauthWrapper">
                	<p>SNS 간편 로그인</p>
                	<div>
      					<div id="naver_id_login"></div>
	                    <a href="#" id='naverLogin'>
	                    	<img alt="네이버" src='<c:url value='/board/img/naver-login.png'/>'>
	                    </a>
	                    <!-- 네이버 스크립트 -->
						<script>
							var naver_id_login = new naver_id_login("6rcEp4ee87ghzsC7eyL6", "http://junghyun.site/FarmStory2/index.do");
							var state = naver_id_login.getUniqState();
							//naver_id_login.setButton("white", 2,40);
							naver_id_login.setDomain("http://localhost");
							naver_id_login.setState(state);
							naver_id_login.init_naver_id_login();
						</script>
	                    <a href="#" id="googleLogin">
	                    	<img alt="구글" src='<c:url value='/board/img/google-login.png'/>'>
	                    </a>
	                    <a href="javascript:kakaoLogin();">
	                    	<img alt="카카오" src='<c:url value='/board/img/kakao-talk.svg'/>'>
	                    </a>
                	</div>
                </div>
                <div>
                    <h3>회원 로그인 안내</h3>
                    <p>아직 회원이 아니시면 회원으로 가입하세요.</p>
                    <div style="text-align: right;">
                        <a href="<c:url value="/user/findId.do"/>">아이디 찾기 |</a>
                        <a href="<c:url value="/user/findPw.do"/>">비밀번호 찾기 |</a>
                        <a href="<c:url value="/user/terms.do"/>">회원가입</a>
                    </div>                    
                </div>
            </section>
        </main>
<jsp:include page="/_footer.jsp"/>