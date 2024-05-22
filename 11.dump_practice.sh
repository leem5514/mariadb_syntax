# local 에서 sql 덤프 파일 생성
mysqldump -u [username] -p [password] [database_name] > dumpfile.sql
mysqldump -u root -p --default-character-set=utf8mb4 board > dumpfile.sql
# 한글 깨질 떄 
mysqldump -u root -p board -r dumpfile.sql

# dump 파일을 github에 업로드