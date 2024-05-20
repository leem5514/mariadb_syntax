-- 데이터베이스 접속
mariadb -u root -p

-- 스키마(database) 목록조회
show databases;

--  board 데이터베이스(스키마) 생성
CREATE DATABASE board;

-- 데이터베이스 선택
use board;

-- 테이블 선택 
show tables;

-- author 테이블 생성
CREATE TABLE author (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
);

-- 테이블 컬럼 조회
describe author;

-- 컬럼 상세 조회
SHOW FULL COLUMNS FROM author;

-- 테이블 생성문 조회
SHOW CREATE TABLE author;

-- post 테이블 신규 생성(id, title, content, author_id)
create table posts(
    id INT PRIMARY KEY,
    title VARCHAR(255),
    content VARCHAR(255),
    author_id INT,
    FOREIGN KEY(author_id) REFERENCES author(id)
);

-- 데이터베이스 삭세
DROP DATABASE [스키마명];

-- 테이블 index 조회
show index from author;
show index from posts;

-- ALTER문 : 테이블의 구조를 변경
-- 테이블 이름 변경
ALTER TABLE posts RENAME post;
-- 테이블 컬럼 추가
ALTER TABLE author ADD COLUMN test1 VARCHAR(50);
-- 테이블 컬럼 삭제
ALTER TABLE author DROP COLUMN test1;
-- 테이블 컬럼명 변경
ALTER TABLE post CHANGE COLUMN content contents VARCHAR(255);
-- 테이블 컬럼 타입과 제약조건 변경
ALTER TABLE author MODIFY COLUMN email VARCHAR(255) NOT NULL;


-- 실습: author 테이블에 address 컬럼 추가 varchar(255)
alter table author ADD column address varchar(255);

-- 실습 : post 테이블에 title은 not null 제약조건 추가, contents는 3000자로 변경
alter table post modify column title varchar(255) not null;
alter table post modify column contents varchar(3000);

-- 테이블 삭제
drop 테이블명;




CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
)