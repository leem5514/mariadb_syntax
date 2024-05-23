# local 에서 sql 덤프 파일 생성
mysqldump -u [username] -p [password] [database_name] > dumpfile.sql
mysqldump -u root -p --default-character-set=utf8mb4 board > dumpfile.sql
# 한글 깨질 떄 
mysqldump -u root -p board -r dumpfile.sql

# dump 파일을 github에 업로드

# 리눅스에서 mariadb 서버 설치
sudo apt-get install mariadb-server

# mariadb 서버 시작
sudo systemctl start mariadb

# mariadb 접속 테스트
sudo mariadb -u root -p

# 깃 설치
sudo apt install git

# git을 통해서 repo clon
git clone 레파지토리 주소

# 
mysql -u root -p board > dumpfile.sql
