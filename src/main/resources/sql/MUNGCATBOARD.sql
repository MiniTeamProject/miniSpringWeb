-- [MySQL TABLE] 커뮤니티 테이블
CREATE TABLE MUNGCATBOARD(
     seq INTEGER PRIMARY KEY AUTO_INCREMENT,            -- 글번호
     id VARCHAR(20) NOT NULL,                           -- 아이디
     nickname VARCHAR(100),                             -- 닉네임
     email VARCHAR(100),                                -- 이메일
     subject VARCHAR(255) NOT NULL,                     -- 제목
     content LONGBLOB NOT NULL,                         -- 내용
     imageFileName VARCHAR(200) DEFAULT NULL,           -- 게시글 이미지 파일(UUID)
     imageOriginalFileName VARCHAR(200) DEFAULT NULL,   -- 게시글 이미지 파일(OriginalName)
     profileFileName VARCHAR(200) DEFAULT NULL,         -- 프로필 이미지(파일이름)
     profileOriginalFileName VARCHAR(200) DEFAULT NULL, -- 프로필 이미지(파일이름)
     ref int DEFAULT 0 NOT NULL,                        -- 그룹번호
     lev int DEFAULT 0 NOT NULL,                        -- 단계
     step int DEFAULT 0 NOT NULL,                       -- 글순서
     pseq int DEFAULT 0 NOT NULL,                       -- 원글번호
     reply int DEFAULT 0 NOT NULL,                      -- 답변수
     hit int DEFAULT 0,                                 -- 조회수
     category INTEGER DEFAULT 0,                        -- 게시판 카테고리
     logtime TIMESTAMP DEFAULT NOW()                    -- 작성일
 );