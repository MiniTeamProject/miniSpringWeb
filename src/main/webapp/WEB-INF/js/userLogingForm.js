$(function() {
    $('#checkDiv').empty();

    $('#id').on('focusout', function() {
        const idValue = $('#id').val().trim(); // 입력된 아이디값 가져오기
        if (idValue === '') {
            $('#checkDiv').html("<span style='color: red; font-weight: bold'>아이디를 입력해주세요</span>");
        } else {
            $('#checkDiv').empty();
        }
    });
    
    $('#pwd').on('focusout', function() {
        const pwdValue = $('#pwd').val().trim();
        if (pwdValue === '') {
            $('#checkDiv').html("<span style='color: red; font-weight: bold'>비밀번호를 입력해주세요</span>");
        } else {
            $('#checkDiv').empty();
        }
    });
    
    $('#userLoginFormBtn').click(function() {
        $('#checkDiv').empty();
        
        if ($('#id').val() == '') {
            $('#checkDiv').html("<span style='color: red; font-weight: bold'>아이디를 입력해주세요</span>");
            
            return false;
        } else if($('#pwd').val() == '') {
            $('#checkDiv').empty();
            $('#checkDiv').html("<span style='color: red; font-weight: bold'>비밀번호를 입력해주세요</span>");
            
            return false;
        } else {
            $('#checkDiv').empty();
            
            $.ajax({
                type: 'post',
                url: '/miniSpringWeb/user/userLogin',
                data: $('#userLoginForm').serialize(),  
                dataType: 'text',
                success: function(data) {
                    let result = data.trim();
                    
                    if (result == 'success') {
                        location.href = '/miniSpringWeb/';                    
                    } else {
                        $("#checkDiv").html("<span style='color: red; font-weight: bold'>아이디 또는 비밀번호를 확인해주세요</span>")
                        return;
                    }
                },
                error: function(e) {
                    console.log(e);
                }
            }); // AJAX
        }
    });        
});
