<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/_header.jsp"/>
<script>
	const contextRoot = location.pathname.split('/')[1]; // 컨택트루트 ex) Jboard2
	const uid = '${reqUser.uid}'; 
	$(function () {
		$('.btnNext').click(function () {
			const pass = $('input[name=pass]').val();
			if(pass == ''){
				alert('비밀번호를 입력해주세요.');
				return;
			}
			console.log(pass);
			let jsonData = {
					"uid":uid,
					"pass":pass
			}
			$.ajax({
				url: "/" + contextRoot + "/user/info.do",
				method: 'post',
				data : jsonData,
				dataType: 'json',
				success: function (data) {
					if(data.result == 1){
						location.href = "/" + contextRoot + "/user/myInfo.do"
					} else {
						alert('비밀번호가 일치하지 않습니다.');
					}
				}
			})
		})
	})
</script>
        <main id="user">
            <section class="find findId">
                <form action='<c:url value="/user/findIdResult.do"/>' method="post">
                	<input type="hidden" name="findId_Pw" value="true">
                    <table border="0">
                        <caption>비밀번호 확인</caption>
                        <tr>
                            <td>비밀번호</td>
                            <td>
                            	<input type="password" name="pass" placeholder="비밀번호 입력"/>
                            	<span class="nameResult"></span>
                            </td>
                        </tr>
                    </table>                                        
                </form>
                
                <p>
                    회원님의 정보를 보호하기 위해 비밀번호를 다시 확인합니다.
                </p>

                <div>
                    <a href='<c:url value="javascript:history.back();"/>' class="btn btnCancel">취소</a>
                    <a href='<c:url value="#"/>' class="btn btnNext">다음</a>
                </div>
            </section>
        </main>
<jsp:include page="/_footer.jsp"/>