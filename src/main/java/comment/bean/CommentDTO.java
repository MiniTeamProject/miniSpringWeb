package comment.bean;

import lombok.Data;

@Data
public class CommentDTO {
    private int seq;           // 댓글의 고유 번호
    private int ref;           // MUNGCATBOARD의 게시글 번호 (외래 키)
    private String id;         // 댓글 작성자 ID
    private String nickname;
    private String content;    // 댓글 내용
    private int lev;           // 댓글의 레벨 (대댓글의 깊이 등)
    private String logtime;    // 댓글 작성 시간
}
