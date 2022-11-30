<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <div id="sub">
            <div><img src='<c:url value='/img/sub_top_tit4.png'/>' alt="CROP TALK"></div>
            <section class="cate4">
                <aside>
                    <img src='<c:url value='/img/sub_aside_cate4_tit.png'/>' alt="이벤트"/>

                    <ul class="lnb">
                        <li class='${cate eq 1 ? "on":"off"}'><a href='<c:url value='/board/list.do?cate=1'/>'>이벤트</a></li>
                    </ul>
                </aside>
                <article>
                    <nav>
                        <img src='<c:url value='/img/sub_nav_tit_cate4_tit1.png'/>' alt="이벤트"/>
                        <p>
                            HOME > 이벤트 > <em>이벤트</em>
                        </p>
                    </nav>
