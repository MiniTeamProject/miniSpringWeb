<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>멍캣 - 견냥스</title>
<link rel="stylesheet" href="./css/index.css">
</head>
<body>
<header>
    <nav>
        <div class="logo"><span>멍캣</span></div>
        <div class="mobile-menu">
            <div class="hamburger">&#9776;</div>
        </div>
        <ul class="nav-links">
            <li><a href="#"><img src="./image/logo2.png" alt="logo2" class="nav-icon">멍캣마켓</a></li>
            <li><a href="/miniSpringWeb/board/boardMain"><img src="./image/logo3.png" alt="logo3" class="nav-icon">멍캣광장</a></li>
            <li><a href="#"><img src="./image/logo4.png" alt="logo4" class="nav-icon">멍캣정보</a></li>
            <li class="logoutview"><a href="#"><img src="./image/logo5.png" alt="logo5" class="nav-icon">로그인</a></li>
            <li class="loginview"><a href="#"><img src="./image/logo7.png" alt="logo7" class="nav-icon">로그아웃</a></li>
            <li class="loginview"><a href="#"><img src="./image/logo6.png" alt="logo6" class="nav-icon">마이페이지</a></li>
        </ul>
        <div class="auth">
            <a href="#">로그인</a>
            <a href="#">회원가입</a>
        </div>
    </nav>
</header>

<section class="main-content">
    <div class="title">
        <h1>멍캣 집사님들의 놀이터</h1>
        <h2>멍캣 (feat. mungcat)</h2>
    </div>
    <div class="search">
        <input type="text" placeholder="검색할 정보를 입력하세요">
        <button type="button">검색</button>
    </div>
</section>
<footer>
    <p>Copyright ⓒ 2024 멍캣홈</p>
</footer>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="./js/header.js"></script>
<script src="./js/index.js"></script>
</body>
</html>
