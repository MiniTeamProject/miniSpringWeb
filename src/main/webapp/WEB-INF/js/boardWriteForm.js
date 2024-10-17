$(document).ready(function() {
    // Froala Editor 인스턴스 생성
    new FroalaEditor('#editor', {
        language: 'ko', // 한국어 설정
        toolbarButtons: [
            'undo',
            'redo',
            'bold',
            'italic',
            'underline',
            'strikeThrough',
            'fontSize',
            'color',
            'inlineStyle',
            'paragraphFormat',
            'align',
            'formatOL',
            'formatUL',
            'insertHR',
            'insertImage',
            'insertTable',
            'specialCharacters',
            'insertLink',
            'insertFile',
            'clearFormatting',
            'quote',
            'selectAll',
            'html',
            'fullscreen'
        ],
        colors: {
            // 기본 색상 팔레트
            colors: [
                '#ff0000', // 빨강
                '#00ff00', // 초록
                '#0000ff', // 파랑
                '#000000', // 검정
                '#ffffff', // 흰색
                '#ff00ff', // 핑크
                '#ffff00', // 노랑
                '#00ffff', // 청록
                '#800080', // 보라
                '#ffa500'  // 주황
            ],
            // 추가 배경 색상 팔레트
            backgroundColors: [
                '#ffcccc', // 연한 빨강
                '#ccffcc', // 연한 초록
                '#ccccff', // 연한 파랑
                '#e0e0e0', // 연한 회색
                '#f0f0f0', // 밝은 회색
                '#ffffcc', // 연한 노랑
                '#ffccff', // 연한 핑크
                '#ccffff'  // 연한 청록
            ]
        },
        imageUploadURL: '/miniSpringWeb/board/uploadImage', // 서버의 이미지 업로드 경로
        events: {
            'image.uploaded': function(response) {
                let imageUrl = JSON.parse(response).link; // 서버에서 받은 이미지 URL
                uploadedImages.push(imageUrl); // 업로드된 이미지 URL 배열에 추가
                console.log('이미지 업로드 성공:', imageUrl);
            },
            'image.error': function(error) {
                console.log('이미지 업로드 실패:', error);
            }
        }
    });
    
    // 글 등록 버튼 클릭 시
    $('#writeBtn').on('click', function() {
        let content = $('#editor').froalaEditor('html.get'); // 에디터 내용 가져오기
        let subject = $('#subject').val();
        let category = $('#category').val();

        // FormData 생성
        let formData = new FormData();
        formData.append('subject', subject);
        formData.append('content', content);
        formData.append('category', category);

        // 업로드된 이미지 URL을 FormData에 추가
        formData.append('uploadedImages', JSON.stringify(uploadedImages));

        // AJAX 요청
        $.ajax({
            type: 'post',
            url: '/miniSpringWeb/board/boardWrite', // 게시물 저장 URL
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                alert('게시물이 등록되었습니다.');
                location.href = '/miniSpringWeb/board/boardMain'; // 게시물 목록으로 이동
            },
            error: function(error) {
                alert('게시물 등록에 실패했습니다.');
                console.log(error);
            }
        });
    });
});
