$(function(){
	// 메시지 초기화 
    $('#emailDiv').empty();
	$('#checkAuthCodeDiv').empty();

	let isEmailVerified = false; // 이메일 인증 완료 여부를 저장하는 변수
    
    // 등록된 이메일인지 확인하는 함수 
    function getEmail() {
	    var email = $('#email').val(); // 이메일 값 가져오기
	    $('#emailDiv').empty(); // 이메일 입력 필드 초기화
	
	    // 이메일 값이 존재하는지 확인
	    $.ajax({
            type: 'post',
            url: '/miniSpringWeb/user/isEmail', // 요청 URL
            data: { email: email }, // 전송할 데이터
            dataType: 'text', // 기대하는 응답 데이터 타입
            success: function(response) {
                $('#emailDiv').text('이메일: ' + response).css('color', 'green'); // 성공 시 이메일 표시
            },
            error: function(error) {
                $('#emailDiv').text('이메일 확인 중 오류가 발생했습니다: ' + error.responseText).css('color', 'red'); // 오류 메시지 표시
            }
        });
	   
	
	    return email; // 이메일 값을 반환
	}


	// 이메일 인증 요청
    $('#emailBtn').click(function () {
        var email = $('#email').val();
        $('#emailDiv').empty();

        if (!email) {
            $('#emailDiv').html("이메일을 입력하세요.");
        } else {
            var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailPattern.test(email)) {
                $('#emailDiv').html("올바른 이메일 형식이 아닙니다.");
            } else {
            	if(getEmail()!=null){
	                $.ajax({
	                    url: '/miniSpringWeb/user/findIdEmailAuth',
	                    type: 'POST',
	                    data: { email: email },
	                    success: function (checkNum) {
	                        $('#checkAuthCode').prop('disabled', false); 
	                        $('#emailDiv').html("인증 코드가 이메일로 발송되었습니다.");
	                    },
	                    error: function (xhr, status, error) {
	                        $('#emailDiv').html("이메일 인증 중 오류가 발생했습니다.");
	                    }
	                });            	
            	}
            	
            }
        }
    });
    
    // 인증번호 확인 함수
    function checkAuthCode() {
        var inputCode = $('#checkAuthCode').val(); 
        var email = $('#email').val(); 

        if (!inputCode) {
            $('#checkAuthCodeDiv').html("인증번호를 입력하세요.");
        } else {
            $.ajax({
                url: '/miniSpringWeb/user/verifyAuthCode',
                type: 'POST',
                data: {
                    email: email,
                    authCode: inputCode
                },
                success: function (response) {
                    if (response.valid) {
                        $('#checkAuthCodeDiv').text("인증번호가 일치합니다.").css('color', 'green');
						$("#emailDiv").empty();
                        isEmailVerified = true;
                    } else {
						$("#emailDiv").empty();
                        $('#checkAuthCodeDiv').text("인증번호가 일치하지 않습니다.").css('color', 'red');
                        isEmailVerified = false;
                    }
                },
                error: function (xhr, status, error) {
                    $('#checkAuthCodeDiv').text('인증번호 검증 중 오류가 발생했습니다.').css('color', 'red');
                }
            });
        }
    }
    
    
    $('#checkAuthCode').on('focusout', checkAuthCode);
    $('#checkAuthCode').on('click', function () {
        $('#checkAuthCodeDiv').text(''); 
    });
    
    // 인증번호 인증 성공하면 
    $('#findIdtBtn').click(function(){
	    var email = $('#email').val();
	    
	    if(isEmailVerified){
	    	 $.ajax({
	            type: 'post',
	            url: '/miniSpringWeb/user/getId', // 요청 URL
	            data: { email: email }, // 전송할 데이터
	            dataType: 'text', // 기대하는 응답 데이터 타입
	            success: function(response) {
	            	//alert(response);
	               	$('#findId').val(response); // 성공 시 이메일 표시
	            },
	            error: function(error) {
	                  $('#findId').val(error);
	            }
	        });
	    }
    });
  
    


});