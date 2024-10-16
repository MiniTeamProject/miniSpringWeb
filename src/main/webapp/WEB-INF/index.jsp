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
            <div class="logo">멍캣</div>
            <div class="mobile-menu">
                <div class="hamburger">&#9776;</div>
            </div>
            <ul class="nav-links">
                <li><a href="#">멍캣마켓</a></li>
                <li><a href="#">멍캣광장</a></li>
                <li><a href="#">멍캣정보</a></li>
            </ul>
            <div class="auth">
                <a href="/miniSpringWeb/user/userLoginForm">로그인 <span>${sessionScope.userDTO.id }</span></a>
                <a href="/miniSpringWeb/user/userRegistForm">회원가입</a>
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
            <button type="submit"><img src="search-icon.png" alt="Search"></button>
        </div>
    </section>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="./js/index.js" defer></script>
</body>
</html>
