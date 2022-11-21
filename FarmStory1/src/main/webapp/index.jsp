<%@page import="java.util.Map"%>
<%@page import="kr.co.FarmStory1.vo.ArticleVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.FarmStory1.dao.BoardDAO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
 	Map<String, List<ArticleVO>> map = new BoardDAO().selectLatests("grow", "school", "story");
	List<ArticleVO> grows = map.get("grow"); 
	List<ArticleVO> storys = map.get("story"); 
	List<ArticleVO> schools = map.get("school"); 
%>
<script>
	$(function () {
		
		// 공지사항 최신글 가져오기
		getLatest('notice');
		getLatest('qna');
		getLatest('faq');
		
		function getLatest(cate) {
			let url = "/FarmStory1/board/proc/getLatest.jsp?cate=" + cate;
			$.get(url, function(data) {
				if(data.length != 0){
					for(let latest of data){
						$('.txt-'+cate).append("<li><a href='/FarmStory1/board/view.jsp?group=community&cate="
								+ cate +"&no=" + latest.no + "&pg=1'>" 
								+ "· "+latest.title 
								+ "</a></li>");
					}
				} else {
					$('.txt-'+cate).append("<li><a>· 최신 글이 없습니다.</a></li>");
				}
			});
		}
	});
</script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script>
	$(function () {
		$('.slide_gallery').bxSlider({
			controls : false,
			auto : true,
			pager : false
		});
		
		$('#tabs').tabs();
	});
</script>
<main>
    <div class="slider">
    	<div class="gallery_wrap">
    		<ul class="slide_gallery">
    			<li><img src="./img/main_slide_img1.jpg" alt="슬라이더1"> </li>
    			<li><img src="./img/main_slide_img2.jpg" alt="슬라이더2"> </li>
    			<li><img src="./img/main_slide_img3.jpg" alt="슬라이더3"> </li>
    		</ul>
    	</div>
    	<img alt="사람과 자연을 사랑하는 팜스토리" src="./img/main_slide_img_tit.png">
    	<div class="banner">
    		<img alt="GRAND OPEN" src="./img/main_banner_txt.png">
    		<img alt="팜스토리 오픈기념 30% 할인 이벤트" src="./img/main_banner_tit.png">
    		<img alt="과일" src="./img/main_banner_img.png">
    	</div>
    </div>
    <div class="quick">
        <a href="/FarmStory1/board/list.jsp?group=community&cate=menu">
        	<img src="./img/main_banner_sub1_tit.png" alt="오늘의 식단">
        </a>
        <a href="/FarmStory1/board/list.jsp?group=community&cate=chef">
        	<img src="./img/main_banner_sub2_tit.png" alt="나도 요리사">
        </a>
    </div>
    <div class="latest">
        <div>
            <a href="/FarmStory1/board/list.jsp?group=croptalk&cate=grow">
                <img src="./img/main_latest1_tit.png" alt="텃밥 가꾸기">
            </a>
            <img src="./img/main_latest1_img.jpg" alt="이미지">
            <table border="0">
            	<% 
            	if(grows.size() != 0){
            		for(ArticleVO vo : grows){
            	%>
                <tr>
                    <td>></td>
                    <td>
                        <a href="/FarmStory1/board/view.jsp?group=croptalk&cate=grow&no=<%= vo.getNo()%>&pg=1"><%= vo.getTitle() %></a>
                    </td>
                    <td><%= vo.getRdate() %></td>
                </tr>
                <%
                	}
            	}else{
            	%>
            	<tr>
            		<td colspan="2" width="200px">> 최신 글이 없습니다.</td>
            	</tr>
            	<% } %>
            </table>
        </div>
        <div>
            <a href="/FarmStory1/board/list.jsp?group=croptalk&cate=school">
                <img src="./img/main_latest2_tit.png" alt="귀농학교">
            </a>
            <img src="./img/main_latest2_img.jpg" alt="이미지">
            <table border="0">
            	<% 
            	if(schools.size() != 0){
            		for(ArticleVO vo : schools){
            	%>
                <tr>
                    <td>></td>
                    <td>
                        <a href="/FarmStory1/board/view.jsp?group=croptalk&cate=grow&no=<%= vo.getNo()%>&pg=1"><%= vo.getTitle() %></a>
                    </td>
                    <td><%= vo.getRdate() %></td>
                </tr>
                <%
                	}
            	}else{
            	%>
            	<tr>
            		<td colspan="2" width="200px">> 최신 글이 없습니다.</td>
            	</tr>
            	<% } %>
            </table>
        </div>
        <div>
            <a href="/FarmStory1/board/list.jsp?group=croptalk&cate=story">
                <img src="./img/main_latest3_tit.png" alt="농작물 이야기">
            </a>
            <img src="./img/main_latest3_img.jpg" alt="이미지">
            <table border="0">
            	<% 
            	if(storys.size() != 0){
            		for(ArticleVO vo : storys){
            	%>
                <tr>
                    <td>></td>
                    <td>
                        <a href="/FarmStory1/board/view.jsp?group=croptalk&cate=grow&no=<%= vo.getNo()%>&pg=1"><%= vo.getTitle() %></a>
                    </td>
                    <td><%= vo.getRdate() %></td>
                </tr>
                <%
                	}
            	}else{
            	%>
            	<tr>
            		<td colspan="2" width="200px">> 최신 글이 없습니다.</td>
            	</tr>
            	<% } %>
            </table>
        </div>
    </div>
    <div class="info">
        <div>
            <img src="./img/main_sub2_cs_tit.png" class="tit" alt="고객센터안내">
            <div class="tel">
                <img src="./img/main_sub2_cs_img.png" alt="전화기 이미지">
                <img src="./img/main_sub2_cs_txt.png" alt="1666-777">
                <p class="time">
                    평일: AM 09:00 ~ PM 06:00 <br>
                    점심: PM 12:00 ~ PM 01:00 <br>
                    토, 일요일, 공휴일 휴무
                </p>
            </div>
            <div class="btns">
                <a href="/FarmStory1/board/list.jsp?group=community&cate=qna">
                    <img src="./img/main_sub2_cs_bt1.png" alt="1:1 고객문의">
                </a>
                <a href="/FarmStory1/board/list.jsp?group=community&cate=faq">
                    <img src="./img/main_sub2_cs_bt2.png" alt="자주묻는 질문">
                </a>
                <a href="#">
                    <img src="./img/main_sub2_cs_bt3.png" alt="배송 조회">
                </a>
            </div>
        </div>
        <div>
            <img src="./img/main_sub2_account_tit.png" class="tit" alt="계좌안내">
            <p class="account">
                기업은행 123-456789-01-01-012</br>
                국민은행 01-1234-56789</br>
                우리은행 123-456789-01-01-012</br>
                하나은행 123-456789-01-01</br>
                예 금 주 (주)팜스토리
            </p>
        </div>
        <div>
        	<div id="tabs">
	            <ul>
	                <li><a href="#tabs-1">공지사항</a></li>
	                <li><a href="#tabs-2">1:1 고객문의</a></li>
	                <li><a href="#tabs-3">자주묻는 질문</a></li>
	            </ul>
	            <div id="tabs-1">
	                <ul class="txt txt-notice"></ul>
	            </div>
	            <div id="tabs-2">
	                <ul class="txt txt-qna"></ul>
	            </div>
	            <div id="tabs-3">
	                <ul class="txt txt-faq"></ul>
	            </div>
	        </div>
        </div>
    </div>
</main>
<%@ include file="/_footer.jsp" %>