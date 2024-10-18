package board.bean;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class BoardDTO {
    private int seq;                // 글번호
    private String id;              // 아이디
    private String subject;         // 제목
    private String content;         // 내용 (LONGBLOB이므로 byte[]로 처리)
    private int reply;              // 답변수
    private int hit;                // 조회수
    private String category;           // 게시판 카테고리
    private Timestamp logtime;      // 작성일
}
