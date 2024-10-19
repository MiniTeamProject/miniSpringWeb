$(function () {
    // 가입 버튼 클릭 시 처리
    $('#userUpdateBtn').click(function () {
        // 입력값 가져오기
        var id = $('#id').val() ? $('#id').val().trim() : '';
        var pwd = $('#pwd').val() ? $('#pwd').val().trim() : '';
        var name = $('#name').val() ? $('#name').val().trim() : '';
        var email = $('#email').val() ? $('#email').val().trim() : '';

        // 메시지 초기화
        $('#idDiv').html('');
        $('#pwdDiv').html('');
        $('#nameDiv').html('');
        $('#emailDiv').html('');
      

        // 유효성 검사
        var isValid = true; // 폼 유효성 상태

        if (pwd === '') {
            $('#pwdDiv').html("비밀번호를 입력해주세요");
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
            let formData = new FormData($('#userUpdateForm')[0]);
            
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







});



