-- [MySQL TABLE] 댓글 테이블
CREATE TABLE MUNGCATCOMMENT (
    seq INTEGER PRIMARY KEY AUTO_INCREMENT,             -- 댓글 번호
    ref INTEGER NOT NULL,                               -- 원글 번호 (MUNGCATBOARD의 seq를 참조)
    id VARCHAR(20) NOT NULL,                            -- 댓글 작성자 아이디
    nickname VARCHAR(100),                              -- 댓글 작성자 닉네임 (NULL 허용)
    profile VARCHAR(200),                               -- 댓글 작성자 프로필 사진
    content VARCHAR(4000) NOT NULL,                     -- 댓글 내용
    logtime TIMESTAMP DEFAULT NOW(),                    -- 작성일
    FOREIGN KEY (ref) REFERENCES MUNGCATBOARD(seq)      -- 게시글과의 관계 설정
);