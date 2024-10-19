<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멍캣: 멍캣마켓</title>
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
<c:if test="${empty userDTO.id}">
    <script type="text/javascript">
        alert("로그인이 필요합니다.");
        window.location.href = '/miniSpringWeb/store/storeMain'; // 원하는 리디렉션 URL로 변경
    </script>
</c:if>
<c:if test="${userDTO.admin == 1}">
    <script type="text/javascript">
        alert("관리자 권한이 필요합니다.");
        window.location.href = '/miniSpringWeb/store/storeMain'; // 원하는 리디렉션 URL로 변경
    </script>
</c:if>
<header>
    <nav>
        <div class="logo"><span>멍캣</span></div>
        <div class="mobile-menu">
            <div class="hamburger">&#9776;</div>
        </div>
        <ul class="nav-links">
            <li><a href="/miniSpringWeb/store/storeMain"><img src="../image/logo2.png" alt="logo2" class="nav-icon">멍캣마켓</a></li>
            <li><a href="/miniSpringWeb/board/boardMain"><img src="../image/logo3.png" alt="logo3" class="nav-icon">멍캣광장</a></li>
            <c:if test="${userDTO.id == '1'}">
                <li><a href="#"><img src="../image/logo5.png" alt="logo5" class="nav-icon">관리자</a></li>
            </c:if>
            <c:if test="${not empty userDTO.id}">
                <li class="logoutview"><a href="/miniSpringWeb/user/logout"><img src="./image/logo5.png" alt="logo5" class="nav-icon">로그아웃</a></li>
                <li class="logoutview"><a href="/miniSpringWeb/user/userInfo"><img src="./image/logo6.png" alt="logo6" class="nav-icon">마이페이지</a></li>
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
    <section class="board-write-section">
        <h2>관리자 작성</h2>
        <form id="storeWriteForm" name="storeWriteForm">
            <div class="form-group">
                <label for="name">상품명</label>
                <input type="text" id="name" name="name" maxlength="100" placeholder="상품명을 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="price">가격</label>
                <input type="text" id="price" name="price" maxlength="100" placeholder="가격을 입력하세요" required>
            </div>

            <div class="form-group">
                <label for="category">카테고리</label>
                <select id="category" name="category">
                    <c:if test="${userDTO.admin != '0'}">
                        <option value="3">애견용품</option>
                        <option value="4">공지사항</option>
                    </c:if>
                </select>
            </div>

            <div class="form-group" id="editorwrap">
                <div id="editor"></div>
            </div>

            <div class="form-buttons">
                <button type="button" class="btn-submit" id="writeBtn">등록</button>
                <div id="checkDiv"></div>
                <button type="button" class="btn-cancel" onclick="history.back();">취소</button>
            </div>
            
			<div class="inputData">
            	<input type="hidden" id="id" name="id" value="${userDTO.id}"/>
            </div>
        </form>
    </section>
</main>
<footer>
    <p>Copyright ⓒ 2024 멍캣마켓</p>
</footer>
<script type="text/javascript" src="../js/storeWriteForm.js"></script>
<script src="../js/header.js"></script>
</body>
</html>
