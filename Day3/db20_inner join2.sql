-- INNER JOIN
SELECT s.stdName, s.addr, c.clubName, c.roomNo
  FROM stdtbl AS s
  JOIN stdclubtbl AS j
    ON s.stdName = c.stdName
  JOIN clubtbl AS c
    ON c.clubName = j.clubName