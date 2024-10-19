<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멍캣: 업데이트</title>
    <link rel="stylesheet" href="../css/boardUpdateForm.css">

    <!-- Froala Editor CSS -->
	<link rel="stylesheet" href="../froala/css/froala_editor.pkgd.min.css">
	<link rel="stylesheet" href="../froala/css/froala_editor.min.css">
	<link rel="stylesheet" href="../froala/css/froala_style.min.css">

    <!-- jQuery (Froala Editor의 의존성) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    
    <!-- Froala Editor JS -->
	<script src="../froala/js/froala_editor.pkgd.min.js"></script>
	<script src="../froala/js/languages/ko.js"></script>
	<script src="../froala/js/plugins/colors.min.js"></script>
</head>
<body>
<c:if test="${empty userDTO.id}">
    <script type="text/javascript">
        alert("로그인이 필요합니다.");
        window.location.href = '/miniSpringWeb/board/boardMain'; // 원하는 리디렉션 URL로 변경
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
    <section class="board-update-section">
        <h2>게시물 수정</h2>
        <form id="boardUpdateForm">
            <input type="hidden" id="seq" name="seq" value="${list[0].seq}"/>
            <div class="form-group">
                <label for="subject">제목</label>
                <input type="text" id="subject" name="subject" maxlength="100" placeholder="제목을 입력하세요" required value="${list[0].subject}">
            </div>
            
            <div class="form-group">
				<label for="category">카테고리</label>
				<select id="category" name="category">
				    <option value="0" <c:if test="${list[0].category == 0}">selected</c:if>>일반</option>
				    <option value="1" <c:if test="${list[0].category == 1}">selected</c:if>>질문</option>
				    <option value="2" <c:if test="${list[0].category == 2}">selected</c:if>>후기</option>
				</select>
            </div>

            <div class="form-group" id="editorwrap">
                <div id="editor">${list[0].content}</div>
            </div>

            <div class="form-buttons">
                <button type="button" class="btn-submit" id="updateBtn">수정</button>
                <div id="checkDiv"></div>
                <button type="button" class="btn-cancel" onclick="location.href='/miniSpringWeb/board/boardView?pg=${pg}&seq=${list[0].seq}'">뒤로</button>
            </div>
            <div class="form-delete">
                <a id="deleteBtn">&lt;삭제&gt;</a>
            </div>
            <div class="inputData">
                <input type="hidden" id="id" name="id" value="${userDTO.id}"/>
                <input type="hidden" id="pwd" name="pwd" value="${userDTO.pwd}"/>
                <input type="hidden" id="pg" name="pg" value="${pg}"/>
            </div>
        </form>
    </section>
</main>
<footer>
    <p>Copyright ⓒ 2024 멍캣광장 글쓰기</p>
</footer>
<script type="text/javascript" src="../js/boardUpdateForm.js"></script>
<script src="../js/header.js"></script>
</body>
</html>
