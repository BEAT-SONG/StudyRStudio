-- 관리자 권한(절대 권한)

-- 생성한 사용자의 비밀변호 변경
-- dbdb; = 비밀번호
-- 생성한 사용자는 수정이 불가능
-- Sever 에 아래의 정보를 가진(계정, 비밀번호) 접속 경로?를 만들어 줘라! 라는 의미
CREATE USER busan IDENTIFIED BY dbdb;

-- 사용자 삭제 
-- Drop User busan;

-- 생성한 사용자에게 권한 부여
-- 접속 권한, 관리자 권한 모두 부여
GRANT CONNECT, RESOURCE, DBA TO busan;

-- 권한 회수하기
-- REVOKE DBA FROM busan;
