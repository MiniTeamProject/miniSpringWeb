forgotPwd.js


$(function(){
    $('#idDiv').empty();
    $('#pwdDiv').empty();
    $('#rePwdDiv').empty();

    $('#forgotPwdBtn').click(function(){
        // 폼 유효성 상태 초기화
        let isValid = true; 

        var id = $('#id').val() ? $('#id').val().trim() : '';
        var pwd = $('#pwd').val() ? $('#pwd').val().trim() : '';
        var rePwd = $('#rePwd').val() ? $('#rePwd').val().trim() : '';

        var pwdPattern = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}$/;

        // 오류 메시지 초기화
        $('#idDiv').empty();
        $('#pwdDiv').empty();
        $('#rePwdDiv').empty();

        // 유효성 검사
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
        } 
        if (!pwdPattern.test(pwd)) {
            $('#pwdDiv').html("영문자와 숫자의 조합으로 6자리 이상이어야 합니다.");
            isValid = false;
        } 
        if (!pwdPattern.test(rePwd)) {
            $('#rePwdDiv').html("영문자와 숫자의 조합으로 6자리 이상이어야 합니다.");
            isValid = false;
        } 
        if (pwd !== rePwd) {
            $('#rePwdDiv').html("비밀번호가 일치하지 않습니다.");
            isValid = false;
        }

        // 유효성 검사를 통과한 경우 AJAX 요청
        if (isValid) {
            $.ajax({
                type: 'post',
                url: '/miniSpringWeb/user/forgotPwdUpdate',
                data: {
                    id: id,
                    pwd: pwd
                },
                success: function () {
                    alert('비밀번호 변경이 완료되었습니다.');
                    location.href = '/miniSpringWeb/';
                },
                error: function (xhr, status, error) {
                    alert('비밀번호 변경 처리 중 오류가 발생했습니다.');
                }
            });
        } 
    });
});
