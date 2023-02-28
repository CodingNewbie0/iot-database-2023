-- 그냥 테이블 접근
SELECT *
  FROM memberTBL;
  
-- 뷰 생성
CREATE VIEW uv_memberTBL
	AS
    SELECT memberName, memberAddress
      FROM memberTBL;
      
-- 뷰로 조회
SELECT *
  FROM uv_membertbl;