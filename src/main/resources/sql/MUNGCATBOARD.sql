-- [MySQL TABLE] Ŀ�´�Ƽ ���̺�
CREATE TABLE MUNGCATBOARD(
     seq INTEGER PRIMARY KEY AUTO_INCREMENT,            -- �۹�ȣ
     id VARCHAR(20) NOT NULL,                           -- ���̵�
     subject VARCHAR(255) NOT NULL,                     -- ����
     content LONGBLOB NOT NULL,                         -- ����
     reply int DEFAULT 0 NOT NULL,                      -- �亯��
     hit int DEFAULT 0,                                 -- ��ȸ��
     category INTEGER DEFAULT 0,                        -- �Խ��� ī�װ�
     logtime TIMESTAMP DEFAULT NOW()                    -- �ۼ���
 );