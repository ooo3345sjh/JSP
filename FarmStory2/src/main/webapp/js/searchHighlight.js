/**
 * 
 */
 
 // 검색어 하이라이트(참고 사이트 : https://nyol.tistory.com/m/159)
$(document).ready(function () {
	let searchFeild = $("select[name='searchField'] option:selected").val();
	
	let regex = new RegExp(searchWord, 'gi'); // g (global, 전역 판별) 처음 일치에서 중단하지 않고, 문자열 전체를 판별합니다.
											  // i (ignore case, 대소문자 무시)				
	let matcheWord; 
	if(searchWord != ''){
		
		if(searchFeild == 'title'){
			$(".view > a").each(function () {
				
				matcheWord = $(this).text().match(regex); // 정규식 표현에 해당하는 단어만 추출한다.
				matcheWord = Array.from(new Set(matcheWord));
				if(matcheWord.length > 1){
					for(let i=0; i<matcheWord.length; i++){
						if(matcheWord[i].match(/[A-Z]/g)){
							if(i == 0){
								console.log('start')
								let temp = matcheWord[i+1];
								matcheWord[i+1] = matcheWord[i];
								matcheWord[i] = temp;
							}
						};
					}
				}
				console.log(matcheWord);
				
				
				// 정규 표현식에 해당하는 부분을 replace를 사용하여 스타일을 바꾼다.
				let replaceWord = $(this).text();
				for (let i=0; i<2; i++) { // ex) 대소문자인 경우 매칭된 단어가 2개가 되므로 각각 매칭된 단어를 반복문으로 reaplace한다.
					if(!matcheWord[i]) break;
					replaceWord = replaceWord.replace(new RegExp(matcheWord[i], 'g'), "<span style='font-weight:bold; color:#D50000;'>" + matcheWord[i] + "</span>")
				}
				
				$(this).html(replaceWord); // replace된 텍스트를 삽입
			})
		} else if(searchFeild == 'nick') {
			$(".nick").each(function () {
				matcheWord = $(this).text().match(regex); // 정규식 표현에 해당하는 단어만 추출한다.
				
				// 정규 표현식에 해당하는 부분을 replace를 사용하여 스타일을 바꾼다.
				let replaceWord = $(this).text();
				
				for (let word of matcheWord) { // ex) 대소문자인 경우 매칭된 단어가 2개가 되므로 각각 매칭된 단어를 반복문으로 reaplace한다.
					replaceWord = replaceWord.replace(word, "<span style='font-weight:bold; color:#D50000;'>" + word + "</span>")
				}
				
				$(this).html(replaceWord); // replace된 텍스트를 삽입
			})
		}
	}
})