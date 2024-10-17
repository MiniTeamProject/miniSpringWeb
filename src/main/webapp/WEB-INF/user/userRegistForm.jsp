<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멍캣: 회원가입</title>
<link rel="stylesheet" href="../css/index.css">
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
       <div class="title">
       	<h1>회원가입</h1>
       </div>
      	<div>
      		<form name="userRegistForm" id="userRegistForm">
       		<div>
       			<input type="file" name="profileFileName">
       		</div>
                <!--아이디-->
       		<div>
       			<input name="id" id="id" type="text" placeholder="아이디">
                <div id="idDiv" style="color: red"></div>
            </div>
            <div>
                <input name="pwd" id="pwd" type="password" placeholder="비밀번호">
                <div id="pwdDiv" style="color: red"></div>
            </div>
            <div>
       			<input name="rePwd" id="rePwd" type="password" placeholder="비밀번호 확인">
                <div id="rePwdDiv" style="color: red"></div>
       		</div>
       		<div>
       			<input name="name" id="name" type="text" placeholder="이름">
                <div id="nameDiv" style="color: red"></div>
            </div>
            <div>
       			<input name="nickname" id="nickname" type="text" placeholder="닉네임">
                <div id="nicknameDiv" style="color: red"></div>
       		</div>
       		<div>
                <label><input name="gender" type="radio" value="1">남자</label>
                <label><input name="gender" type="radio" value="2">여자</label>
            </div>

            <div class="form-group">
                <input class="form-control" name="email" id="email" type="email" placeholder="example@example.com" autofocus>
                <div id="emailDiv" style="color: red"></div>
                <input type="button" value="인증하기" class="btn btn-primary" id="emailBtn">
                <input type="text" id="checkAuthCode" class="form-control" placeholder="인증 코드 6자리를 입력해주세요." maxlength="6" disabled name="authCode" autofocus >
                <div id="checkAuthCodeDiv" style="color: red"></div>
            </div>


            <div>
                <input name="tel" id="tel" type="tel" placeholder="핸드폰번호(01012345678)" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}">
            </div>
       		<div> 
       			<!-- 주소 -->
     			<input  type="text" id="zipcode" name="zipcode" placeholder="우편번호입력" size="10">
		<button name="" type="button" onclick="checkPost()">우편번호 검색</button>
		<input type="text" id="addr1"  name="addr1" placeholder="주소" size="60" readonly="readonly"><br>
		<input type="text" id="addr2"  name="addr2" placeholder="상세주소" size="60">
     		</div>
    		</form>
  		<input id="userRegistBtn" type="button" value="가입하기">
    	</div>
 </section>
 <footer>
    <p>Copyright ⓒ 2024 멍캣홈</p>
</footer> 
 <script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 <script src="../js/header.js"></script>
 <script src="../js/userRegistForm.js"></script>
 <script type="text/javascript">
   function checkPost() {
       new daum.Postcode({
           oncomplete: function(data) {
               var addr = ''; 
               var extraAddr = ''; 
               
               if (data.userSelectedType === 'R') { 
                   addr = data.roadAddress;
               } else { 
                   addr = data.jibunAddress;
               }
               
               document.getElementById("zipcode").value = data.zonecode;
               document.getElementById("addr1").value = addr;
               document.getElementById("addr2").focus();
           }
       }).open();
   }

   </script>
</body>
</html>