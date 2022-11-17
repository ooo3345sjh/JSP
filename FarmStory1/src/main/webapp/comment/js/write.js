/******* 댓글 작성 *******/
 function write(no){ // 파라미터 - no : 게시글 번호
	
	let comment = $('#comment'); // 댓글 쓰기의 textarea 태그
	let commentVal = comment.val().replace(/(?:\r\n|\r|\n)/g, '<br />'); // 줄바꿈을 적용해준다.
	
	if(commentVal == ""){ // 내용을 입력하지 않을 경우
		alert("내용을 입력해주세요.");
		comment.val('');
		comment.focus(); 
		return;
	}
	
	let jsonData = {
			"no": no, 
			"comment":commentVal // 댓글 내용
	}
	
	$.ajax({
		url : '/FarmStory1/comment/writeProc.jsp',
		type : 'get',
		data : jsonData,
		dataType : 'json',
		success : function(data) {
			if(data.result == 0){
				alert('댓글 작성 실패');
			} else {
				$(".empty").hide(); // 댓글을 추가함으로 empty 클래스를 숨긴다.
				
				let article = "<article>"
					+ " <input type='hidden' value='" + data.no + "'/>"
					+ " <span class='nick'>" + data.nick + "</span>"
	                + " <span class='date'>" + data.rdate + "</span>"
					+ " <p class='content'>" + commentVal + "</p>"
					+ " <div>"
                    + " <a href='#' class='remove'>삭제</a>"
                    + " <a href='#' class='modify'>수정</a>"
                	+ " </div>"
					+ "</article>";
					
				$('.commentList').append(article); // 댓글 추가
				
				comment.val(""); // 댓글 내용 비우기
			}
			
		}
	});
}

