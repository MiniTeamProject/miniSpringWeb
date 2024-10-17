$(function () {
    // 가입 버튼 클릭 시 처리
    $('#userRegistBtn').click(function () {
        // 입력값 가져오기
        var id = $('#id').val() ? $('#id').val().trim() : '';
        var pwd = $('#pwd').val() ? $('#pwd').val().trim() : '';
        var rePwd = $('#rePwd').val() ? $('#rePwd').val().trim() : ''; // 비밀번호 확인 필드 추가
        var name = $('#name').val() ? $('#name').val().trim() : '';
        var email = $('#email').val() ? $('#email').val().trim() : '';

        // 메시지 초기화
        $('#idDiv').html('');
        $('#pwdDiv').html('');
        $('#nameDiv').html('');
        $('#emailDiv').html('');
        $('#rePwdDiv').html(''); // 비밀번호 확인 메시지 초기화

        // 유효성 검사
        var isValid = true; // 폼 유효성 상태

        if (id === '') {
            $('#idDiv').html("아이디를 입력해주세요");
            isValid = false;
        }
        if (pwd === '') {
            $('#pwdDiv').html("비밀번호를 입력해주세요");
            isValid = false;
        }
        if (rePwd === '') {
            $('#rePwdDiv').html("비밀번호 확인을 입력해주세요");
            isValid = false;
        } else if (pwd !== rePwd) {
            $('#rePwdDiv').html("비밀번호가 일치하지 않습니다.");
            isValid = false;
        }
        if (name === '') {
            $('#nameDiv').html("이름을 입력해주세요");
            isValid = false;
        }
        if (email === '') {
            $('#emailDiv').html("이메일을 입력해주세요");
            isValid = false;
        } else {
            // 이메일 형식 검사
            var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailPattern.test(email)) {
                $('#emailDiv').html("올바른 이메일 형식이 아닙니다.");
                isValid = false;
            }
        }

        // 모든 필드가 유효할 경우 추가 처리
        if (isValid) {
            console.log("폼이 유효합니다.");
            // 여기에 폼 제출 로직 추가 가능
            $.ajax({
                type: 'post',
                url: '/miniSpringWeb/user/userRegist',
                data: $('#userRegistForm').serialize(),
                success: function () {
                    alert('회원가입이 완료되었습니다.');
                    location.href = '/miniSpringWeb/';
                },
                error: function (xhr, status, error) {
                    console.error('AJAX 요청 실패: ', error);
                    console.error('상태: ', status);
                    console.log('응답 텍스트: ', xhr.responseText); // 서버 응답 내용 출력
                    alert('회원가입 처리 중 오류가 발생했습니다.'); // 사용자에게 오류 메시지 표시
                }
            });
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

        // 초기화
        messageElement.text('');
        messageElement.css('color', ''); // 초기 색상

        var pwdPattern = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}$/;
        if (!pwdPattern.test(pwd)) {
            messageElement.text("비밀번호는 영문자와 숫자의 조합으로 6자리 이상이어야 합니다.");
            messageElement.css('color', 'red');
        } else if (pwd !== rePwd) {
            messageElement.text("비밀번호가 맞지 않습니다.");
            messageElement.css('color', 'red');
        } else {
            messageElement.text("비밀번호가 일치합니다.");
            messageElement.css('color', 'green');
        }
    }

    // 아이디 중복 체크
    $('#id').focusout(function () {
        $('#idDiv').empty();

        if ($('#id').val() === '') {
            $('#idDiv').html('먼저 아이디 입력');
        } else {
            $.ajax({
                type: 'post',
                url: '/miniSpringWeb/user/getCheckId',
                data: { 'id': $('#id').val() },
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
    // 이메일 인증 요청
    $('#emailBtn').click(function() {
        var email = $('#email').val();
        $.ajax({
            url: '/miniSpringWeb/user/emailAuth',
            type: 'POST',
            data: { email: email },
            success: function(checkNum) {
                $('#checkAuthCode').prop('disabled', false); // 인증 코드 입력 필드 활성화
                alert('인증 코드가 이메일로 발송되었습니다.');
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청 실패: ', error);
                alert('이메일 인증 중 오류가 발생했습니다.');
            }
        });
    });

    // 인증번호 확인 함수
    function checkAuthCode() {
        var inputCode = $('#checkAuthCode').val(); // 사용자가 입력한 인증번호
        var email = $('#email').val(); // 사용자가 입력한 이메일

        // AJAX 요청
        $.ajax({
            url: '/miniSpringWeb/user/verifyAuthCode',
            type: 'POST',
            data: {
                email: email,
                authCode: inputCode
            },
            success: function(response) {
                if (response.valid) {
                    $('#checkAuthCodeDiv').text("인증번호가 일치합니다.").css('color', 'green');
                } else {
                    $('#checkAuthCodeDiv').text("인증번호가 일치하지 않습니다.").css('color', 'red');
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청 실패: ', error);
                $('#checkAuthCodeDiv').text('인증번호 검증 중 오류가 발생했습니다.').css('color', 'red');
            }
        });
    }

    // 인증번호 입력 후 포커스 아웃 이벤트
    $('#checkAuthCode').on('focusout', checkAuthCode);
    // 인증번호 입력 필드 클릭 이벤트 - 오류 메시지 초기화
    $('#checkAuthCode').on('click', function() {
        $('#checkAuthCodeDiv').text(''); // 오류 메시지 초기화
    });
});



