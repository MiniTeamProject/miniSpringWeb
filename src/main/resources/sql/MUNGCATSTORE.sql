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
