/******* 댓글 목록 출력 *******/
function list (no, uid) { // 파라미터 - no : 게시글 번호, uid : 로그인한 회원 아이디
	$(function(){
	
	let jsonData = { 
			"no":no 
	};
	
	$.ajax({
		url:'/Jboard1/comment/listProc.jsp',
		type:'get',
		dataType: 'json',
		data: jsonData,
		success: function (data) {
			
			if(data.length != 0){ // 반환 받은 JSON 데이터가 있을 떄
				$(".empty").hide(); // 반환 받은 데이터가 존재하므로 empty 클래스를 숨긴다.
				
				for(let comment of data){
					let article = "<article>"
								+ " <input type='hidden' value='" + comment.no + "'/>"
								+ " <span class='nick'>" + comment.nick + "</span>"
				                + " <span class='date'>" + comment.rdate.substr(2, 9) + "</span>" // yy-MM-dd
								+ " <p class='content'>" + comment.comment + "</p>";
					if(comment.uid == uid){
						article	+= " <div>";
						article += " <a href='#' class='remove'>삭제</a>";
						article += " <a href='#' class='modify'>수정</a>";
						article += " </div>";
					}
								
					article += "</article>";
								
					$('.commentList').append(article); // commentList태그안에 article태그를 추가한다.
				}
			}
		}
	});
	});
}