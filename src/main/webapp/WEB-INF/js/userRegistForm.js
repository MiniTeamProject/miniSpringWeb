$(function () {
    // 메시지 초기화
    $('#idDiv').empty();
    $('#pwdDiv').empty();
    $('#rePwdDiv').empty();
    $('#nameDiv').empty();
    $('#nicknameDiv').empty();
    $('#genderDiv').empty();
    $('#emailDiv').empty();
    $('#checkAuthCodeDiv').empty();
    
    let isEmailVerified = false; // 이메일 인증 완료 여부를 저장하는 변수
    let isValid = false; // 폼 유효성 상태
    let isPasswordValid = false;
    
    // 가입 버튼 클릭 시 처리
    $('#userRegistBtn').click(function () {
        // 입력값 가져오기
        var id = $('#id').val() ? $('#id').val().trim() : '';
        var pwd = $('#pwd').val() ? $('#pwd').val().trim() : '';
        var rePwd = $('#rePwd').val() ? $('#rePwd').val().trim() : ''; // 비밀번호 확인 필드 추가
        var name = $('#name').val() ? $('#name').val().trim() : '';
        var email = $('#email').val() ? $('#email').val().trim() : '';
        var gender = $('input[name="gender"]:checked').val() ? $('input[name="gender"]:checked').val().trim() : '';
        var nickname = $('#nickname').val() ? $('#nickname').val().trim() : '';

		var pwdPattern = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}$/;
			
        // 메시지 초기화
        $('#idDiv').empty();
        $('#pwdDiv').empty();
        $('#rePwdDiv').empty();
        $('#nameDiv').empty();
        $('#nicknameDiv').empty();
        $('#genderDiv').empty();
        $('#emailDiv').empty();
        $('#checkAuthCodeDiv').empty();

        if (id === '') {
            $('#idDiv').html("아이디를 입력해주세요");
            isValid = false;
        } else if (pwd === '') {
            $('#pwdDiv').html("비밀번호를 입력해주세요");
            isValid = false;
        } else if (rePwd === '') {
            $('#rePwdDiv').html("비밀번호 확인을 입력해주세요");
            isValid = false;
        } else if(!pwdPattern.test(pwd)) {
			$('#pwdDiv').html("영문자와 숫자의 조합으로 6자리 이상이어야 합니다.");
			isValid = false;
		} else if(!pwdPattern.test(rePwd)) {
			$('#rePwdDiv').html("영문자와 숫자의 조합으로 6자리 이상이어야 합니다.");
			isValid = false;
		} else if (pwd !== rePwd) {
            $('#rePwdDiv').html("비밀번호가 일치하지 않습니다.");
            isValid = false;
        } else if (name === '') {
            $('#nameDiv').html("이름을 입력해주세요");
            isValid = false;
        } else if (nickname === '') {
            $('#nicknameDiv').html("닉네임을 입력해주세요");
            isValid = false;
        } else if (gender === '') {
            $('#genderDiv').html("성별을 선택해주세요");
            isValid = false;
        } else if (email === '') {
            $('#emailDiv').html("이메일을 입력해주세요");
            isValid = false;
        } else {
            // 이메일 형식 검사
            var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailPattern.test(email)) {
                $('#emailDiv').html("올바른 이메일 형식이 아닙니다.");
                isValid = false;
            } else if (!isEmailVerified) { // 이메일 인증 여부 확인
                $('#emailDiv').html("이메일 인증을 완료해주세요.");
                isValid = false;
            } else {
                isValid = true;
            }
        }

        // 모든 필드가 유효할 경우 추가 처리
        if (isValid) {
            $.ajax({
                type: 'post',
                url: '/miniSpringWeb/user/userRegist',
                data: $('#userRegistForm').serialize(),
                success: function () {
                    alert('회원가입이 완료되었습니다.');
                    location.href = '/miniSpringWeb/';
                },
                error: function (xhr, status, error) {
                    alert('회원가입 처리 중 오류가 발생했습니다.');
                }
            });
        } else {
            return false;
        }
    });

    // 비밀번호 유효성 검사
    $('#rePwd').on('focusout keyup', function () {
        pwdCheck();
    });

    function pwdCheck() {
        var pwd = $('#pwd').val();
        var rePwd = $('#rePwd').val();
        var messageElement = $('#pwdDiv'); // 비밀번호 입력란 아래 메시지 표시할 요소

        messageElement.text('');
        messageElement.css('color', '');

        var pwdPattern = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}$/;
        if (!pwdPattern.test(pwd)) {
            messageElement.text("영문자와 숫자의 조합으로 6자리 이상이어야 합니다.");
            messageElement.css('color', 'red');
            isPasswordValid = false;
        } else if (pwd !== rePwd) {
            messageElement.text("비밀번호가 맞지 않습니다.");
            messageElement.css('color', 'red');
            isPasswordValid = false;
        } else if (pwdParttern.test(rePwd) && pwdParttern.test(pwd)){
            messageElement.text("비밀번호가 일치합니다.");
            messageElement.css('color', 'green');
            isPasswordValid = true;
        }
    }

    // 아이디 중복 체크
    $('#id').focusout(function () {
        let id = $("#id").val();
        $('#idDiv').empty();

        if (id === '') {
            $('#idDiv').html('아이디를 입력해주세요.');
        } else {
            $.ajax({
                type: 'post',
                url: '/miniSpringWeb/user/getCheckId',
                data: { id: id },
                dataType: 'text',
                success: function (data) {
                    if (data.trim() === 'non_exist') {
                        $('#idDiv').html('사용 가능한 아이디입니다.').css('color', 'green');
                    } else {
                        $('#idDiv').html('이미 가입된 아이디입니다.').css('color', 'red');
                    }
                },
                error: function (e) {
                    console.log(e);
                }
            });
        }
    });

    // 닉네임 중복 체크
    $('#nickname').focusout(function () {
        let nickname = $('#nickname').val();
        $('#nicknameDiv').empty();

        if (nickname === '') {
            $('#nicknameDiv').html('닉네임을 입력해주세요.');
        } else {
            $.ajax({
                type: 'post',
                url: '/miniSpringWeb/user/getCheckNickname',
                data: { nickname: nickname },
                dataType: 'text',
                success: function (data) {
                    if (data.trim() === 'non_exist') {
                        $('#nicknameDiv').html('사용 가능한 닉네임입니다.').css('color', 'green');
                    } else {
                        $('#nicknameDiv').html('이미 사용 중인 닉네임입니다.').css('color', 'red');
                    }
                },
                error: function (e) {
                    console.log(e);
                }
            });
        }
    });

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
                $.ajax({
                    url: '/miniSpringWeb/user/emailAuth',
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
});
