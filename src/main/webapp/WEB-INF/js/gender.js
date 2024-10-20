$(document).ready(function() {
    // 성별 버튼 클릭 시 라디오 버튼 업데이트
    $('.gender-btn').click(function() {
        // 모든 버튼에서 'active' 클래스 제거
        $('.gender-btn').removeClass('active');
        
        // 클릭된 버튼에 'active' 클래스 추가
        $(this).addClass('active');
        
        // 클릭된 버튼의 data-gender 값 가져오기
        var gender = $(this).data('gender');
        
        // 해당 성별에 맞는 라디오 버튼 선택
        if (gender == "M") {
            $('#gender-male').prop('checked', true); // 남자 선택
        } else if (gender == "F") {
            $('#gender-female').prop('checked', true); // 여자 선택
        }
    });
});
