<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="./_header.jsp"/>
        <main>
            <div class="slider">
                <ul>
                    <li><img src='<c:url value='/img/main_slide_img1.jpg'/>' alt="슬라이더1"></li>
                    <li><img src='<c:url value='/img/main_slide_img2.jpg'/>' alt="슬라이더2"></li>
                    <li><img src='<c:url value='/img/main_slide_img3.jpg'/>' alt="슬라이더3"></li>
                </ul>

                <img src='<c:url value='/img/main_slide_img_tit.png'/>' alt="사람과 자연을 사랑하는 팜스토리"/>

                <div class="banner">
                    <img src='<c:url value='/img/main_banner_txt.png'/>' alt="GRAND OPEN"/>
                    <img src='<c:url value='/img/main_banner_tit.png'/>' alt="팜스토리 오픈기념 30% 할인 이벤트"/>
                    <img src='<c:url value='/img/main_banner_img.png'/>' alt="과일"/>
                </div>
            </div>

            <div class="quick">
                <a href='<c:url value='/board/list.do?group=community&cate=2'/>'><img src='<c:url value='/img/main_banner_sub1_tit.png'/>' alt="오늘의 식단"></a>
                <a href='<c:url value='/board/list.do?group=community&cate=3'/>'><img src='<c:url value='/img/main_banner_sub2_tit.png'/>' alt="나도 요리사"></a>                
            </div>

            <div class="latest">
                <div>
                    <a href='<c:url value='/board/list.do?group=croptalk&cate=2'/>'><img src='<c:url value='/img/main_latest1_tit.png'/>' alt="텃밭 가꾸기"/></a>
                    <img src='<c:url value='/img/main_latest1_img.jpg'/>' alt="이미지"/>
                    <table border="0">
                    	<c:choose>
                    		<c:when test="${empty map.croptalk2}">
                    			<tr>
                    				<td>></td>
                    				<td colspan="2" width="195px"><a>최신 글이 없습니다</a><td>
                    			</tr>
                    		</c:when>
                    		<c:otherwise>
		                    	<c:forEach  items="${map.croptalk2}" end="3" var="row" varStatus="loop">
			                        <tr>
			                            <td>></td>
			                            <td><a href='<c:url value='/board/view.do?no=${row.no}&group=${row.group}&cate=${row.cate}'/>'>${row.title}</a></td>
			                            <td>${row.rdate}</td>
			                        </tr>
		                    	</c:forEach>
                    		</c:otherwise>
                    	</c:choose>
                    </table>
                </div>
                <div>
                    <a href='<c:url value='/board/list.do?group=croptalk&cate=3'/>'><img src='<c:url value='/img/main_latest2_tit.png'/>' alt="귀농학교"/></a>
                    <img src='<c:url value='/img/main_latest2_img.jpg'/>' alt="이미지"/>
                    <table border="0">
                        <c:choose>
                    		<c:when test="${empty map.croptalk3}">
                    			<tr>
                    				<td>></td>
                    				<td colspan="2" width="195px"><a>최신 글이 없습니다</a><td>
                    			</tr>
                    		</c:when>
                    		<c:otherwise>
		                    	<c:forEach  items="${map.croptalk3}" end="4" var="row" varStatus="loop">
			                        <tr>
			                            <td>></td>
			                            <td><a href='<c:url value='/board/view.do?no=${row.no}&group=${row.group}&cate=${row.cate}'/>'>${row.title}</a></td>
			                            <td>${row.rdate}</td>
			                        </tr>
		                    	</c:forEach>
                    		</c:otherwise>
                    	</c:choose>
                    </table>
                </div>
                <div>
                    <a href='<c:url value='/board/list.do?group=croptalk&cate=1'/>'><img src='<c:url value='/img/main_latest3_tit.png'/>' alt="농작물 이야기"/></a>
                    <img src='<c:url value='/img/main_latest3_img.jpg'/>' alt="이미지"/>
                    <table border="0">
                        <c:choose>
                    		<c:when test="${empty map.croptalk1}">
                    			<tr>
                    				<td>></td>
                    				<td colspan="2" width="195px"><a>최신 글이 없습니다</a><td>
                    			</tr>
                    		</c:when>
                    		<c:otherwise>
		                    	<c:forEach  items="${map.croptalk1}" end="3" var="row" varStatus="loop">
			                        <tr>
			                            <td>></td>
			                            <td><a href='<c:url value='/board/view.do?no=${row.no}&group=${row.group}&cate=${row.cate}'/>'>${row.title}</a></td>
			                            <td>${row.rdate}</td>
			                        </tr>
		                    	</c:forEach>
                    		</c:otherwise>
                    	</c:choose>
                    </table>
                </div>
                
            </div>

            <div class="info">
                <div>
                    <img src='<c:url value='/img/main_sub2_cs_tit.png'/>' class="tit" alt="고객센터 안내"/>
                    <div class="tel">
                        <img src='<c:url value='/img/main_sub2_cs_img.png'/>' alt="">
                        <img src='<c:url value='/img/main_sub2_cs_txt.png'/>' alt="1666-777">
                        <p class="time">
                            평일: AM 09:00 ~ PM 06:00<br>
                            점심: PM 12:00 ~ PM 01:00<br>
                            토, 일요일, 공휴일 휴무
                        </p>
                    </div>
                    <div class="btns">
                        <a href='<c:url value='/board/list.do?group=community&cate=4'/>'><img src='<c:url value='/img/main_sub2_cs_bt1.png'/>' alt="1:1 고객문의"></a>
                        <a href='<c:url value='/board/list.do?group=community&cate=5'/>'><img src='<c:url value='/img/main_sub2_cs_bt2.png'/>' alt="자주묻는질문"></a>
                        <a href="#"><img src='<c:url value='/img/main_sub2_cs_bt3.png'/>' alt="배송조회"></a>
                    </div>
                </div>
                <div>
                    <img src='<c:url value='/img/main_sub2_account_tit.png'/>' class="tit" alt="계좌안내"/>
                    <p class="account">
                        기업은행 123-456789-01-01-012<br />
                        국민은행 01-1234-56789<br />
                        우리은행 123-456789-01-01-012<br />
                        하나은행 123-456789-01-01<br />
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
                            <ul class="txt">
	                            <c:choose>
		                    		<c:when test="${empty map.community1}">
		                                <li><a href="#">· 최신 글이 없습니다</a></li>
		                    		</c:when>
		                    		<c:otherwise>
				                    	<c:forEach  items="${map.community1}" end="2" var="row" varStatus="loop">
		                               		<li><a href="#">· ${row.title}</a></li>
				                    	</c:forEach>
		                    		</c:otherwise>
	                    		</c:choose>
                            </ul>
                        </div>
                        <div id="tabs-2">
                            <ul class="txt">
                                <c:choose>
		                    		<c:when test="${empty map.community3}">
		                                <li><a href="#">· 최신 글이 없습니다</a></li>
		                    		</c:when>
		                    		<c:otherwise>
				                    	<c:forEach  items="${map.community3}" end="2" var="row" varStatus="loop">
		                               		<li><a href="#">· ${row.title}</a></li>
				                    	</c:forEach>
		                    		</c:otherwise>
	                    		</c:choose>
                            </ul>
                        </div>
                        <div id="tabs-3">
                            <ul class="txt">
                                <c:choose>
		                    		<c:when test="${empty map.community4}">
		                                <li><a href="#">· 최신 글이 없습니다</a></li>
		                    		</c:when>
		                    		<c:otherwise>
				                    	<c:forEach  items="${map.community4}" end="2" var="row" varStatus="loop">
		                               		<li><a href="#">· ${row.title}</a></li>
				                    	</c:forEach>
		                    		</c:otherwise>
	                    		</c:choose>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </main>
<jsp:include page="./_footer.jsp"/>