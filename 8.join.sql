-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 변환. on 조건을 통해 교집합  찾기
select * from post inner join author on author.id = post.author_id;
select * from author a inner join post p on a.id = p.author_id;

-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents, a.email from post p inner join author a on p.author_id = a.id;

-- 모든 글 목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력
select p.id, p.title, p.contents, a.email from post p left outer join author a on p.author_id = a.id;

-- join된 상황에서의 where 조건 : on 뒤 where조건이 나옴
-- 1) 글쓴이가 있는 글 중에 글의 title과 저자의 email을 출력, 저자의 나이는 25세 이상만 뽑아라
select p.title, a.email from  post p inner join author a on p.author_id = a.id where a.age >= 25;

-- 2) 모든 글 목록 중의 글의 title과 저자가 있다면 email 출력, 2024-05-01 이후에 만들어진 글만 출력
select p.title , a.email from post p left join author a on a.id = p.author_id where p.create_time >= 2024-05-01;

-- (실습)프로그래머스 조건에 맞는 도서와 저자 리스트 출력하기
SELECT b.BOOK_ID, a.AUTHOR_NAME, DATE_FORMAT(b.PUBLISHED_DATE, "%Y-%m-%d") as PUBLISHED_DATE FROM AUTHOR a INNER join BOOK b on a.AUTHOR_ID = b.AUTHOR_ID WHERE b.CATEGORY = '경제' ORDER BY b.PUBLISHED_DATE DESC;


-- union : 중복제외한 두 테이블의 select 결합
-- 컬럼의 개수와 타입이 같아야함
-- union all : 중복포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from tables2;
-- author 테이블의 name, email, 그리고 post 테이블의 title, contents union
select name, email from author union select title, contents from post;

-- 서브쿼리 : select 문 안에 또 다른 select 문이 있는 쿼리
-- select 절 안의 서브쿼리
-- author email 과 해당 author 가 쓴 글의 개수 출력
select email, (select count(*) from post p where p.author_id = a.id)  from author a;
-- from 절 안의 서브쿼리
select a.name from (select * from author) as a; 
-- where 절 안의 서브쿼리
select a.* from author a inner join post p on a.id = p.author_id;
select * from author where id in (select author_id from post);


-- 프로그래머스 (실습) 없어진 기록 찾기
select animal_id, name from animal_outs where animal_id not in (select animal_id from animal_ins);

select ao.animal_id, ao.name from animal_outs ao left join animal_ins ai on ao.animal_id = ai.animal_id where ai.animal_id is null ;

-- 집계함수
select count(*) from author;
select sum(price) from post; 
select round(avg(price), 0) from post; -- round 반올림

-- group by와 집계함수
select author_id from post group by author_id;
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price), round(avg(price), 0), min(price), max(price) from post group by author_id;

-- 저자 email, 해당저자가 작성한 글 수 를 출력
select email from post group by author_id;
select a.id , if(p.id is null, 0 , count(*)) from author a left join post p on a.id = p.author_id group by a.id;

--  where 와 group by
-- 연도별 post 글 출력, 연도가 null 인 데이터는 제외
select date_format(created_time, '%Y')as year, count(*) from post where created_time is not null group by year;

-- 자동차 종류 별 특정 옵션 포하마 자동차 수 구하기
SELECT car_type, count(*) as CARS from CAR_RENTAL_COMPANY_CAR
WHERE OPTIONS LIKE '%통풍시트%' OR OPTIONS LIKE '%열선시트%' OR OPTIONS LIKE '%가죽시트%' group by car_type ORDER BY CAR_TYPE;

-- 입양 시각 구하기
-- SELECT DATE_FORMAT(DATETIME, '%H') AS HOUR, COUNT(*) AS COUNT
-- FROM ANIMAL_OUTS
-- WHERE DATE_FORMAT(DATETIME, "%H:%i") >='09:00' AND DATE_FORMAT(DATETIME, "%H:%i") <='19:59'
-- GROUP BY HOUR ORDER BY HOUR;
SELECT DATE_FORMAT(DATETIME, '%H') as HOUR, count(*)AS COUNT FROM ANIMAL_OUTS
WHERE DATE_FORMAT(DATETIME, "%H:%i") between '09:00' and '19:59'
GROUP BY HOUR ORDER BY HOUR;

-- HAVING : group by 를 통해서 나온 통계에 대한 조건
select author_id, count(*) from post group by author_id;
select author_id, count(*) as count from post group by author_id having count >=2;

-- (실습) 포스팅 price가 2000 이상인 글을 대상으로, 작성자별로 몇건인지와 평균 price을 구하되, 평균 price가 3000 이상인 데이터를 대상으로만 통계 출력
select author_id, count(*) as count, round(avg(price),0) as avg from  post
where price >= 2000
group by author_id having avg > 3000;

-- (실습) 동명 동물 수 찾기
SELECT NAME, COUNT(*) AS COUNT FROM ANIMAL_INS
WHERE NAME IS NOT NULL
GROUP BY NAME HAVING COUNT >= 2 ORDER BY NAME;

-- (실습) 2건 이상의 글을 쓴 사람의 ID와 EMAIL 구할건데, count, 나이는 25세 이상인 사람만 통계에 사용하고, 가장 나이 많은 사람 1명의 통계만 출력하시오.
SELECT a.id, count(a.id), a.email FROM author a inner join post p on a.id = p.author_id
WHERE a.age >= 25
group by a.id having count>=2 order by max(a.age) limit 1;

-- 다중열 group by
select author_id, title, count(*) from post
group by author_id, title;

-- 프로그래머스 (실습) 재구매가 일어난 상품과 회원 리스트 구하기
SELECT USER_ID, PRODUCT_ID FROM ONLINE_SALE
GROUP BY USER_ID, PRODUCT_ID
HAVING COUNT(*) >=2
ORDER BY USER_ID, PRODUCT_ID DESC;



