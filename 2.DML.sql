-- 데이터 삽입
INSERT INTO 테이블명(컬럼1, 컬럼2, 컬럼3) VALUES (데이터1, 데이터2, 데이터3);

insert into author(id, name, email) values (1, 'lee', 'aa@aa');

-- select : 데이터 조회, * : 모든 컬럼 조회
select * from author;

insert into posts(id, title, content, author_id) values (1, 't1', 'c1', 1);

-- 테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'posts';

-- 다른 스키마나, 다른 테이블 조회시
select * from board.author; -- 다른 스키마에서 조회를 원할 때 사용
select * from board;   


-- update [테이블명] set 컬럼명=데이터 where id =1;
-- where문이 없을 경우, 모든 데이터의 update문을 실행하기 떄문에 유의!
update author set name='abc', email='abc@test.com' where id =1;
update author set email='abc2@test.com' where id=2;

-- delete from 테이블명 where 조건
--  where 조건이 생략될 경우, 모든 데이터가 삭제되니 조심.
delete from author where id =5;

-- SELECT 의 다양한 조회 방법
select * from author;
select * from author where id = 1;
select * from author where id > 2 && name = 'oh';


-- 특정 컬럼만으로 조회할 때
select name, email from author where id = 3;

-- 중복 제거하고 조회하기
select distinct title from post;

-- 정렬 : order by, 데이터의 출력결과를 특정 기준으로 정렬
-- 아무런 정렬 조건 없이 조회할 경우 PK 기준으로 오름차순 정렬
-- asc: 오름차순 , desc : 내림차순
select * from author order by name;

-- 멀티 order by : 여러 컬럼으로 정렬, 먼저 쓴 컬럼 우선 정렬, 중복시 그 다음 정렬옵션 적용
select * from post order by title;  -- asc, desc 기준 오름차순
select * from post order by title, id desc;

-- limit number : 특정숫자 결과값 개수 제한
select * from author order by id desc limit 1;

-- alias(별칭)을 이용한  select : as 키워드 사용
select name as 이름, email as 이메일 from author;
select a.name as 이름, a.email as 이메일 from author as a;

-- null을 조회 조건으로
select * from post where author_id is null;
select * from post where author_id is not null;




