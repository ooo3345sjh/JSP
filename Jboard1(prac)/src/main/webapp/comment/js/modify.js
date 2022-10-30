/******* 댓글 수정 *******/
 function showModifyInput(modifyBtn){ // 파라미터 - modifyBtn : 댓글 수정 버튼 <a> 태그
	
	// *강제로 취소 버튼을 클릭시키는 이벤트
	//  - 이미 한번 수정버튼을 누른 상황에서 또 다시 호출 된다는 것은 다른 댓글의 수정버튼을 클릭했다는 것으로
	//  - 취소 버튼을 클릭시켜 현재 활성화된 댓글 수정창을 지우고 댓글 목록을 보이게 한다.
	$('#modifyCancel').trigger("click");
	
	let articleTag = modifyBtn.closest('article'); // 댓글 목록의 article 태그를 선택
	let nick = articleTag.children('span.nick').text(); // 닉네임
	let content = articleTag.children('p.content').html(); // 댓글 내용
	
	let modifyTag = "<section class='commentForm'>"
		+ "  <h3>" + nick + "</h3>"
		+ " <form action='#'>"
        + " <textarea name='content' id='modifyContent'>" + content.replaceAll('<br>', '\n') + "</textarea>"
    	+ " <div>"
    	+ " <a href=''#' class='btn btnCancel ' id='modifyCancel'>취소</a>"
    	+ " <input type='submit' value='작성완료'  class='btn btnComplete' id='modifyComplete'>"
    	+ " </div>"
    	+ " </form>"
		+ "</section>";

	articleTag.hide(); // 댓글창을 숨긴다.
	articleTag.after(modifyTag); // 수정하려는 댓글의 뒤에 modifyTag를 추가한다.
	
	return articleTag;
}

function modifyComplete(modifyCompleteBtn, articleTag){ // 파라미터 - modifyCompleteBtn : 댓글 수정완료 버튼, articleTag : 수정전의 댓글의 내용을 포함하는 article태그
	
	let textarea = modifyCompleteBtn.parent().prev(); // 댓글 수정 창인 textarea태그 선택
	let comment = textarea.val() // 수정된 내용이 저장된 value값
	
	if(comment == ''){
		alert('내용을 입력해주세요.');
		textarea.focus();
		return;	
	}
	
	
	comment = comment.replace(/(?:\r\n|\r|\n)/g, '<br />'); // value값에 줄바꿈을 <br/>태그값으로 변환
	
	let no = articleTag.children('input[type=hidden]').val(); // 댓글의 번호
	let josnData = { 
			"no":no,
			"comment":comment
	}
	$.ajax({
		url:'/Jboard1/comment/modifyProc.jsp',
		type:'get',
		dataType: 'json',
		data: josnData,
		success: function (data) {
			if(data == 0){
				alert('수정 실패');
			} else{ // 수정 성공시
				articleTag.children('p.content').html(comment); // 수정된 글로 수정한다. 이떄는 text()가 아닌 html()로 저장한다. <br/>를 반영하기위함
				$('#modifyCancel').trigger("click");   // 취소 버튼을 강제로 클릭시켜 댓글 수정창을 제거한다.
			}
		}	
	});
	
}