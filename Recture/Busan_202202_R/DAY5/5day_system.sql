-- ������ ����(���� ����)

-- ������ ������� ��к�ȣ ����
-- dbdb; = ��й�ȣ
-- ������ ����ڴ� ������ �Ұ���
-- Sever �� �Ʒ��� ������ ����(����, ��й�ȣ) ���� ���?�� ����� ���! ��� �ǹ�
CREATE USER busan IDENTIFIED BY dbdb;

-- ����� ���� 
-- Drop User busan;

-- ������ ����ڿ��� ���� �ο�
-- ���� ����, ������ ���� ��� �ο�
GRANT CONNECT, RESOURCE, DBA TO busan;

-- ���� ȸ���ϱ�
-- REVOKE DBA FROM busan;
