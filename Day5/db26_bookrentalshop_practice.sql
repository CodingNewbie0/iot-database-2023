/* BookRentalShop 연습 */
SELECT *
  FROM divtbl;
  
-- 서브쿼리 - 성능이 떨어지는 영향(좋지않음)
SELECT b.Author AS '저자' -- 1
  -- , b.Division AS '장르' -- 2 주석처리로 번호 순서가 바뀜
     , (SELECT Names FROM divtbl WHERE Division = b.Division) AS '장르' -- 2
     , b.Names AS '책제목' -- 3
     , b.ISBN -- 4
     , b.price AS '금액' -- 5
  FROM bookstbl AS b
 ORDER BY 3 ASC; -- 책제목으로 정렬, 3 => b.Names 대신 사용
 
-- 조인 - 서브쿼리 쓸이유가 없어지게 만든것 이거쓰기 ㅇㅇ
SELECT b.Author AS '저자' 
  -- , b.Division
     , d.Names AS '장르'
     , b.Names AS '책제목' 
     , b.ISBN 
     , b.price AS '금액' 
  FROM bookstbl AS b
 INNER JOIN divtbl AS d
	ON b.Division = d.Division
 ORDER BY 3;
 
-- 둘다 똑같은 기능을 하지만 데이터가 많아질수록 서브쿼리는 엄청 느리고 조인은 엄청 빠름.
-- 서브쿼리는 어쩔 수없이 쿼리를 조정해야할때 사용함.
 
-- 서브쿼리 - 장르로 그룹핑(계산에 도움됨)
SELECT (SELECT Names 
		  FROM divtbl
		 WHERE Division = bb.Division) AS '장르'
	 , bb.총합
  FROM(
	   SELECT b.Division
			, SUM(b.Price) AS '총합'
		 FROM bookstbl AS b
		GROUP BY b.Division
	  ) AS bb;

-- 내부조인 - 테이블 3개
SELECT m.NAmes AS '이름'
	 , m.Addr AS '주소'
     , m.Mobile AS '연락처'
     , r.rentalDate AS '대여일'
     , r.returnDate AS '반납일'
     , b.Names AS '책제목'
     , d.Names AS '장르'
     , b.Price AS '금액'
  FROM membertbl AS m
 INNER JOIN rentaltbl AS r
	ON m.memberIdx = r.memberIdx
 INNER JOIN bookstbl AS b
	ON r.bookIdx = b.bookIdx
 INNER JOIN divtbl AS d
	ON b.Division = d.Division
 ORDER BY 1;
 
-- 외부조인
SELECT m.NAmes AS '이름'
	 , m.Addr AS '주소'
     , m.Mobile AS '연락처'
     , r.rentalDate AS '대여일'
     , IFNULL(r.returnDate, '미반납') AS '반납일'
     , b.Names AS '책제목'
     , d.Names AS '장르'
     , b.Price AS '금액'
  FROM membertbl AS m
 LEFT OUTER JOIN rentaltbl AS r
	ON m.memberIdx = r.memberIdx
 LEFT OUTER JOIN bookstbl AS b
	ON r.bookIdx = b.bookIdx
 LEFT OUTER JOIN divtbl AS d
	ON b.Division = d.Division
 WHERE r.rentalIdx IS NULL
 ORDER BY 1;
 
-- 책을 두권이상 출판한 저자
SELECT bb.저자 -- bb.Division
	 , d.Names AS '장르', bb.출판권수, bb.합계금액
  FROM (
		SELECT b.Author AS '저자'
			 , b.Division
			 , COUNT(b.Author) AS '출판권수'
			 , SUM(b.Price) AS '합계금액'
		  FROM bookstbl AS b
		 GROUP BY b.Author, b.Division
		HAVING COUNT(b.Author) >= 2
	   ) AS bb
 INNER JOIN divtbl AS d
	ON bb.Division = d.Division
 ORDER BY bb.출판권수 DESC;