document.addEventListener('DOMContentLoaded', function() {
    // 댓글 작성 버튼 클릭 시 폼을 토글하는 함수
    document.getElementById("toggleCommentForm").addEventListener("click", function() {
        var commentForm = document.getElementById("bottom");
        if (commentForm.style.display === "none" || commentForm.style.display === "") {
            commentForm.style.display = "block"; // 폼을 보이게 함
        } else {
            commentForm.style.display = "none";  // 폼을 숨김
        }
    });
});
