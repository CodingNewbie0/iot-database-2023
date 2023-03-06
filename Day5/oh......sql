USE bookrentalshop;

-- 1번 문제
SELECT CONCAT(SUBSTR(m.Names,1,1),',',SUBSTR(m.Names,2,3)) AS '회원명'
	 , SUBSTRING_INDEX(m.Addr, '시', -1) AS '주소'
     , m.Mobile AS '폰번호'
     , UPPER(m.Email) AS '이메일'
  FROM membertbl AS m
 ORDER BY m.Email DESC;

-- 2번 문제
SELECT d.Names AS '장르'
	 , b.Author AS '작가'
     , b.Names AS '책제목'
  FROM bookstbl AS b
 INNER JOIN divtbl AS d
	ON b.Division = d.Division
 ORDER BY 1, 2;
 
-- 3번 문제
INSERT INTO divtbl
(Division, Names)
VALUES
('I002', '네트워크');

-- 4번 문제
UPDATE membertbl
   SET Names = '성명건'
     , Levels = 'D'
     , mobile = '010-9839-9999'
 WHERE memberIdx = '1';

-- 5번 문제
SELECT IFNULL(d.Names, '--합계--') AS '장르'
     , CONCAT(FORMAT(SUM(b.Price), '0,000'), '원') AS '장르별총합계' 
  FROM bookstbl AS b
 INNER JOIN divtbl AS d
	ON b.Division = d.Division
    GROUP BY d.Names WITH ROLLUP;
    

-- 노가다로 삽질해서 결과값만 같게 나온 5번 문제
 SELECT IFNULL((SELECT Names 
		 FROM divtbl
		WHERE Division = bb.Division), '--합계--') AS '장르'
			, bb.장르별총합계
  FROM(SELECT b.Division
			, CONCAT(FORMAT(SUM(b.Price), '0,000'), '원') AS '장르별총합계'
		 FROM bookstbl AS b
		GROUP BY b.Division WITH ROLLUP
	  ) AS bb
 ORDER BY FIELD(장르, 'SF/판타지', '공포/스릴러', '로맨스', '무협', '전쟁/역사', '추리', '--합계--') ASC;