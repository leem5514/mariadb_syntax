-- tinyint는 -128 ~ 127까지 표현
-- author테이블에 age 컬럼 추가.
alter table add column age tinyint;

-- insert시에 age: 200 -> 125
insert into author(id, email, age) values(5, 'ee@ee', 125);
-- unsigned시 255까지 표현범위 확대
alter table author modify column age tinyint unsigned;
insert into author(id, email, age) values(5, 'ee@ee', 240);

-- DECIMAL 실습
alter table post add column price decimal(10,3);
describe post;

-- DECIMAL 소수점 초과 값 입력 후 짤림 확인
insert into post(id, title, price) values(6, 'hello java', 1.233123);
-- update : price 값을 1234.1 으로 설정 시
update post set price=1234.1 where id=6;


-- BLOB 바이너리데이터 실습
-- author테이블에 profile_image컬럼을 blob 형식으로 추가
ALTER TABLE author ADD COLUMN profile_image blob;

-- ENUM : 삽입될 수 있는 데이터 종류를 한정하는 데이터 타입
-- ROLE컬럼
alter table author add column role enum('user', 'admin') not null default 'user';

-- enum컬럼 실습
-- user1 insert => 에러
insert into author(id, email, role) values (10, 'abc@abc.com', 'user1');
-- user 또는 admin insert => 정상
insert into author(id, email, role) values (10, 'abc@abc.com', 'user');

-- date 타입
-- author 테이블에 birthday 컬럼을 date 으로 추가
-- 날짜 타입의 insert는 문자열 형식으로 insert
alter table author add column birthday date;
insert into author(id, email, birthday) values(13, 'test2@test.com', '2000-11-16');

-- datetime 타입
-- author, post 둘다 datetime으로 created_time 컬럼 추가
alter table author add column created_time datetime default current_timestamp;
alter table post add column created_time datetime default current_timestamp;

insert into author(id, email, birthday) values(14, 'test2@test.com', '2000-11-16');
insert into post(id, title, contents) values(7, 'head1', 'text1');

-- 비교연산자
-- and 또는 && 
select * from post where id>=2 && id<=4;
select * from post where id between 2 and 4;
-- or 또는 ||
select * from post where id<2 || id>4;
select * from post where id<2 or id>4;
-- not 또는 !
select * from post where !(id<2 or id>4);
-- null인지 안닌
select * from post where contents is null;
select * from post where contents is not null;
-- in(리스트형태), not in(리스트형태)
select * from post where id in(1,2,3,4);
select * from post where id not in(1,2,3,4);

-- like : 특정 문자를 포함하는 데이터를 조회하기 위해서 사용
select * from post where title like '%o'; -- o로 끝나는 title 검색
select * from post where title like 'h%'; -- h로 시작하는 title 검색
select * from post where title like '%llo%'; -- 단어의 중간에 llo라는 키워드가 있을 경우 검색
select * from post where title not like 'o%'; -- o로 끝나는 title을 제외한 것

-- ifnull(a,b) : 만약에 a가 null이면 b 반환, null이 아니면 a 반환
select title, contents, ifnull(author_id, '익명') as 저자 from post;

-- 프로그래머스 (실습) 경기도에 위치한 식품창고 목록 출력하기

-- REGEXP : 정규표현식을 활용한 조회 // 이 때의 조건은 정규표현식에 맞는 조건을 써야함
select * from author where name regexp '[a-z]';
select * from author where name regexp '[가-힣]';

-- 날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜
-- CAST 와 CONVERT
SELECT CAST(20200101 AS DATE);
SELECT CAST('20190101' AS DATE);
SELECT CONVERT(2020010, DATE);
SELECT CONVERT('20190101', DATE);

-- DATETIME 조회 방법
SELECT * FROM post WHERE created_time like "2024-11%";
SELECT * FROM post WHERE created_time <= '2024-01-01' AND created_time >='2000-01-01';
SELECT * FROM post WHERE created_time BETWEEN '2024-12-31' AND '2000-01-01';
-- DATE FORMAT (시간(Y) 만 대문자, 분(m) 부터는 소문자)
SELECT DATE_FORMAT(created_time, '%Y-%m') FROM post;

-- (실습) post을 조회할 떄 date_format을 활용하여 2024년 데이터 조회, 결과는 *
select * from post where date_format(created_time, '%Y')="2024";

-- 오늘 날짜 출력 함수
select now();

-- 프로그래머스 (실습) : 흉부외과 또는 일반외과 의사 목록 출력하기
SELECT DR_NAME, DR_ID, MCDP_CD, date_format(HIRE_YMD, '%Y-%m-%d') AS HIRE_YMD FROM  DOCTOR WHERE MCDP_CD='CS' || MCDP_CD='GS' ORDER BY HIRE_YMD DESC, DR_NAME ASC;








