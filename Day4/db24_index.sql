USE tabledb;

CREATE TABLE TBL1 (
	ID int NOT NULL PRIMARY KEY,
    bridge int NULL,
    contents VARCHAR(5000)
);

-- sqldb DB의 usertbl 데이터중 userID, name, birthYear, addr만 가져와서 tabledb.usertbl에 부어넣은것
INSERT INTO tabledb.usertbl
SELECT userID, name, birthYear, addr
  FROM sqldb.usertbl;
  
SELECT * FROM usertbl WHERE name = '김범수';