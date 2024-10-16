<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>멍캣광장</title>
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
            <li class="logoutview"><a href="#"><img src="../image/logo5.png" alt="logo5" class="nav-icon">로그인</a></li>
            <li class="loginview"><a href="#"><img src="../image/logo7.png" alt="logo7" class="nav-icon">로그아웃</a></li>
            <li class="loginview"><a href="#"><img src="../image/logo6.png" alt="logo6" class="nav-icon">마이페이지</a></li>
        </ul>
        <div class="auth">
            <a href="/miniSpringWeb/user/userLoginForm">로그인 <span>${sessionScope.userDTO.id }</span></a>
            <a href="/miniSpringWeb/user/userRegistForm">회원가입</a>
        </div>
    </nav>
</header>
<main>
    <section id="event-alert">
        <h2>이벤트 알림📢</h2>
        <p>실시간으로 업데이트되는 이벤트 정보를 확인하세요!</p>
    </section>
    
    <section id="popular-posts">
        <h2>지금 핫! 한! 인기글🔔</h2>
        <c:choose>
            <c:when test="${fail != 'fail'}">
                <c:forEach var="hot" items="${boardHotList}">
                    <article class="post">
                        <input type="hidden" id="seq" name="seq" value="${hot.seq}"/>
                        <h3>${hot.subject}</h3> <!-- 게시물 제목 -->
                        <p>${hot.content}</p> <!-- 게시물 내용 -->
                        <span>조회수: ${hot.hit}</span> <!-- 조회수 -->
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
    
    <section id="postList">
        <h2>게시물 목록</h2>
        <c:choose>
            <c:when test="${fail != 'fail'}">
                <c:forEach var="board" items="${boardList}">
		            <article class="post">
		                <input type="hidden" id="seq" name="seq" value="${board.seq}"/>
		                <h3>${board.subject}</h3> <!-- 게시물 제목 -->
		                <p>${board.content}</p> <!-- 게시물 내용 -->
		                <span>조회수: ${board.hit}</span> <!-- 조회수 -->
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
	        <input type="button" id="writeBtn" value="글쓰기" onclick="location.href='/miniSpringWeb/board/boardWriteForm'"/>        
        </div>
        <div class="search">
            <input type="text" placeholder="검색할 정보를 입력하세요">
            <button type="button"><img src='../image/logo1.png' alt='logo1' id="searchImg"/></button>
    </div>
    </section>
</main>
<footer>
    <p>Copyright ⓒ 2024 자유게시판</p>
</footer>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="../js/header.js"></script>
<script src="../js/boardMain.js"></script>
</body>
</html>
