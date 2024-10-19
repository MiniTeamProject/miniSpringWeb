function storePaging(pg) { 
    location.href = "/miniSpringWeb/store/storeMain?pg=" + pg; // 페이지 이동
}

function hitandView(postElement) {
    const seq = $(postElement).find("input[name='seq']").val(); // 클릭한 게시물 요소에서 seq 값 가져오기
    const authorId = $("#authorId").val();
    const visitorId = $("#visitorId").val();
    const pg = $("#pg").val();
    const url = "/miniSpringWeb/store/storeView?pg=" + pg + "&seq=" + seq; // URL 생성
    
    // 작성자 아이디와 방문자 아이디가 다를 때만 조회수 증가
    if (authorId !== visitorId) {
        $.ajax({
            type: 'POST',
            url: '/miniSpringWeb/store/increaseHit', // 조회수 증가 URL
            data: { seq: seq },
            success: function(response) {
                console.log("조회수가 증가했습니다.");
                location.href = url;
            },
            error: function(xhr, status, error) {
                console.error("조회수 증가 실패: ", error);
                location.href = url;
            }
        });
    } else {
        location.href = url;
    }
}