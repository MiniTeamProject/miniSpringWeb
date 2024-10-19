<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멍캣: 회원가입</title>
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

<section class="main-content">
<div class="form-box">
	<div class="title">
		<h1>회원가입</h1>
	</div>
	<div>
		<form name="userRegistForm" id="userRegistForm">
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
			<div class="input-box">
				<div>
					<label>이름</label>
					<input name="name" id="name" type="text" placeholder="이름" required="required">
				</div>
				<div id="nameDiv" class="checkDiv"></div>
			</div>
			<div class="input-box">
				<div>
					<label>닉네임</label>
					<input name="nickname" id="nickname" type="text" placeholder="닉네임" required="required">
					<input name="checkNickname" id="checkNickname" type="hidden" required="required"/>
				</div>
				<div id="nicknameDiv" class="checkDiv"></div>
			</div>
			<div class="input-box">
			    <label>성별</label>
			    <div class="gender-buttons">                
			        <button type="button" class="gender-btn" data-gender="1">남자</button>
			        <button type="button" class="gender-btn" data-gender="2">여자</button>
			    </div>
			    <input name="gender" type="radio" value="1" id="gender-male" hidden/>
			    <input name="gender" type="radio" value="2" id="gender-female" hidden/>
			    <div id="genderDiv" class="checkDiv"></div>
			</div>

			<div class="input-box form-group">
			<div>
				<label>이메일</label>
				<input class="form-control" name="email" id="email" type="email" placeholder="example@example.com" autofocus required="required">
				<input type="button" value="인증하기" class="btn btn-primary" id="emailBtn"> 
				<div id="emailDiv" class="checkDiv"></div>
			</div>
				<input type="text" id="checkAuthCode"
					class="form-control" placeholder="인증 코드 6자리를 입력해주세요." maxlength="6" disabled name="authCode" autofocus required="required">
				<div id="checkAuthCodeDiv" class="checkDiv"></div>
			</div>


			<div class="input-box">
				<div>
					<label>핸드폰</label>
					<input name="tel" id="tel" type="tel" placeholder="핸드폰번호(01012345678)" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}">
				</div>
			</div>
			<div class="input-box">
				<!-- 주소 -->

				<div>
					<label>주소</label>
					<input type="text" id="zipcode" name="zipcode" placeholder="우편번호입력" readonly="readonly" size="10">
					<button class="btn" type="button" onclick="checkPost()">우편번호검색</button>
					<input type="text" id="addr1" name="addr1" placeholder="주소"size="60" readonly="readonly"><br> 
					<input type="text" id="addr2" name="addr2" placeholder="상세주소" size="60">
				</div>

			</div>
		</form>
		<input id="userRegistBtn" class="btn" type="button" value="가입하기">
	</div>
</div>
</section>
<footer>
	<p>Copyright ⓒ 2024 멍캣회원가입</p>
</footer>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../js/header.js"></script>
<script src="../js/gender.js"></script>
<script src="../js/userRegistForm.js"></script>
<script src="../js/userRegistForm2.js"></script>
</body>
</html>