<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멍캣: 글쓰기</title>
    <link rel="stylesheet" href="../css/boardWriteForm.css">

    <!-- Froala Editor CSS -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/4.3.0/css/froala_editor.pkgd.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/4.3.0/css/froala_editor.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/4.3.0/css/froala_style.min.css">

    <!-- jQuery (Froala Editor의 의존성) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    
    <!-- Froala Editor JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/4.3.0/js/froala_editor.pkgd.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/4.3.0/js/languages/ko.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/4.3.0/js/plugins/colors.min.js"></script>
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
            <c:if test="${not empty userDTO.id}">
                <li class="logoutview"><a href="#"><img src="../image/logo5.png" alt="logo5" class="nav-icon">로그아웃</a></li>
                <li class="logoutview"><a href="#"><img src="../image/logo6.png" alt="logo6" class="nav-icon">마이페이지</a></li>
            </c:if>
            <c:if test="${empty userDTO.id}">
                <li class="loginview"><a href="/miniSpringWeb/user/userLoginForm"><img src="../image/logo7.png" alt="logo7" class="nav-icon">로그인</a></li>
            </c:if>
        </ul>
        <div class="auth">
            <c:if test="${not empty userDTO.id}">
                <a href="/miniSpringWeb/user/userInfo">${userDTO.nickname} 님</a>
                <a href="/miniSpringWeb/user/logout">로그아웃</a>
            </c:if>
            <c:if test="${empty userDTO.id}">
                <a href="/miniSpringWeb/user/userLoginForm">로그인</a>
            </c:if>
        </div>
    </nav>
</header>

<main>
    <section class="board-write-section">
        <h2>게시물 작성</h2>
        <form id="boardWriteForm">
            <div class="form-group">
                <label for="subject">제목</label>
                <input type="text" id="subject" name="subject" maxlength="100" placeholder="제목을 입력하세요" required>
            </div>

            <div class="form-group">
                <label for="category">카테고리</label>
                <select id="category" name="category">
                    <option value="일반">일반</option>
                    <option value="질문">질문</option>
                    <option value="후기">후기</option>
                </select>
            </div>

            <div class="form-group">
                <!-- Froala Editor를 위한 div -->
                <div id="editor"></div>
            </div>

            <div class="form-buttons">
                <button type="button" class="btn-submit" id="writeBtn">등록</button>
                <button type="button" class="btn-cancel" onclick="history.back();">취소</button>
            </div>
        </form>
    </section>
</main>
<footer>
    <p>Copyright ⓒ 2024 자유게시판</p>
</footer>
<script type="text/javascript" src="../js/boardWriteForm.js"></script>
<script src="../js/header.js"></script>
</body>
</html>
