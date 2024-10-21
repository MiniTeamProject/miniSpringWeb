-- [MySQL TABLE] ȸ�� ���̺�
CREATE TABLE MUNGCATUSER (
    id VARCHAR(15) PRIMARY KEY,                                 -- ���̵�, �ʼ�, �⺻Ű
    pwd VARCHAR(255) NOT NULL,                                  -- ��й�ȣ, �ʼ�
    nickname VARCHAR(50) NOT NULL,                              -- �г���, �ʼ�
    name VARCHAR(50) NOT NULL,                                  -- �̸�, �ʼ�
    gender CHAR(1) NOT NULL,                                    -- ����, �ʼ�
    email VARCHAR(300) NOT NULL,                                -- �̸��� �ּ�, �ʼ�
    tel VARCHAR(11),                                            -- ��ȭ��ȣ ���ڸ�
    zipcode VARCHAR(20),                                        -- �����ȣ
    addr1 VARCHAR(255),                                         -- �ּ�
    addr2 VARCHAR(255),                                         -- ���ּ�
    profile INTEGER DEFAULT 0,                                  -- ������ ���� (�̹��� SEQ)
    totalwrite INTEGER DEFAULT 0,								-- �� �̹��� ���ۼ� ��
    admin CHAR(1) DEFAULT '0' NOT NULL,                         -- ������ ����((0 -> �Ϲ� �����), (1 -> ������)
    logtime TIMESTAMP DEFAULT NOW()                             -- ������    
);