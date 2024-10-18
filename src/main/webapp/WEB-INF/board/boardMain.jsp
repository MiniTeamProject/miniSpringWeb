<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>멍캣: 멍캣광장</title>
<link rel="stylesheet" href="../css/boardMain.css">
</head>
<body>
<header>
    <nav>
        <div class="logo"><span>멍캣</span></div>
        <div class="mobile-menu">
            <div class="hamburger">&#9776;</div>
        </div>
        <ul class="nav-links">
            <li><a href="#"><img src="../image/logo2.png" alt="logo2" class="nav-icon">멍캣마켓</a></li>
            <li><a href="/miniSpringWeb/board/boardMain"><img src="../image/logo3.png" alt="logo3" class="nav-icon">멍캣광장</a></li>
            <li><a href="#"><img src="../image/logo4.png" alt="logo4" class="nav-icon">멍캣정보</a></li>
            <c:if test="${userDTO.admin == 1}">
                <li><a href="#"><img src="../image/logo5.png" alt="logo5" class="nav-icon">관리자</a></li>
            </c:if>
            <c:if test="${not empty userDTO.id}">
                <li class="logoutview"><a href="#"><img src="../image/logo5.png" alt="logo5" class="nav-icon">로그아웃</a></li>
                <li class="logoutview"><a href="#"><img src="../image/logo6.png" alt="logo6" class="nav-icon">마이페이지</a></li>
            </c:if>
            <c:if test="${empty userDTO.id}">
                <li class="loginview"><a href="/miniSpringWeb/user/userLoginForm"><img src="../image/logo7.png" alt="logo7" class="nav-icon">로그인</a></li>
                <li class="loginview"><a href="/miniSpringWeb/user/userRegistForm"><img src="../image/logo6.png" alt="logo6" class="nav-icon">회원가입</a></li>
            </c:if>
        </ul>
        <div class="auth">
            <c:if test="${not empty userDTO.id}">
                <a href="/miniSpringWeb/user/userInfo">${userDTO.nickname} 님</a>
                <a href="/miniSpringWeb/user/logout">로그아웃</a>
            </c:if>
            <c:if test="${empty userDTO.id}">
                <a href="/miniSpringWeb/user/userLoginForm">로그인</a>
                <a href="/miniSpringWeb/user/userRegistForm">회원가입</a>
            </c:if>
        </div>
    </nav>
</header>
<main><form id="mainForm">
    <section id="event-alert">
        <h2>이벤트 알림📢</h2>
        <p>실시간으로 업데이트되는 이벤트 정보를 확인하세요!</p>
    </section>
    <section id="event-alert">
        <h2>지금 핫! 한! 인기글🔔</h2>
    </section>
    <section id="popular-posts">
        <c:choose>
            <c:when test="${fail != 'fail'}">
                <c:forEach var="hot" items="${boardHotList}" varStatus="status">
                    <article class="post" onclick="hitandView(this)">
                        <input type="hidden" id="seq" name="seq" value="${hot.seq}"/>
                        <input type="hidden" id="authorId" name="authorId" value="${hot.id}"/>
                        <h3 class="subject">${hot.subject}</h3> <!-- 게시물 제목 -->
                        <p class="content">
	                        <c:choose>
	                            <c:when test="${not empty hotImgSrcList[status.index]}">
	                                <img src="${hotImgSrcList[status.index]}" alt="게시물 이미지" style="width: 150px; height: 150px; border-radius: 10px;"/>
	                            </c:when>
	                            <c:otherwise>
	                                <span class="no-image">이미지가 없습니다</span>
	                            </c:otherwise>
	                        </c:choose>
                        </p> <!-- 게시물 내용 -->
                        <span class="hit">조회수: ${hot.hit}</span> <!-- 조회수 -->
                    </article>
                </c:forEach>    
            </c:when>
            <c:otherwise>
                <article class="post">
                     <h3>등록된 게시글이 없습니다.</h3> <!-- 게시물 제목 -->
                 </article>
            </c:otherwise>
        </c:choose>
    </section>
    <section id="event-alert">
        <h2>게시물 목록</h2>
    </section>
    <section id="postList">
       <c:choose>
           <c:when test="${fail != 'fail'}">
               <c:forEach var="board" items="${boardList}" varStatus="status">
	            <article class="post" onclick="hitandView(this)">
	                <input type="hidden" id="seq" name="seq" value="${board.seq}"/>
	                <input type="hidden" id="authorId" name="authorId" value="${board.id}"/>
	                <h3 class="subject">${board.subject}</h3> <!-- 게시물 제목 -->
	                <p class="content">
	                	<c:choose>
                            <c:when test="${not empty imgSrcList[status.index]}">
                                <img src="${imgSrcList[status.index]}" alt="게시물 이미지" style="width: 150px; height: 150px; border-radius: 10px;"/>
                            </c:when>
                            <c:otherwise>
                                <span class="no-image">이미지가 없습니다</span>
                            </c:otherwise>
                        </c:choose>
					</p> <!-- 게시물 내용 -->
	                <span class="hit">조회수: ${board.hit}</span> <!-- 조회수 -->
	            </article>
	        </c:forEach>    
           </c:when>
           <c:otherwise>
                <article class="post">
                     <h3>등록된 게시글이 없습니다.</h3> <!-- 게시물 제목 -->
                 </article>
            </c:otherwise>
        </c:choose>
    </section>
    
    <!-- 페이징 처리 추가 -->
    <div id="pagingWrap">
        <c:choose>
            <c:when test="${fail != 'fail'}">
                <c:if test="${not empty boardPaging.pagingHTML}">
                    <div id="paging">
                        ${boardPaging.pagingHTML}
                    </div>
                </c:if>
            </c:when>
        </c:choose>
    </div>
    
    <section id="functionWrap">
        <div id="btnwrap">
        	<c:if test="${not empty userDTO.id}">
	        	<input type="button" id="writeBtn" value="글쓰기" onclick="location.href='/miniSpringWeb/board/boardWriteForm'"/>
	        </c:if>        
        </div>
        <div class="search">
            <input type="text" placeholder="검색할 정보를 입력하세요">
            <button type="button"><img src='../image/logo1.png' alt='logo1' id="searchImg"/></button>
        </div>
    </section>
    <input type="hidden" id="pg" name="pg" value="${pg}"/>
    <input type="hidden" id="visitorId" name="visitorId" value="${userDTO.id}"/>
</form></main>
<footer>
    <p>Copyright ⓒ 2024 멍캣광장</p>
</footer>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="../js/header.js"></script>
<script src="../js/boardMain.js"></script>
</body>
</html>
