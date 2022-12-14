<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/_header.jsp"/>
<script type="module" src='<c:url value='/js/phoneAuth.js'/>'></script>
<script src='<c:url value='/js/validation.js'/>'></script>
<script src='<c:url value='/js/zipcode.js'/>'></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- 우편번호 찾기 오픈 API -->
        <main id="user">
            <section class="register">
                <form action='<c:url value="/user/register.do"/>' method="post">
                    <table border="1">
                        <caption>사이트 이용정보 입력</caption>
                        <tr>
                            <td>아이디</td>
                            <td>
                                <input type="text" name="uid" placeholder="아이디 입력"/>
                                <button type="button" id="btnIdCheck"><img src='<c:url value='/board/img/chk_id.gif'/>' alt="중복확인"/></button>
                                <span class="uidResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td><input type="password" name="pass1" placeholder="비밀번호 입력"/></td>
                        </tr>
                        <tr>
                            <td>비밀번호 확인</td>
                            <td>
	                            <input type="password" name="pass2" placeholder="비밀번호 입력 확인"/>
	                            <span class="passResult"></span>
                            </td>
                        </tr>
                    </table>

                    <table border="1">
                        <caption>개인정보 입력</caption>
                        <tr>
                            <td>이름</td>
                            <td>
                                <input type="text" name="name" placeholder="이름 입력"/>                        
	                            <span class="nameResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>별명</td>
                            <td>
                                <p class="nickInfo">공백없는 한글, 영문, 숫자 입력</p>
                                <input type="text" name="nick" placeholder="별명 입력"/>
                                <button type="button" id="btnNickCheck"><img src='<c:url value='/board/img/chk_id.gif'/>' alt="중복확인"/></button>
                                <span class="nickResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td>
                                
                                <input type="email" name="email" placeholder="이메일 입력"/>
                                <button type="button" id="btnEmailAuth"><img src='<c:url value='/board/img/chk_auth.gif'/>' alt="인증번호 받기"/></button>
                                
                                <div class="auth">
                                    <input type="text" name="auth" placeholder="인증번호 입력"/>
                                    <button type="button" id="btnEmailConfirm"><img src='<c:url value='/board/img/chk_confirm.gif'/>' alt="확인"/></button>
                                </div>
                                <br/><span class="emailResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>휴대폰</td>
                            <td>
                            	<input type="text" name="hp" placeholder="휴대폰 입력"/>
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
                                <input type="text" name="zip" id="zip" placeholder="우편번호"/>
                                <button type="button" onclick="zipcode()"><img src='<c:url value='/board/img/chk_post.gif'/>' alt="우편번호찾기"/></button>
                                <input type="text" name="addr1" id="addr1" placeholder="주소 검색"/>
                                <input type="text" name="addr2" id="addr2" placeholder="상세주소 입력"/>
                            </td>
                        </tr>
                    </table>

                    <div>
                        <a href="<c:url value="/user/login.do"/>" class="btn btnCancel">취소</a>
                        <input type="submit" value="회원가입" class="btn btnRegister"/>
                    </div>

                </form>

            </section>
        </main>
<jsp:include page="/_footer.jsp"/>