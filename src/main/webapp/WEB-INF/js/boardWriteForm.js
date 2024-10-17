$(document).ready(function() {
    let uploadedImages = []; // 이미지 URL을 저장할 배열 초기화
    let uploadedFileNames = []; // 업로드된 파일 이름 저장
    let uploadedOriginalFileNames = []; // 원본 파일 이름 저장
	
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
        imageUploadURL: '/miniSpringWeb/image/uploadImage', // 서버의 이미지 업로드 경로
		'events': {
		    'image.uploaded': function(response) {
		        let imageUrl = JSON.parse(response).link; // 서버에서 받은 이미지 URL
				let imageFileName = JSON.parse(response).imageFileName; // 서버에서 받은 이미지 URL
				let imageOriginalFileName = JSON.parse(response).imageOriginalFileName; // 서버에서 받은 이미지 URL
				
                uploadedImages.push(imageUrl); // 업로드된 이미지 URL 배열에 추가
                uploadedFileNames.push(imageFileName); // 업로드된 이미지 파일 이름 추가
                uploadedOriginalFileNames.push(imageOriginalFileName); // 업로드된 이미지 원본 파일 이름 추가
				
		        uploadedImages.push(imageUrl); // 업로드된 이미지 URL 배열에 추가
		        console.log('이미지 업로드 성공:', imageUrl);
				console.log('이미지 업로드 성공:', imageFileName);
				console.log('이미지 업로드 성공:', imageOriginalFileName);
				
		        // .inputData에 hidden input 추가 (name 속성을 배열로 설정)
		        $(".inputData").append(`
		            <input type="hidden" name="imageUrls[]" value="${imageUrl}"/>
		            <input type="hidden" name="imageFileNames[]" value="${imageFileName}"/>
		            <input type="hidden" name="imageOriginalFileNames[]" value="${imageOriginalFileName}"/>
		        `);
		    },
		    'image.error': function(error) {
		        console.log('이미지 업로드 실패:', error);
		    }
		}
    });

    // 글 등록 버튼 클릭 시
    $('#writeBtn').on('click', function() {
		let id = $('#id').val();
        let content = editor.html.get(); // 수정된 부분
        let subject = $('#subject').val();
        let category = $('#category').val();
		
		// 제목과 내용 유효성 검사
        if (!subject || subject.trim() === '') {
            $("#checkDiv").html('<span style="color: red; font-weight: blod; font-size: 9pt;">제목을 입력하세요.</span>');
            $('#subject').focus();
            return false;
        }

        if (!content || content.trim() === '') {
            $("#checkDiv").html('<span style="color: red; font-weight: blod; font-size: 9pt;">내용을 입력하세요.</span>');
            editor.events.focus(); // 에디터 포커스
            return false;
        }
		
        // FormData 생성
        let formData = new FormData();
		formData.append('id', id); // ID 추가
        formData.append('subject', subject);
        formData.append('content', content);
        formData.append('category', category);

        // 배열의 내용을 FormData에 자동으로 추가
        uploadedImages.forEach(url => formData.append("imageUrls[]", url));
        uploadedFileNames.forEach(fileName => formData.append("imageFileNames[]", fileName));
        uploadedOriginalFileNames.forEach(originalFileName => formData.append("imageOriginalFileNames[]", originalFileName));
		
        // AJAX 요청
        $.ajax({
            type: 'post',
            url: '/miniSpringWeb/board/boardWrite', // 게시물 저장 URL
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
				let result = response.trim();
                if(result == 'success') {
					alert('게시물이 등록되었습니다.');
					location.href = '/miniSpringWeb/board/boardMain'; // 게시물 목록으로 이동
				} else {
					alert('게시물이 등록에 실패했습니다.');
					location.href = '/miniSpringWeb/board/boardMain'; // 게시물 목록으로 이동
				}
            },
            error: function(error) {
                alert('서버 연결 오류');
                console.log(error);
            }
        });
    });
});
