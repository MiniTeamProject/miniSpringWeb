$(document).ready(function() {
    $('#updateButton').on('click', function() {
        // 필수 입력 정보 수집
        const id = $('#id').val();
        const pwd = $('#pwd').val();
        const repwd = $('#repwd').val();
        const nickname = $('#nickname').val();
        const tel = $('#tel').val();
        const zipcode = $('#zipcode').val();
        const addr1 = $('#addr1').val();
        const addr2 = $('#addr2').val();
        
        // 필수 입력 정보 확인
        if (!id || !pwd || !repwd || !nickname) {
            alert("필수 입력 정보를 모두 입력해 주세요.");
            return;
        }

        // 비밀번호 확인
        if (pwd !== repwd) {
            $("#pwdDiv").html("비밀번호가 일치하지 않습니다.");
            return;
        }

        // 비밀번호 유효성 체크: 6자리 이상, 영문과 숫자 혼합
        const passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]{6,}$/;
        if (!passwordRegex.test(pwd)) {
            $("#pwdDiv").html("비밀번호는 영문과 숫자를 혼합하여 6자리 이상이어야 합니다.");
            return;
        }

        // AJAX 요청
        $.ajax({
            type: 'POST',
            url: '/miniSpringWeb/user/userUpdate', // 요청 URL
            data: {
                id: id,
                pwd: pwd,
                nickname: nickname,
                tel: tel,
                zipcode: zipcode,
                addr1: addr1,
                addr2: addr2
            },
            success: function(response) {
                if (response.status === "success") {
                    alert("회원정보가 수정되었습니다.");
                    window.location.href = '/miniSpringWeb/user/logout'; // 수정 후 리디렉션
                } else {
                    alert("회원정보 수정에 실패했습니다.");
                    console.log(response.message); // 추가적인 메시지 로그
                }
            },
            error: function(xhr, status, error) {
                alert("회원정보 수정에 실패했습니다. 다시 시도해 주세요.");
                console.log(error); // 에러 로그
            }
        });
    });

    $("#userDeleteBtn").on("click", function() {
		let id = $("#id").val();
		let sessionPwd = $("#sessionPwd").val();
		
		// 삭제 확인
        if (!confirm("정말로 회원정보를 삭제하시겠습니까?")) {
            return; // 사용자가 취소를 클릭하면 종료
        } else {
			const checkpwd = prompt("비밀번호를 입력하세요");
			
			if(!checkpwd) {
				return;
			} else {       // AJAX 요청
		        $.ajax({
		            type: 'POST',
		            url: '/miniSpringWeb/user/userDelete', // 요청 URL
		            data: {
						id: id,
		                pwd: checkpwd // 비밀번호를 요청 데이터에 포함
		            },
		            success: function(response) {
		                if (response.status === "success") {
		                    alert("회원정보가 삭제되었습니다.");
		                    window.location.href = '/miniSpringWeb/'; // 삭제 후 리디렉션
		                } else {
		                    alert("비밀번호가 일치하지 않습니다. 회원정보 삭제에 실패했습니다.");
		                    window.location.href = '/miniSpringWeb/user/userInfo'
							console.log(response.message); // 추가적인 메시지 로그
		                }
		            },
		            error: function(xhr, status, error) {
		                alert("회원정보 삭제에 실패했습니다. 다시 시도해 주세요.");
		                console.log(error); // 에러 로그
		            }
		        });
			}
		}
    });
});
