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
                <a href="#">회원가입</a>
            </div>
        </nav>
    </header>

    <section class="main-content">
        <div class="title">
        	<h1>회원가입</h1>
        </div>
       	<div>
       		<form id="userRegistForm" action="#">
	       		<div>
	       			<input type="file">
	       		</div>
	       		<div>
	       			<input name="" type="text" placeholder="아이디">
	       			<input name="" type="password" placeholder="비밀번호">
	       			<input name="" type="password" placeholder="비밀번호 확인">
	       		</div>
	       		<div>
	       			<input name="" type="text" placeholder="이름">
	       			<input name="" type="text" placeholder="닉네임">
	       		</div>
	       		<div>
       				<label><input name="" type="checkbox" value="M">남자</label>
       				<label><input name="" type="checkbox" value="W">여자</label>
       			</div>
       			<div>
       				<input name="" type="email" placeholder="이메일" placeholder="example@example.com">
       				<input name="" type="tel" laceholder="01012345678" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}">
       			</div>
	       		<div> 
	       			<!-- 주소 -->
	       			<input name="" type="text" id="zipcode" name="zipcode" placeholder="우편번호입력" size="10">
					<button name="" type="button" onclick="checkPost()">우편번호 검색</button>
					<input name="" type="text" id="addr1"  name="addr1" placeholder="주소" size="60" readonly="readonly"><br>
					<input name="" type="text" id="addr2"  name="addr2" placeholder="상세주소" size="60">
	       		</div>
       		</form>
     		<input id="userRegistBtn" type="button" value="가입하기">
       	</div>
    </section>
    
    
    <script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="../js/index.js" defer></script>
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
    // -------------- 
    $(function() {
		$('#userRegistBtn').click(function() {
		});
	});
    </script>
</body>
</html>