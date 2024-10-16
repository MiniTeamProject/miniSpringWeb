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
});
