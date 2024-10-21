$(document).ready(function() {
    // 댓글 작성 버튼 클릭 시
    $('#commentWriteBtn').click(function() {
        const commentContent = $('#comment').val();
        const seq = $('#seq').val();
        const visitorId = $('#visitorId').val();
		const nickname = $("#nickname").val();

        // 댓글 내용이 비어있는 경우 알림
        if (!commentContent) {
            $("#checkDiv").html("<span style='color: red; font-size: 10pt; font-weight: bold;'>댓글 내용을 입력하세요.</span>");
            return;
        }

        // AJAX 요청
        $.ajax({
            type: 'POST',
            url: '/miniSpringWeb/comment/write', // 댓글 작성 API URL
            data: {
                seq: seq,
                id: visitorId,
				nickname: nickname,
                comment: commentContent
            },
            success: function(response) {
				let result = response.trim();
				if(result != 'fail') {
					location.reload();
				} else {
					$("#checkDiv").html("댓글 작성 실패");
				}
            },
            error: function() {
                alert("댓글 작성 실패. 다시 시도해 주세요.");
            }
        });
    });
});
