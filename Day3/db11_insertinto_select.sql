-- INSERT INTO SELECT
-- usertbl에서 앞에 네개 컬럼 값을 가져와서 usertbl_bak에 집어넣기
INSERT INTO usertbl_bak (userID, name, birthYear, addr)
SELECT userID, name, birthYear, addr FROM usertbl;
