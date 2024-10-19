<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/userInfo.css">
</head>
<body>

	<header>
		<nav>
			<div class="logo">
				<span>멍캣</span>
			</div>
			<div class="mobile-menu">
				<div class="hamburger">&#9776;</div>
			</div>
			<ul class="nav-links">
				<li><a href="#"><img src="./image/logo2.png" alt="logo2"
						class="nav-icon">멍캣마켓</a></li>
				<li><a href="/miniSpringWeb/board/boardMain"><img
						src="./image/logo3.png" alt="logo3" class="nav-icon">멍캣광장</a></li>
				<li><a href="#"><img src="./image/logo4.png" alt="logo4"
						class="nav-icon">멍캣정보</a></li>
				<c:if test="${not empty userDTO.id}">
					<li class="logoutview"><a href="#"><img
							src="./image/logo5.png" alt="logo5" class="nav-icon">로그아웃</a></li>
					<li class="logoutview"><a href="#"><img
							src="./image/logo6.png" alt="logo6" class="nav-icon">마이페이지</a></li>
				</c:if>
				<c:if test="${empty userDTO.id}">
					<li class="loginview"><a
						href="/miniSpringWeb/user/userLoginForm"><img
							src="./image/logo7.png" alt="logo7" class="nav-icon">로그인</a></li>
					<li class="loginview"><a
						href="/miniSpringWeb/user/userRegistForm"><img
							src="./image/logo6.png" alt="logo6" class="nav-icon">회원가입</a></li>
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
					<img id="showProfile" alt="" src="../image/profile.jpg" width="225px" height="225px">
					<input type="file" id="profile" name="profile" style="visibility: hidden;">
				</div>
				<div class="input-box">
					<label for="id">아이디</label>
					<input name="id" id="id" type="text" placeholder="아이디" value="${userDTO.id}" readonly>
				</div>
				<div class="input-box">
					<label for="pwd">비밀번호</label>
					<input name="pwd" id="pwd" type="password" placeholder="비밀번호">
					<div id="pwdDiv"></div>
				</div>
				<div class="input-box">
					<label for="nickname">닉네임</label>
					<input name="nickname" id="nickname" type="text" placeholder="닉네임" value="${userDTO.nickname}">
					<div id="nicknameDiv"></div>
				</div>
				<div class="input-box">
					<label for="name">이름</label>
					<input name="name" id="name" type="text" placeholder="이름" value="${userDTO.name}">
					<div id="nameDiv"></div>
				</div>
				<div class="input-box">
					<label for="gender">성별</label>
					<div>
						<label><input name="gender" type="radio" value="1" <c:if test="${userDTO.gender == '1'}">checked</c:if>>남자</label>
						<label><input name="gender" type="radio" value="2" <c:if test="${userDTO.gender == '2'}">checked</c:if>>여자</label>
					</div>
				</div>
				<div class="input-box">
					<label for="email">이메일</label>
					<input name="email" id="email" type="email" placeholder="example@example.com" value="${userDTO.email}">
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
					<input id="userUpdateBtn" class="btn" type="button" value="수정하기">
					<input id="userDeleteBtn" class="btn" type="button" value="회원탈퇴">
				</div>
			</form>
		</div>
	</section>
	
	<footer>
    <p>Copyright ⓒ 2024 멍캣홈</p>
</footer>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="../js/header.js"></script>
<script src="../js/userInfo.js"></script>

<script type="text/javascript">
$('#showProfile').click(function() {
	$('#profile').trigger('click'); // 강제 이벤트 발생
});
$('#profile').change(function() {
	$('#showProfile').empty();
	readURL(this.files[0]);
});

function readURL(file) {
	var reader = new FileReader();
	var show;
	reader.onload = function(e) {
		$('#showProfile').attr('src', e.target.result);
	}
	reader.readAsDataURL(file);
}

</script>

</body>
</html>