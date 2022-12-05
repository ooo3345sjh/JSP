/**
 * 네이버 스마트 편집기
 */
 
 function smarteditor (){
	
	$(function () {
		let contextRoot = location.pathname.split('/')[1]; // 컨택트루트 ex) Jboard2
		let oEditors = []
	
	    smartEditor = function() {
	     	console.log("Naver SmartEditor")
	     	nhn.husky.EZCreator.createInIFrame({
	        oAppRef: oEditors,
	        elPlaceHolder: "editorTxt",
	        sSkinURI: "/" + contextRoot + "/smartEditor/SmartEditor2Skin.html",
	        fCreator: "createSEditor2"
	        });
	    }
	
	    $(document).ready(function() {
	      smartEditor();
	    })
	    
		$('form').submit(function (e) {
			oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", [])
	       	let inputTitle = $('textarea[name=title]');
	       	let content = $('#editorTxt').val().replace(/<br style="clear:both;">/g, '');
	       	
	       	console.log("내용 : " + content);
				
	       	let arr = content.match(/image.{29}/g); // 이미지 경로값 배열
	       	console.log("이미지 : " + arr);
	       	if(arr != null){
		    	$('input[name=img]').val(arr.join('/')); // 이미지 경로값을 '/'로 이어붙여 input[name=img]의 value값에 대입
	       	}
	       	
			if(inputTitle.val() == ''){
				alert("제목을 입력해주세요.");
				inputTitle.focus();
				return false;
			}
				
	 		if(!content || content == '<p>&nbsp;</p>') {
	   			alert("내용을 입력해주세요.");
	   			oEditors.getById["editorTxt"].exec("FOCUS");
				return false;
	 		} else {
	   			$('#editorTxt').submit();
				return true;
			}
			
				
			
		});
		
	});
	
}