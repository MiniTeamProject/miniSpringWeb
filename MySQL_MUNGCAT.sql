-- [MySQL TABLE] 회원 테이블
CREATE TABLE MUNGCATUSER (
    id VARCHAR(15) PRIMARY KEY,         -- 아이디, 필수, 기본키
    pwd VARCHAR(255) NOT NULL,          -- 비밀번호, 필수
    nickname VARCHAR(50) NOT NULL,      -- 닉네임, 필수
    name VARCHAR(50) NOT NULL,          -- 이름, 필수
    gender CHAR(1) NOT NULL,            -- 성별, 필수
    email VARCHAR(300) NOT NULL,        -- 이메일 주소, 필수
    tel VARCHAR(11),                    -- 전화번호 뒷자리
    zipcode VARCHAR(20),                -- 우편번호
    addr1 VARCHAR(255),                 -- 주소
    addr2 VARCHAR(255),                 -- 상세주소
    profileFileName VARCHAR(200) DEFAULT NULL,         -- 프로필 이미지(파일이름)
    profileOriginalFileName VARCHAR(200) DEFAULT NULL, -- 프로필 이미지(파일이름)
    admin CHAR(1) DEFAULT '0' NOT NULL,   -- 관리자 권한((0 -> 일반 사용자), (1 -> 관리자)
    logtime TIMESTAMP DEFAULT NOW()     -- 가입일
);

-- [MySQL TABLE] 커뮤니티 테이블
CREATE TABLE MUNGCATBOARD(
     seq INTEGER PRIMARY KEY AUTO_INCREMENT,    		-- 글번호
     id VARCHAR(20) NOT NULL,                   		-- 아이디
     nickname VARCHAR(100),                     		-- 닉네임
     email VARCHAR(100),                        		-- 이메일
     subject VARCHAR(255) NOT NULL,             		-- 제목
     content LONGBLOB NOT NULL,                 		-- 내용
     imageFileName VARCHAR(200) DEFAULT NULL,           -- 게시글 이미지 파일(UUID)
     imageOriginalFileName VARCHAR(200) DEFAULT NULL,	-- 게시글 이미지 파일(OriginalName)
     profileFileName VARCHAR(200) DEFAULT NULL,         -- 프로필 이미지(파일이름)
     profileOriginalFileName VARCHAR(200) DEFAULT NULL, -- 프로필 이미지(파일이름)
     ref int DEFAULT 0 NOT NULL,                		-- 그룹번호
     lev int DEFAULT 0 NOT NULL,                		-- 단계
     step int DEFAULT 0 NOT NULL,              			-- 글순서
     pseq int DEFAULT 0 NOT NULL,               		-- 원글번호
     reply int DEFAULT 0 NOT NULL,             			-- 답변수
     hit int DEFAULT 0,                         		-- 조회수
     category INTEGER DEFAULT 0,                		-- 게시판 카테고리
     logtime TIMESTAMP DEFAULT NOW()            		-- 작성일
 );
 
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
 
 -- [MySQL TABLE] 애견용품 테이블
CREATE TABLE MUNGCATSTORE (
    id INT PRIMARY KEY AUTO_INCREMENT,          -- 상품 ID
    name VARCHAR(255) NOT NULL,                 -- 상품명
    description VARCHAR(1000),                  -- 상품 설명
    price VARCHAR(500) NOT NULL,                -- 가격
    stock INT NOT NULL DEFAULT 0,               -- 재고 수량
    image VARCHAR(200),                         -- 이미지 파일명
    category VARCHAR(100),                      -- 카테고리
    logtime TIMESTAMP DEFAULT NOW(),            -- 등록일 (created_at에서 변경)
    logtime_up TIMESTAMP DEFAULT NOW() ON UPDATE NOW()  -- 수정일 (updated_at에서 변경)
);

-- [MySQL TABLE] 애견용품 리뷰 테이블
CREATE TABLE MUNGCATSTORE_REVIEWS (
    review_id INT PRIMARY KEY AUTO_INCREMENT,                   -- 후기 ID
    product_id INT NOT NULL,                                    -- 상품 ID (MUNGCATSTORE의 id를 참조)
    user_id VARCHAR(20) NOT NULL,                               -- 사용자 ID (후기를 작성한 사용자의 ID)
    nickname VARCHAR(100) NOT NULL,                             -- 후기 작성자 닉네임
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),    -- 평점 (1~5)
    review_text TEXT,                                           -- 후기 내용
    logtime TIMESTAMP DEFAULT NOW(),                            -- 작성일
    FOREIGN KEY (product_id) REFERENCES MUNGCATSTORE(id)        -- 외래 키 설정
);

drop table mungcatboard;
drop table Mungcatcomment;

select * from MUNGCATUSER;
select * from MUNGCATBOARD;
INSERT INTO MUNGCATUSER (id, pwd, nickname, name, gender, email, tel, zipcode, addr1, addr2, profile, admin) 
VALUES ('codelily', '1234', 'CodeLily', '김태훈', 'M', 'codelily98@naver.com', '01037989811', NULL, NULL, NULL, NULL, '0');

INSERT INTO MUNGCATBOARD (id, nickname, email, subject, content, imageFileName, imageOriginalFileName, profileFileName, profileOriginalFileName, ref, lev, step, pseq, reply, hit, category, logtime) VALUES
('user1', 'User One', 'user1@example.com', 'First Post', 'Content for the first post', NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, NOW()),
('user2', 'User Two', 'user2@example.com', 'Second Post', 'Content for the second post', NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, NOW()),
('user3', 'User Three', 'user3@example.com', 'Third Post', 'Content for the third post', NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, NOW()),
('user4', 'User Four', 'user4@example.com', 'Fourth Post', 'Content for the fourth post', NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, NOW()),
('user5', 'User Five', 'user5@example.com', 'Fifth Post', 'Content for the fifth post', NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, NOW()),
('user6', 'User Six', 'user6@example.com', 'Sixth Post', 'Content for the sixth post', NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, NOW()),
('user7', 'User Seven', 'user7@example.com', 'Seven Post', 'Content for the fifth post', NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, NOW());
