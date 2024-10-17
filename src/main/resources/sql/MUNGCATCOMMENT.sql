 -- [MySQL TABLE] 댓글 테이블
CREATE TABLE MUNGCATCOMMENT (
    seq INTEGER PRIMARY KEY AUTO_INCREMENT,             -- 댓글 번호
    ref INTEGER NOT NULL,                               -- 원글 번호 (MUNGCATBOARD의 seq를 참조)
    id VARCHAR(20) NOT NULL,                            -- 댓글 작성자 아이디
    content VARCHAR(4000) NOT NULL,                     -- 댓글 내용
    lev INTEGER DEFAULT NULL,                           -- 대댓글일 경우 부모 댓글 ID
    logtime TIMESTAMP DEFAULT NOW(),                    -- 작성일
    FOREIGN KEY (ref) REFERENCES MUNGCATBOARD(seq)      -- 게시글과의 관계 설정
);