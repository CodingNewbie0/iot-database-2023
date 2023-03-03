-- 뷰
USE sqldb;

CREATE VIEW uv_potentialUser
AS
	SELECT u.*
		 , b.num, b.prodName, b.price, b.amount
      FROM usertbl AS u
      LEFT OUTER JOIN buytbl AS b
        ON u.userID = b.userID
	 WHERE b.userID IS NULL;
     
SELECT * FROM uv_potentialUser;

-- 추가가능
SELECT *
  FROM uv_usertbl;
  
INSERT INTO uv_usertbl VALUES
	('kkk', '케케케', 1988, '제주');

-- 추가 불가능
SELECT * FROM uv_potentialuser;

INSERT INTO uv_potentialuser VALUES
	('ttt', '티티티', 1990, '서울', '010', '89898989', 190, '2023-01-01');