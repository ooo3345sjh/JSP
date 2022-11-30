<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/_header.jsp"/>
<jsp:include page="/${group}.jsp"/>
<script>
	function validateForm(form) {
		if(!form.title.value){
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if(!form.content.value){
			alert("내용을 입력하세요.");
			form.content.focus();
			return false;
		}
	}
	
	$(function () {
		$('.upload').click(function () {
			$('input[type=file]').trigger("click");
		});
		
		$('input[type=file]').change(function () {
			let file = $('input[type=file]').val();
			let fileName = file.split("\\");
			console.log(file);
			console.log(fileName);
			$('#fname').text(fileName[2]);
		})
	});
</script>
        <main id="board">
            <section class="write">

                <form action='<c:url value="/board/write.do"/>' method="post" enctype="multipart/form-data" onsubmit="return validateForm(this);">
                	<input type="hidden" name="group" value="${group}">
                	<input type="hidden" name="cate" value="${cate}">
                    <table border="0">
                        <caption>글쓰기</caption>
                        <tr>
                            <th>제목</th>
                            <td><input type="text" name="title" placeholder="제목을 입력하세요."/></td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <textarea name="content" placeholder="내용을 입력하세요."></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>파일</th>
                            <td>
                                <input type="file" name="oriName" style="display:none;"/>
                                <button type="button" class="btn upload">업로드</button>&nbsp;<span id="fname">선택된 파일 없음</span>
                            </td>
                        </tr>
                    </table>
                    
                    <div>
                        <a href='#' class="btn btnCancel" onclick="history.back()">취소</a>
                        <input type="submit" value="작성완료" class="btn btnComplete"/>
                    </div>
                </form>

            </section>
        </main>
        </article>
	</section>
</div>
<jsp:include page="/_footer.jsp"/>