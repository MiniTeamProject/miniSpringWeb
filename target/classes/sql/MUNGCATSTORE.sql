 -- [MySQL TABLE] �ְ߿�ǰ ���̺�
CREATE TABLE MUNGCATSTORE (
    id INT PRIMARY KEY AUTO_INCREMENT,          -- ��ǰ ID
    name VARCHAR(255) NOT NULL,                 -- ��ǰ��
    description VARCHAR(1000),                  -- ��ǰ ����
    price INT NOT NULL,                			-- ����
    stock INT NOT NULL DEFAULT 0,               -- �α� ��ǰ
    image VARCHAR(200),                         -- �̹��� ���ϸ�
    category VARCHAR(100),                      -- ī�װ�
    logtime TIMESTAMP DEFAULT NOW(),            -- ����� (created_at���� ����)
    logtime_up TIMESTAMP DEFAULT NOW() ON UPDATE NOW()  -- ������ (updated_at���� ����)
);

-- [MySQL TABLE] �ְ߿�ǰ ���� ���̺�
CREATE TABLE MUNGCATSTORE_REVIEWS (
    review_id INT PRIMARY KEY AUTO_INCREMENT,                   -- �ı� ID
    product_id INT NOT NULL,                                    -- ��ǰ ID (MUNGCATSTORE�� id�� ����)
    user_id VARCHAR(20) NOT NULL,                               -- ����� ID (�ı⸦ �ۼ��� ������� ID)
    nickname VARCHAR(100) NOT NULL,                             -- �ı� �ۼ��� �г���
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),    -- ���� (1~5)
    review_text TEXT,                                           -- �ı� ����
    logtime TIMESTAMP DEFAULT NOW(),                            -- �ۼ���
    FOREIGN KEY (product_id) REFERENCES MUNGCATSTORE(id)        -- �ܷ� Ű ����
);