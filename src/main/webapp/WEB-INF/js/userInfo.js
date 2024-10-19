$(function () {
    // 수정 버튼 클릭 시 처리
    $('#userUpdateBtn').click(function () {
        // 입력값 가져오기
        var id = $('#id').val() ? $('#id').val().trim() : '';
        var pwd = $('#pwd').val() ? $('#pwd').val().trim() : '';
        var confirmPwd = $('#confirmPwd').val() ? $('#confirmPwd').val().trim() : ''; // 비밀번호 확인
        var name = $('#name').val() ? $('#name').val().trim() : '';
        var email = $('#email').val() ? $('#email').val().trim() : '';
        var nickname = $('#nickname').val() ? $('#nickname').val().trim() : ''; // 닉네임

        // 메시지 초기화
        $('#idDiv').html('');
        $('#pwdDiv').html('');
        $('#nameDiv').html('');
        $('#emailDiv').html('');
        $('#nicknameDiv').html('');

        // 유효성 검사
        var isValid = true; // 폼 유효성 상태

        // 필드 유효성 검사
        if (pwd === '') {
            $('#pwdDiv').html("비밀번호를 입력해주세요");
            isValid = false;
        } else if (pwd !== confirmPwd) {
            $('#pwdDiv').html("비밀번호가 일치하지 않습니다.");
            isValid = false;
        } else if (nickname === '') {
            $('#nicknameDiv').html("닉네임을 입력해주세요");
            isValid = false;
        } 

        // 모든 필드가 유효할 경우 추가 처리
        if (isValid) {
            console.log("폼이 유효합니다.");
            // 여기에 폼 제출 로직 추가 가능
            let formData = {
                id: id,
                pwd: pwd,
                name: name,
                email: email,
                nickname: nickname
            };
            
            $.ajax({
                type: 'post',
                enctype: 'multipart/form-data',
				processData: false,
				contentType: false,
                url: '/miniSpringWeb/user/userUpdate',
                data: formData, //$('#userUpdateForm').serialize(),
                success: function () {
                    alert('회정보가 수정 완료되었습니다.');
                    location.href = '/miniSpringWeb/';
                },
                error: function (xhr, status, error) {
                    console.error('AJAX 요청 실패: ', error);
                    console.error('상태: ', status);
                    console.log('응답 텍스트: ', xhr.responseText); // 서버 응답 내용 출력
                    alert('회원정보수정 처리 중 오류가 발생했습니다.'); // 사용자에게 오류 메시지 표시
                }
            });
        }
    });

    // 닉네임 중복 체크
    $('#nickname').focusout(function () {
        let nickname = $('#nickname').val().trim();

        $('#nicknameDiv').empty();

        if (nickname === '') {
            $('#nicknameDiv').html('닉네임을 입력해주세요.');
        } else {
            $.ajax({
                type: 'post',
                url: '/miniSpringWeb/user/getCheckNickname',  // 서버에서 처리할 URL을 입력합니다.
                data: { nickname: nickname },
                dataType: 'text',
                success: function (data) {
                    if (data.trim() === 'non_exist') {
                        $('#nicknameDiv').html('사용 가능한 닉네임입니다.').css('color', 'green');
						$("#checkNickname").val(nickname);
                    } else {
                        $('#nicknameDiv').html('이미 사용 중인 닉네임입니다.').css('color', 'red');
						$("#checkNickname").val().empty();
                    }
                },
                error: function (e) {
                    console.log(e);
                }
            });
        }
    });
});



