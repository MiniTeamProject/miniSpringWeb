-- [MySQL TABLE] 커뮤니티 테이블
CREATE TABLE MUNGCATBOARD(
     seq INTEGER PRIMARY KEY AUTO_INCREMENT,            -- 글번호
     id VARCHAR(20) NOT NULL,                           -- 아이디
     subject VARCHAR(255) NOT NULL,                     -- 제목
     content LONGBLOB NOT NULL,                         -- 내용
     reply int DEFAULT 0 NOT NULL,                      -- 답변수
     hit int DEFAULT 0,                                 -- 조회수
     category INTEGER DEFAULT 0,                        -- 게시판 카테고리
     logtime TIMESTAMP DEFAULT NOW()                    -- 작성일
 );