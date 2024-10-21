$(document).ready(function() {
    function updatePlaceholder() {
        if ($(window).width() <= 768) {
            $('#query').attr('placeholder', '내용 입력');
        } else {
            $('#query').attr('placeholder', '검색할 내용을 입력하세요');
        }
    }

    // 초기 로드 시 placeholder 업데이트
    updatePlaceholder();

    // 윈도우 크기 변경 시 placeholder 업데이트
    $(window).resize(function() {
        updatePlaceholder();
    });
});
