$(document).ready(function() {
    $('#selectForm').change(function() {
        var selectedValue = $(this).val();
        var formAction;

        // 선택된 값에 따라 action 변경
        if (selectedValue === "0") {
            formAction = "/miniSpringWeb/store/search"; // 멍캣마켓
        } else if (selectedValue === "1") {
            formAction = "/miniSpringWeb/board/search"; // 마켓광장
        }

        // form action 설정
        $('#searchForm').attr('action', formAction);
    });
	
    // Enter 키 입력 이벤트 처리
    $("#query").keypress(function(event) {
        if (event.which === 13) { // Enter 키 코드
            event.preventDefault(); // 기본 이벤트 방지
            $(this).closest("form").submit(); // 폼 제출
        }
    });

    // 버튼 클릭 이벤트 처리
    $("button").click(function() {
        $(this).closest("form").submit(); // 폼 제출
    });
});
