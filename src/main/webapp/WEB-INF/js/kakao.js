// kakaoLogin.js
Kakao.init('10d8d0adcd1019cef5c4edc7a60baf47'); // 발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk 초기화 여부 판단

// 카카오 로그인
function kakaoLogin() {
    Kakao.Auth.login({
        success: function (response) {
            Kakao.API.request({
                url: '/v2/user/me',
                success: function (response) {
                    console.log(response)
					// 사용자 정보를 활용한 처리
                    const userId = response.id; // 카카오 고유 ID
                    const userNickname = response.properties.nickname; // 닉네임
					
                    // AJAX 요청으로 서버에 사용자 정보 전달
                    $.ajax({
                        type: "POST",  // POST 요청
                        url: "/miniSpringWeb/user/kakao",  // 서버 URL
                        data: JSON.stringify({  // 데이터를 JSON 형식으로 전달
                            id: userId,
                            nickname: userNickname
                        }),
                        contentType: "application/json",  // 데이터 타입
                        success: function(response) {
                            window.location.href = "/miniSpringWeb/";  // 로그인 후 대시보드로 리다이렉트
                        },
                        error: function(error) {
                            // 에러 처리
                            console.log("세션 발급 실패: ", error);
                        }
                    });
					
                },
                fail: function (error) {
                    console.log(error)
                },
            });
        },
        fail: function (error) {
            console.log(error)
        },
    });
}

// 카카오 로그아웃
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
        Kakao.API.request({
            url: '/v1/user/unlink',
            success: function (response) {
                console.log(response)
            },
            fail: function (error) {
                console.log(error)
            },
        });
        Kakao.Auth.setAccessToken(undefined);
    }
}
