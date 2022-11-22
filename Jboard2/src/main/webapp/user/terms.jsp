<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script>
	function isChecked() {
		let terms = document.getElementById("terms");
		let privacy = document.getElementById("privacy");
		
		if(!terms.checked){
			alert("사이트 이용약관 동의 체크를 해주세요.");
			return false;
		}
		if(!privacy.checked){
			alert("개인정보 취급방침 동의 체크를 해주세요.");
			return false;
		}
		return true;
	}
</script>
        <main id="user">
            <section class="terms">
                <table border="1">
                    <caption>사이트 이용약관</caption>
                    <tr>
                        <td>
                            <textarea name="terms" readonly>${terms.terms}</textarea>
                            <label><input type="checkbox" id="terms">&nbsp;동의합니다.</label>
                        </td>
                    </tr>
                </table>

                <table border="1">
                    <caption>개인정보 취급방침</caption>
                    <tr>
                        <td>
                            <textarea name="privacy" readonly>${terms.privacy}</textarea>
                            <label><input type="checkbox" id="privacy">&nbsp;동의합니다.</label>
                        </td>
                    </tr>
                </table>
                
                <div>
                    <a href="/Jboard2/user/login.do" class="btn btnCancel">취소</a>
                    <a href="/Jboard2/user/register.do" class="btn btnNext" onclick="return isChecked();">다음</a>
                </div>

            </section>
        </main>
<jsp:include page="./_footer.jsp"/>