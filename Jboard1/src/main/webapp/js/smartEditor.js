/**
 * 네이버 스마트 편집기
 */
 
 function smarteditor (){
	
	$(function () {
		    let oEditors = []
		
		    smartEditor = function() {
		     	console.log("Naver SmartEditor")
		     	nhn.husky.EZCreator.createInIFrame({
		        oAppRef: oEditors,
		        elPlaceHolder: "editorTxt",
		        sSkinURI: "/Jboard1/smartEditor/SmartEditor2Skin.html",
		        fCreator: "createSEditor2"
		        });
		    }
		
		    $(document).ready(function() {
		      smartEditor();
		    })
		    
	});
	
}