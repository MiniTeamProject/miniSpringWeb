$(document).ready(function() {
    // 제목 입력 제한
    $('#subject').on('input', function() {
        const maxLength = 100;
        const currentLength = $(this).val().length;
        if (currentLength > maxLength) {
            alert("제목은 최대 100자까지 입력 가능합니다.");
            $(this).val($(this).val().substring(0, maxLength));
        }
    });

    // 게시물 내용 글자수 제한
    $('#content').on('input', function() {
        const maxLength = 5000;
        const currentLength = $(this).val().length;
        if (currentLength > maxLength) {
            alert("내용은 최대 5000자까지 입력 가능합니다.");
            $(this).val($(this).val().substring(0, maxLength));
        }
    });

    // 파일 업로드 시 미리보기
    $('#fileUpload').on('change', function(e) {
        const file = e.target.files[0];
        const reader = new FileReader();

        reader.onload = function(e) {
            $('#filePreview').attr('src', e.target.result);
            $('#filePreview').show();
        };

        if (file) {
            reader.readAsDataURL(file);
        } else {
            $('#filePreview').hide();
        }
    });

    // 폼 제출 시 입력 값 검증
    $('#boardForm').on('submit', function(e) {
        const subject = $('#subject').val().trim();
        const content = $('#content').val().trim();
        
        if (subject === '') {
            alert("제목을 입력해주세요.");
            $('#subject').focus();
            e.preventDefault();
            return;
        }

        if (content === '') {
            alert("내용을 입력해주세요.");
            $('#content').focus();
            e.preventDefault();
            return;
        }

        const confirmSubmit = confirm("게시글을 등록하시겠습니까?");
        if (!confirmSubmit) {
            e.preventDefault();
        }
    });

    // 취소 버튼 클릭 시
    $('#cancelBtn').on('click', function() {
        const confirmCancel = confirm("작성 중인 게시글을 취소하시겠습니까?");
        if (confirmCancel) {
            window.location.href = '/miniSpringWeb/board/boardMain'; // 게시판 목록 페이지로 이동
        }
    });
});
