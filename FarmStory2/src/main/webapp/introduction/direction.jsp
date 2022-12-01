<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/_header.jsp"/>
        <div id="sub">
            <div><img src='<c:url value='/img/sub_top_tit1.png'/>' alt="INTRODUCTION"></div>
            <section class="cate1">
                <aside>
                    <img src='<c:url value='/img/sub_aside_cate1_tit.png'/>' alt="팜스토리 소개"/>

                    <ul class="lnb">
                        <li class='${cate eq 1 ? "on":"off"}'><a href='<c:url value='/introduction/hello.do'/>'>인사말</a></li>
                        <li class='${cate eq 2 ? "on":"off"}'><a href='<c:url value='/introduction/direction.do'/>'>찾아오시는 길</a></li>
                    </ul>

                </aside>
                <article>
                    <nav>
                        <img src='<c:url value='/img/sub_nav_tit_cate1_tit2.png'/>' alt="찾아오시는길"/>
                        <p>
                            HOME > 팜스토리소개 > <em>찾아오시는길</em>
                        </p>
                    </nav>

                    <!-- 내용 시작 -->
                    <p>
                        <strong>팜스토리</strong><br>
                        주소: 경기도 이천시 잘한다구 신난다동 123<br>
                        전화: 01-234-5678<br>
                    </p>
                    <p>
                        <strong>찾아오시는길</strong><br>
                        <!-- * 카카오맵 - 지도퍼가기 -->
                        <!-- 1. 지도 노드 -->
                        <div id="daumRoughmapContainer1668214668575" class="root_daum_roughmap root_daum_roughmap_landing"></div>
                    </p>
                    <!--
                        2. 설치 스크립트
                        * 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
                    -->
                    <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>

                    <!-- 3. 실행 스크립트 -->
                    <script charset="UTF-8">
                        new daum.roughmap.Lander({
                            "timestamp" : "1668214668575",
                            "key" : "2ci7x",
                            "mapWidth" : "760",
                            "mapHeight" : "400"
                        }).render();
                    </script>
		</article>
	</section>
</div>
<jsp:include page="/_footer.jsp"/>