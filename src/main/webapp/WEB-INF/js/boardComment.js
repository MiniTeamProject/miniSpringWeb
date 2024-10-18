$(document).ready(function() {
    // 댓글 작성 버튼 클릭 이벤트
    $('#commentWriteBtn').on('click', function() {
        const comment = $('#comment').val().trim();
        const seq = $('#seq').val(); // 게시글 seq
        const id = $('#visitorId').val(); // 방문자 ID

        // 댓글 내용이 비어있지 않은 경우에만 처리
        if (comment) {
            $.ajax({
                type: 'POST',
                url: '/miniSpringWeb/comment/commentWrite', // 댓글 작성 URL
                data: {
                    seq: seq,
                    comment: comment,
                    id: id
                },
                success: function(response) {
                    // 성공적으로 댓글이 작성되면 댓글 입력란 초기화
                    $('#comment').val('');
                    // 댓글 목록 업데이트 (필요한 경우)
                    // 예: loadComments(); // 댓글을 새로 불러오는 함수 호출
                    alert("댓글이 작성되었습니다.");
                },
                error: function(xhr, status, error) {
                    console.error("댓글 작성 실패: ", error);
                    alert("댓글 작성에 실패했습니다. 다시 시도해 주세요.");
                }
            });
        } else {
            alert("댓글 내용을 입력해 주세요.");
        }
    });
});
