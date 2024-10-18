$(document).ready(function() {

    // Froala Editor 인스턴스 생성
    let editor = new FroalaEditor('#editor', {
        language: 'ko', // 한국어 설정
        toolbarButtons: [
            'bold',
            'italic',
            'underline',
            'strikeThrough',
            'fontSize',
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
		height: '100%',  // 부모 요소의 높이를 상속받음
    });

    // 글 등록 버튼 클릭 시
    $('#writeBtn').on('click', function() {
        let description = editor.html.get();
        let name = $('#name').val();
        let price = $('#price').val();
        let category = $('#category').val();

		// 상품명과 내용 유효성 검사
        if (!name || name.trim() === '') {
            $("#checkDiv").html('<span style="color: red; font-weight: bold; font-size: 9pt;">제목을 입력하세요.</span>');
            $('#name').focus();
            return false;
        }

        if (!description || description.trim() === '') {
            $("#checkDiv").html('<span style="color: red; font-weight: bold; font-size: 9pt;">내용을 입력하세요.</span>');
            editor.events.focus(); // 에디터 포커스
            return false;
        }
        if (!price || price.trim() === '') {
            $("#checkDiv").html('<span style="color: red; font-weight: bold; font-size: 9pt;">가격을을 입력하세요.</span>');
            editor.events.focus(); // 에디터 포커스
            return false;
        }

        // FormData 생성
        let formData = new FormData();
        formData.append('name', name);
        formData.append('description', description);
        formData.append('price', price);
        formData.append('category', category);

        // AJAX 요청
        $.ajax({
            type: 'post',
            url: '/miniSpringWeb/store/storeWrite', // 게시물 저장 URL
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
				let result = response.trim();
                if(result == 'success') {
					alert('게시물이 등록되었습니다.');
					location.href = '/miniSpringWeb/store/storeMain'; // 게시물 목록으로 이동
				} else {
					alert('게시물이 등록에 실패했습니다.');
					location.href = '/miniSpringWeb/store/storeMain'; // 게시물 목록으로 이동
				}
            },
            error: function(error) {
                alert('서버 연결 오류');
                console.log(error);
            }
        });
    });
});
