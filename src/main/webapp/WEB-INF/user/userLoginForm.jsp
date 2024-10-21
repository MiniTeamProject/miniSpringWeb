<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>멍캣: 로그인</title>
<meta name ="google-signin-client_id" content="152752869386-2qrau71tu7uqd4ete897lck5o7htenfl.apps.googleusercontent.com">
<link rel="stylesheet" href="../css/userLoginForm.css">
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

<div id="wrap">
	<section class="main-content">
		<div class="form-box">
			<div class="title">
				<h1>로그인</h1>
			</div>
			<form id="userLoginForm">
				<div class="input-box">
					<p>아이디</p>
					<input id="id" name="id" type="text" placeholder="아이디" required="required">
				</div>
				<div class="input-box">
					<p>비밀번호</p>
					<input id="pwd" name="pwd" type="password" placeholder="비밀번호" required="required">
				</div>
				<div id="checkDiv"></div>
				<input id="userLoginFormBtn" class="btn" type="button" value="로그인">
			</form>
	
			<div id="snsWrap">
				<div class="snslogin">
					<button id="naver"><img src="../image/naver.png" alt="naver"/></button>
				</div>
				<div class="snslogin">
					<c:if test="${empty userDTO.id}">
						<button id="kakao" onclick="kakaoLogin()"><img src="../image/kakao.png" alt="kakao"/></button>
					</c:if>
					<c:if test="${not empty userDTO.id}">
						<button id="kakao" onclick="kakaoLogout()"><img src="../image/kakao.png" alt="kakao"/></button>
					</c:if>
				</div>
				<div class="snslogin">
					<button id="google" onclick="GgCustomLogin()"><img src="../image/google.png" alt="google"/></button>
				</div>
			</div>
			
			<div class="login-register">
				<div class="registerwrap">
					<a href="/miniSpringWeb/user/forgotId">아이디 찾기</a>&nbsp;&nbsp;|&nbsp;&nbsp;
				</div>
				<div class="registerwrap">
					<a href="/miniSpringWeb/user/forgotPwd">비밀번호 찾기</a>&nbsp;&nbsp;|&nbsp;&nbsp;
				</div>
				<div class="registerwrap">
					<a href="/miniSpringWeb/user/userRegistForm">회원가입</a>
				</div>
			</div>
		</div>
	</section>
</div>

<footer>
    <p>Copyright ⓒ 2024 멍캣로그인</p>
</footer>    
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="../js/userLogingForm.js"></script>
<script src="../js/kakao.js"></script>
<script src="../js/header.js"></script>
</body>
</html>