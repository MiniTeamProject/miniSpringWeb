package board.bean;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class BoardDTO {
    private int seq;                        // 글번호
    private String id;                      // 아이디
    private String nickname;                // 닉네임
    private String email;                   // 이메일
    private String subject;                 // 제목
    private String content;                 // 내용
    private String imageFileName;           // 게시글 이미지 파일(UUID 파일이름)
    private String imageOriginalFileName;   // 게시글 이미지 파일(진짜 파일이름)
    private String profileFileName;         // 프로필 이미지(UUID 파일이름)
    private String profileOriginalFileName; // 프로필 이미지 파일(진짜 파일이름)
    private int ref;                        // 그룹번호
    private int lev;                        // 단계
    private int step;                       // 글순서
    private int pseq;                       // 원글번호
    private int reply;                      // 답변수
    private int hit;                        // 조회수
    private int category;                   // 게시판 카테고리
    private Timestamp logtime;              // 작성일
}
