<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>멍캣: 광장검색</title>
<link rel="stylesheet" href="../css/searchResult.css">
</head>
<body>
<header>
    <nav>
        <div class="logo"><span>멍캣</span></div>
        <div class="mobile-menu">
            <div class="hamburger">&#9776;</div>
        </div>
        <ul class="nav-links">
            <li><a href="/miniSpringWeb/store/storeMain"><img src="../image/logo2.png" alt="logo2" class="nav-icon">멍캣마켓</a></li>
            <li><a href="/miniSpringWeb/board/boardMain"><img src="../image/logo3.png" alt="logo3" class="nav-icon">멍캣광장</a></li>
            <c:if test="${userDTO.id == 'admin'}">
                <li><a href="#"><img src="../image/logo5.png" alt="logo5" class="nav-icon">관리자</a></li>
            </c:if>
            <c:if test="${not empty userDTO.id}">
                <li class="logoutview"><a href="/miniSpringWeb/user/logout"><img src="../image/logo5.png" alt="logo5" class="nav-icon">로그아웃</a></li>
                <li class="logoutview"><a href="/miniSpringWeb/user/userInfo"><img src="../image/logo6.png" alt="logo6" class="nav-icon">마이페이지</a></li>
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
<main>
    <section id="event-alert">
        <h2>검색결과</h2>
        <p>멍캣광장의 검색결과를 확인해보세요!</p>
    </section>
    
    <section id="event-alert">
        <h2>글 목록</h2>
    </section>
    
    <section id="postList">
       <c:choose>
           <c:when test="${fail != 'fail'}">
               <c:forEach var="board" items="${searchResults}" varStatus="status">
	            <article class="post" onclick="hitandView(this)">
	                <input type="hidden" id="seq" name="seq" value="${board.seq}"/>
	                <input type="hidden" id="authorId" name="authorId" value="${board.id}"/>
	                <h3 class="subject">${board.subject}</h3> <!-- 게시물 제목 -->
	                <p class="content">
	                	<c:choose>
                            <c:when test="${not empty imgSrcList[status.index]}">
                                <img src="${imgSrcList[status.index]}" alt="게시물 이미지" style="width: 150px; height: 150px; border-radius: 75px;"/>
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
                <c:if test="${not empty storePaging.pagingHTML}">
                    <div id="paging">
                        ${storePaging.pagingHTML}
                    </div>
                </c:if>
            </c:when>
        </c:choose>
    </div>
	<form action="/miniSpringWeb/store/search" method="get">
	    <section id="functionWrap">
	        <div id="btnwrap">
	            <c:if test="${not empty userDTO.id}">
	                <input type="button" id="writeBtn" value="글쓰기" onclick="location.href='/miniSpringWeb/store/storeWriteForm'"/>
	            </c:if>        
	        </div>
		    <div class="search">
		       	<select id="selectForm" name="selectForm">
		            <option value="0" selected="selected">멍캣마켓</option>
		            <option value="1">멍캣광장</option>
		        </select>
				<input type="text" id="query" name="query" placeholder="검색할 상품을 입력하세요" required>
				<button type="submit" id="imgBtn"><img src='../image/logo1.png' alt='logo1' id="searchImg"/></button>
		    </div>
	    </section>
	</form>
</main>
<footer>
    <p>Copyright ⓒ 2024 검색</p>
</footer>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="../js/header.js"></script>
<script src="../js/storeMain.js"></script>
<script src="../js/search.js"></script>
</body>
</html>
