<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멍캣: 비밀번호 찾기</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="../css/userRegistForm.css">
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

<section class="main-content">
<div class="form-box">
	<div class="title">
		<h1>비밀번호 변경</h1>
	</div>
	<div>
		<form name="forgotPwdForm" id="userRegistForm">
			<!--아이디-->
			<div class="input-box">
				<div>
					<label>아이디</label>
					<input name="id" id="id" type="text" placeholder="아이디" required="required">
					<input name="checkId" id="checkId" type="hidden" required="required"/>
				</div>
				<div id="idDiv" class="checkDiv"></div>
			</div>
			<div class="input-box">
				<div>
					<label>비밀번호</label>
					<input name="pwd" id="pwd" type="password" placeholder="비밀번호" required="required">
				</div>
				<div id="pwdDiv" class="checkDiv"></div>
			</div>
			<div class="input-box">
				<div>
					<label>비밀번호 확인</label>
					<input name="rePwd" id="rePwd" type="password" placeholder="비밀번호 확인" required="required">
				</div>
				<div id="rePwdDiv" class="checkDiv"></div>
			</div>
			
		</form>
		<div class="input-box">
			<input id="forgotPwdBtn" class="btn" type="button" value="비밀번호 변경">
		</div>
	</div>
</div>
</section>
<footer>
	<p>Copyright ⓒ 2024 멍캣회원가입</p>
</footer>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../js/header.js"></script>
<script src="../js/forgotPwd.js"></script>
</body>
</html>