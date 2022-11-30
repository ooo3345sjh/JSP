<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <div id="sub">
            <div><img src='<c:url value='/img/sub_top_tit2.png'/>' alt="MARKET"></div>
            <section class="cate2">
                <aside>
                    <img src='<c:url value='/img/sub_aside_cate2_tit.png'/>' alt="장보기"/>

                    <ul class="lnb">
                        <li class='${cate eq 1 ? "on":"off"}'><a href='<c:url value='/board/list.do?group=${group}&cate=1'/>'>장보기</a></li>
                    </ul>
                </aside>
                <article>
                    <nav>
                        <img src='<c:url value='/img/sub_nav_tit_cate2_tit1.png'/>' alt="장보기"/>
                        <p>
                            HOME > 장보기 > <em>장보기</em>
                        </p>
                    </nav>
