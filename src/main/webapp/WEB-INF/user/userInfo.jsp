<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멍캣: 회원정보</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="../css/userInfo.css">
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
			<h1>회원정보 수정</h1>
		</div>
		<form id="userUpdateForm">
			<div class="input-box">
				<div id="imgwrap">
					<c:if test="${userDTO.id != 'admin'}">
						<img id="showProfile" alt="default" src="../image/default.png" width="225px" height="225px">
					</c:if>
					<c:if test="${userDTO.id == 'admin'}">
						<img id="showProfile" alt="admin" src="../image/admin.png" width="225px" height="225px">
					</c:if>
				</div>
			</div>
			<div class="input-box">
				<label for="id">아이디</label>
				<input name="id" id="id" type="text" placeholder="아이디" value="${userDTO.id}" readonly="readonly">
			</div>
			<div class="input-box">
				<label for="pwd">비밀번호</label>
				<input name="pwd" id="pwd" type="password" placeholder="비밀번호">
				<div id="pwdDiv"></div>
			</div>
			<div class="input-box" id="toggleDiv">
				<label for="repwd">비밀번호</label>
				<input name="repwd" id="repwd" type="password" placeholder="비밀번호 재입력">
				<div id="pwdDiv"></div>
			</div>
			<div class="input-box">
				<label for="nickname">닉네임</label>
				<input name="nickname" id="nickname" type="text" placeholder="닉네임" value="${userDTO.nickname}">
				<div id="nicknameDiv"></div>
			</div>
			<div class="input-box">
				<label for="name">이름</label>
				<input name="name" id="name" type="text" placeholder="이름" value="${userDTO.name}" readonly="readonly">
				<div id="nameDiv"></div>
			</div>
			<div class="input-box">
			    <label>성별</label>
			    <div class="gender-buttons">                
			        <c:if test="${userDTO.gender == 'M'}">
			        	<input id="gender" class="genderBtn" value="남자" readonly="readonly">
			        	<input class="genderBtn" value="여자">
			        </c:if>
			        <c:if test="${userDTO.gender == 'F'}">
			        	<input class="genderBtn" value="남자">
			        	<input id="gender" class="genderBtn" value="여자" readonly="readonly">
			        </c:if>
			    </div>
			    <div id="genderDiv" class="checkDiv"></div>
			</div>
			<div class="input-box">
				<label for="email">이메일</label>
				<input name="email" id="email" type="email" placeholder="example@example.com" value="${userDTO.email}" readonly="readonly">
				<div id="emaileDiv"></div>
			</div>
			<div class="input-box">
				<label for="tel">핸드폰</label>
				<input name="tel" id="tel" type="tel" placeholder="핸드폰번호(01012345678)" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" value="${userDTO.tel}">
			</div>
			<div class="input-box">
				<label for="zipcode">우편번호</label>
				<input type="text" id="zipcode" name="zipcode" placeholder="우편번호입력" size="10" value="${userDTO.zipcode}">
				<button type="button" class="btn" onclick="checkPost()">우편번호 검색</button>
			</div>
			<div class="input-box">
				<label for="addr1">주소</label>
				<input type="text" id="addr1" name="addr1" placeholder="주소" size="60" value="${userDTO.addr1}" readonly>
			</div>
			<div class="input-box">
				<label for="addr2">상세주소</label>
				<input type="text" id="addr2" name="addr2" placeholder="상세주소" size="60" value="${userDTO.addr2}">
			</div>
			<div class="button-group">
				<div class="btnwrap" id="toggleBtn">
					<input id="updateButton" class="btn" type="button" value="회원정보 수정">
				</div>
				<div class="btnwrap">
					<input id="userDeleteBtn" class="btn" type="button" value="회원탈퇴">
					<input type="hidden" id="sessionPwd" name="sessionPwd" value="${userDTO.pwd}"/>
				</div>
			</div>
		</form>
	</div>
</section>

<footer>
    <p>Copyright ⓒ 2024 멍캣회원정보</p>
</footer>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../js/userRegistForm2.js"></script>
<script src="../js/header.js"></script>
<script src="../js/userInfo.js"></script>
</body>
</html>