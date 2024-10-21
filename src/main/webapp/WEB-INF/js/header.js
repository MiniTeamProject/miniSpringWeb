$(document).ready(function() {
    // 모바일 메뉴 클릭 시 메뉴 토글
    $('.mobile-menu').on("click", function(event) {
        event.stopPropagation(); // 클릭 이벤트 전파 방지
        $('.nav-links').toggleClass('active');
        $('.hamburger').toggleClass('active');
    });

    // 메뉴 외부 클릭 시 메뉴 숨기기
    $(document).click(function(event) {
        if (!$(event.target).closest('.mobile-menu').length && !$(event.target).closest('.nav-links').length) {
            $('.nav-links').removeClass('active');
            $('.hamburger').removeClass('active');
        }
    });
    
    $(".logo").on('click', function(){
        location.href="/miniSpringWeb/"; 
    });

    // 엔터 키를 눌렀을 때 로그인 버튼 클릭
    $(document).on('keypress', function(e) {
        if (e.which === 13) { // 엔터 키의 코드
            e.preventDefault(); // 기본 엔터 동작 방지
            $('#imgBtn').click(); // 로그인 버튼 클릭
        }
    });
});
