<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
            <li class="logoutview"><a href="#"><img src="../image/logo5.png" alt="logo5" class="nav-icon">로그인</a></li>
            <li class="loginview"><a href="#"><img src="../image/logo7.png" alt="logo7" class="nav-icon">로그아웃</a></li>
            <li class="loginview"><a href="#"><img src="../image/logo6.png" alt="logo6" class="nav-icon">마이페이지</a></li>
        </ul>
        <div class="auth">
            <a href="/miniSpringWeb/user/userLoginForm">로그인 <span>${sessionScope.userDTO.id }</span></a>
            <a href="/miniSpringWeb/user/userRegistForm">회원가입</a>
        </div>
    </nav>
</header>
    
<section class="main-content">
    <div class="title">
    	<h1>로그인</h1>
    </div>
    <div>
     <form id="userLoginForm" >
     	<input id="id" name="id" type="text" placeholder="아이디">
     	<div id="idDiv"></div>
     	<input id="pwd" name="pwd" type="text" placeholder="비밀번호">
     	<div id="pwdDiv"></div>
     	<input id="userLoginFormBtn" type="button" value="로그인">
     </form>
     <p><a href="회원가입">회원가입</a></p>
    </div>
    <div>
    	<div><a>카카오</a></div>
    	<div><a>네이버</a></div>
    </div>
</section>
<footer>
    <p>Copyright ⓒ 2024 멍캣홈</p>
</footer>    
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="../js/header.js"></script>
<script type="text/javascript">
	$(function() {
		$('#idDiv').empty();
		$('#pwdDIv').empty();
		
		$('#id').focusout(function(){
			if($('#id').val()==''){
				$('#idDiv').html("diq");
			}
		});
		$('#pwd').focusout(function(){
			if($('#pwd').val()==''){
				$('#pwdDiv').html("diq");
			}
		});
		
		$('#userLoginFormBtn').click(function() {
			$('#pwdDIv').empty();
			$('#idDiv').empty();
			
			$.ajax({
				type: 'post',
				url: '/miniSpringWeb/user/userLogin',
				data: $('#userLoginForm').serialize(),  
				dataType: 'text',
				success: function(data){
					alert(data);
					if(data=='success'){
						location.href='/miniSpringWeb/';					
					}else {
						return;
					}
				},
				error: function(e){console.log(e);}
			}); // AJAX 
		});
		
		
		
	});
</script>
</body>
</html>