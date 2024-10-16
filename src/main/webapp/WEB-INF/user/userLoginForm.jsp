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
                <a href="#">로그인</a>
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
    
    
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="../js/index.js" defer></script>

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