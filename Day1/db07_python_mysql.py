# Python에서 MySQL 접근(연동)
import pymysql

# localhost 자기자신 = 127.0.0.1
conn = pymysql.connect(host='localhost', user='root', password='12345',
                       db='homeplus', charset='utf8')

cur = conn.cursor()
sql = 'SELECT * FROM membertbl'
cur.execute(sql) # 쿼리문 실행
rows = cur.fetchall()
print(rows)
conn.close() # DB는 접속후 반드시 닫아줘야 함!!